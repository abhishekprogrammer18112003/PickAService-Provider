import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:pick_a_service/core/app_imports.dart';
import 'package:pick_a_service/core/managers/shared_preference_manager.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService {
  Timer? _timer;
  Future<void> startLocationService(bool check) async {
    // Check and request location permission if not granted
    var status = await Permission.locationWhenInUse.request();
    if (status.isGranted) {
      print("Status is Granted");
      _timer?.cancel();
      check ? _getLocationUpdates() : _getLocationUpdates20sec();
    } else {
      // Handle if permission is denied
    }
  }

  Future<void> _getLocationUpdates() async {
    _getCurrentLocation();

    _timer = Timer.periodic(Duration(minutes: 15), (timer) async {
      print("10minutes");
      _getCurrentLocation();
    });
  }

  Future<void> _getLocationUpdates20sec() async {
    _getCurrentLocation();

    _timer = Timer.periodic(Duration(seconds: 15), (timer) async {
      print("20 seconds");
      _getCurrentLocation();
    });
  }
  LocationServiceProvider locationServiceProvider = LocationServiceProvider();

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      // Upload position to backend
      locationServiceProvider.sendLocationToBackend(position);
    } catch (e) {
      print(e);
    }
  }
}

class LocationServiceProvider extends ChangeNotifier {
  double _lat = 0.0, _long = 0.0;
  double get lat => _lat;
  double get long => _long;

  Future<void> sendLocationToBackend(Position position) async {
    int techId = SharedPreferencesManager.getInt("user_id");
    String jwt_token = SharedPreferencesManager.getString("jwt_token");


    print(position.latitude);
    print(position.longitude);

    try {
      var headers = {'Content-Type': 'application/json' , 'token' : jwt_token};
      Map<String, dynamic> body = {
        "technicianId": techId,
        "lat": position.latitude,
        "long": position.longitude,
      };
      http.Response response = await http.post(Uri.parse(POSTLOCATION),
          headers: headers, body: jsonEncode(body));

      print(response);
      var data = jsonDecode(response.body);
      print(data);
      if (response.statusCode == 200) {
        _lat = position.latitude;
        _long = position.longitude;

        notifyListeners();
      } else {}
    } catch (e) {
      throw e;
    }
  }
}

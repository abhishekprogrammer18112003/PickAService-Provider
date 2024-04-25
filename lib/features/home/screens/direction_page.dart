// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pick_a_service/features/home/models/accepted_models.dart';
import 'package:pick_a_service/location_service.dart';

class DirectionPage extends StatefulWidget {
  AcceptedOrdersModel arguments;
  DirectionPage({super.key, required  this.arguments});

  @override
  State<DirectionPage> createState() => _DirectionPageState();
}

class _DirectionPageState extends State<DirectionPage> {
  LocationServiceProvider locationServiceProvider = LocationServiceProvider();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final FocusScopeNode _focusScopeNode = FocusScopeNode();
  static late double latitude;
  static late double longitude;
  final mapController = MapController(
      initMapWithUserPosition: UserTrackingOption(enableTracking: true));
  bool _isClicked = false;
  Future<void> _getUserLocation() async {
    final GeolocatorPlatform geolocator = GeolocatorPlatform.instance;

    try {
      Position position = await geolocator.getCurrentPosition();

      latitude = position.latitude;
      longitude = position.longitude;
      MapController.withPosition(
          initPosition: GeoPoint(
              // latitude: locationServiceProvider.lat,
              // longitude: locationServiceProvider.long,
              latitude: latitude,
              longitude: longitude
              ));

      configs = [
        MultiRoadConfiguration(
          startPoint: GeoPoint(
              //     latitude: locationServiceProvider.lat,
              // longitude: locationServiceProvider.long,
              latitude: latitude,
              longitude: longitude
              ),
          destinationPoint: GeoPoint(
            // latitude: 47.4046149269,
            // longitude: 8.5046595453,
            latitude: widget.arguments.Latitude,
            longitude: widget.arguments.Longitude
          ),
        ),
      ];
    } catch (e) {
      print('Error getting location: $e');
    }
  }
Timer? _timer ;
  @override
  void initState() {
    super.initState();
    _getUserLocation();
    _timer = Timer.periodic(Duration(seconds: 20), (v){
      _getUserLocation();
      // setState(() {
        
      // });
    });
  }

  @override
  void dispose(){
    super.dispose();
    _timer!.cancel();
  }

  late final configs; 

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_focusScopeNode.hasFocus) {
          _focusScopeNode.unfocus();
        }
      },
      child: Scaffold(key: _scaffoldKey, body: _buildMap()),
    );
  }

  _buildMap() => OSMFlutter(
      controller: mapController,
      mapIsLoading: const Center(child: CircularProgressIndicator()),
      onMapIsReady: (isReady) async {
        if (isReady) {
          // await mapController.drawCircle(CircleOSM(
          //   key: "circle0",
          //   centerPoint: GeoPoint(latitude: latitude, longitude: longitude),
          //   radius: 100.0,
          //   color: Colors.blue,
          //   strokeWidth: 0.3,
          // ));
  
          await mapController.drawMultipleRoad(
            configs,
            commonRoadOption: const MultiRoadOption(
              roadColor: Colors.red,
            ),
          );
        }
      },
      osmOption: OSMOption(
        userTrackingOption: const UserTrackingOption(
          enableTracking: true,
          unFollowUser: false,
        ),
        zoomOption: const ZoomOption(
          initZoom: 16,
          minZoomLevel: 2,
          maxZoomLevel: 19,
          stepZoom: 1.0,
        ),
        userLocationMarker: UserLocationMaker(
          personMarker: const MarkerIcon(
            icon: Icon(
              Icons.location_on,
              color: Colors.red,
              size: 48,
            ),
          ),
          directionArrowMarker: const MarkerIcon(
            icon: Icon(
              Icons.double_arrow,
              size: 48,
            ),
          ),
        ),
        roadConfiguration: const RoadOption(
          roadColor: Colors.yellowAccent,
        ),
        // markerOption: MarkerOption(
        //     defaultMarker: const MarkerIcon(
        //   icon: Icon(
        //     Icons.person_pin_circle,
        //     color: Colors.blue,
        //     size: 56,
        //   ),
        // )),
      ));
}

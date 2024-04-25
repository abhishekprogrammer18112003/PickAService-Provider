import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../core/app_imports.dart';
import 'custom_text_field.dart';

class LocationSelectorPage extends StatefulWidget {
  final LocationType type;
  const LocationSelectorPage({super.key, required this.type});

  @override
  _LocationSelectorPageState createState() => _LocationSelectorPageState();
}

enum LocationType { hospital, university, general }

class _LocationSelectorPageState extends State<LocationSelectorPage> {
  final TextEditingController _searchController = TextEditingController();
  final List<LocationResult> _searchResults = [];

  Future<void> searchLocations(String query) async {
    const apiKey = 'AIzaSyDcJEyVlerTAcnP9x2GmuEd8UdMc0CJ7yU';
    const endpoint =
        'https://maps.googleapis.com/maps/api/place/textsearch/json';
    var url = '$endpoint?query=$query&key=$apiKey';

    if (widget.type == LocationType.general) {
    } else {
      url = '$endpoint?query=$query&key=$apiKey&type=${widget.type.name}';
    }

    // autocompletionRequest={{
    //             componentRestrictions: { country: "in" },
    //             types: ["hospital"],
    //           }}

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final results = jsonData['results'];

      setState(() {
        _searchResults.clear();
        _searchResults.addAll(
          results
              .map<LocationResult>((result) => LocationResult.fromJson(result))
              .toList(),
        );
      });
    } else {
      print('Error: ${response.statusCode}');
    }
  }

  void selectLocation(String selectedLocation) {
    Navigator.pop(context, selectedLocation);
  }

  String splitByLastThreeCommas(String input) {
    List<String> splitList = input.split(',');
    int start = splitList.length - 3;
    int end = splitList.length - 1;

    String lastThree = splitList.sublist(start, end).join(',');

    return lastThree;
  }

  Widget _buildCreateButton(String value, Function onTap) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomSpacers.width20,
          Container(
            width: 20,
            height: 20,
            decoration: const ShapeDecoration(
              shape: CircleBorder(side: BorderSide(color: AppColors.primary)),
              color: AppColors.white,
            ),
            child: const Icon(
              Icons.add,
              color: AppColors.primary,
              size: 15,
            ),
          ),
          CustomSpacers.width8,
          Text(
            'Select $value',
            style: AppTextStyles.textStyle14w400Secondary.copyWith(
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: false,
          backgroundColor: AppColors.lightGrey,
          title: CustomTextField(
            controller: _searchController,
            autoFocus: true,
            hint: "Search Places",
            suffix: const Icon(Icons.search),
            onChanged: (changed) {
              setState(() {});
              if (changed.length > 3) {
                searchLocations(changed);
              }
            },
          )),
      body: _searchResults.isEmpty && _searchController.text.isEmpty
          ? Center(
              child: Text('Search ${widget.type.name}'),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_searchController.text.isNotEmpty)
                    ListTile(
                      leading: Container(
                        width: 20,
                        height: 20,
                        decoration: const ShapeDecoration(
                          shape: CircleBorder(
                              side: BorderSide(color: AppColors.primary)),
                          color: AppColors.white,
                        ),
                        child: const Icon(
                          Icons.add,
                          color: AppColors.primary,
                          size: 15,
                        ),
                      ),
                      title: Text(
                        'select "${_searchController.text}"',
                        style: const TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600),
                      ),
                      onTap: () {
                        selectLocation(_searchController.text);
                      },
                    ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _searchResults.length,
                    itemBuilder: (context, index) {
                      final location = _searchResults[index];
                      return ListTile(
                        leading: const Icon(Icons.location_on,
                            color: AppColors.lightGreyBorder),
                        title: Text(location.name,
                            style: AppTextStyles.textStyleLato14w500Primary),
                        subtitle: Text(
                            splitByLastThreeCommas(location.address).toString(),
                            style: AppTextStyles.fs12Fw400Lh18),
                        onTap: () {
                          selectLocation(location.name);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}

class LocationResult {
  final String name;
  final String address;
  LocationResult({required this.name, required this.address});

  factory LocationResult.fromJson(Map<String, dynamic> json) {
    return LocationResult(
        name: json['name'], address: json['formatted_address'].toString());
  }
}

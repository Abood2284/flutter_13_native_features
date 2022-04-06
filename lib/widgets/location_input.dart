import 'package:flutter/material.dart';
import 'package:location/location.dart';

import '../helper/location_helper.dart';

class LocationInputWidget extends StatefulWidget {
  const LocationInputWidget({Key? key}) : super(key: key);

  @override
  State<LocationInputWidget> createState() => _LocationInputWidgetState();
}

class _LocationInputWidgetState extends State<LocationInputWidget> {
  // Used to store Network Image url returned by google api
  String? _previewImageUrl;

  Future<void> _getLocationData() async {
    // Returns a Future which yields the current location
    final userLocation = await Location()
        .getLocation(); // Coming from the location package we imported
    final _returnedStaticLink = LocationHelper.generateLocationPreviewImage(
        userLocation.longitude!, userLocation.latitude!);
    setState(() {
      _previewImageUrl = _returnedStaticLink;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            border: Border.all(color: Colors.grey, width: 1),
          ),
          width: double.infinity,
          alignment: Alignment.center,
          height: 170,
          child: _previewImageUrl == null
              ? const Text(
                  'No location choosen',
                  textAlign: TextAlign.center,
                )
              : Image.network(_previewImageUrl!,
                  fit: BoxFit.cover, width: double.infinity),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: _getLocationData,
              icon: const Icon(Icons.location_on),
              label: const Text('Current location'),
            ),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.map),
              label: const Text('Select location on map'),
            ),
          ],
        ),
      ],
    );
  }
}

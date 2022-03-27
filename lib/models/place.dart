import 'dart:io'; // to get access to File data type

// as latitide & longitude defines any place on earth so combination of this can show you any place
class PlaceLocation {
  final double latitude;
  final double longitude;
  final String? placeName;

  PlaceLocation(
      {required this.latitude, required this.longitude, this.placeName});
}

class Place {
  final String id;
  final String title;
  final PlaceLocation location;
  final File image; // Because we are going to store image on the user Device

  Place({
    required this.id,
    required this.title,
    required this.location,
    required this.image,
  });
}

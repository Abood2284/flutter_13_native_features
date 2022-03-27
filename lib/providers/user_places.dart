import 'dart:io';

import 'package:flutter/foundation.dart';

import '../models/place.dart';

class UserPlaces with ChangeNotifier {
  final List<Place> _places = [];

  // Return copy of original list...
  List<Place> get places {
    return [..._places];
  }

  void addPlace(String pickedTitle, File pickedImage) {
    final newplace = Place(
      id: DateTime.now().toString(),
      image: pickedImage,
      title: pickedTitle,
      location: null,
    );
    _places.add(newplace);
    notifyListeners();
  }
}

import 'dart:io';

import 'package:flutter/foundation.dart';

import '../models/place.dart';
import '../helper/db_helper.dart';

class UserPlaces with ChangeNotifier {
  List<Place> _places = [];

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

    /// * 👉🏼 The keys you use here have to match the fields you set up in the CREATE TABEL.... query
    DBHelper.insert('user_places', {
      'id': newplace.id,
      'title': newplace.title,
      'image': newplace.image.path
    });
  }

  Future<void> fetchAndSetData() async {
    final dataList = await DBHelper.getData('user_places');

    /// SO our map will have id key we have id filed in our table when we created it in DB helper class
    ///
    /// Also our table have images as text(that holds path to the file) not File, but dart got us coveredt File() takes a string path to the file which it will convert to File type
    _places = dataList
        .map(
          (item) => Place(
            id: item['id'],
            location: null,
            title: item['title'],
            image: File(
              item['image'],
            ),
          ),
        )
        .toList();
    notifyListeners();
  }
}

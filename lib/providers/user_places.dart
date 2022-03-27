import 'package:flutter/foundation.dart';

import '../models/place.dart';

class UserPlaces with ChangeNotifier {
  final List<Place> _places = [];
  // Return copy of original list...
  List<Place> get places {
    return [..._places];
  }
}

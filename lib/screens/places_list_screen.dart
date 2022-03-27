import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './add_place_screen.dart';
import '../providers/user_places.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
              },
              icon: const Icon(Icons.add)),
        ],
      ),
      body: SafeArea(
        child: Consumer<UserPlaces>(
          builder: (ctx, userPlaces, ch) => userPlaces.places.isEmpty
              ? ch!
              : ListView.builder(
                  itemCount: userPlaces.places.length,
                  itemBuilder: (ctx, i) => ListTile(
                    leading: CircleAvatar(
                      backgroundImage: FileImage(userPlaces.places[i].image),
                    ),
                    title: Text(userPlaces.places[i].title),
                    onTap: () {
                      // Go to Detail screen...
                    },
                  ),
                ),
          child: const Center(
            child: Text('Got no places, get some by adding!'),
          ),
        ),
      ),
    );
  }
}

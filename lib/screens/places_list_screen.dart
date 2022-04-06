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
        child: FutureBuilder(
          // Here is set it to false coz i dont want to re-redner everything and yes it will build everything if i set to true, i just want to re-built the condumer Child which is already re-building and Listeneing
          future:
              Provider.of<UserPlaces>(context, listen: false).fetchAndSetData(),
          builder: (ctx, snapShot) => snapShot.connectionState ==
                  ConnectionState.waiting
              ? const CircularProgressIndicator()
              : Consumer<UserPlaces>(
                  builder: (ctx, userPlaces, ch) => userPlaces.places.isEmpty
                      ? ch!
                      : ListView.builder(
                          itemCount: userPlaces.places.length,
                          itemBuilder: (ctx, i) => ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  FileImage(userPlaces.places[i].image),
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
      ),
    );
  }
}

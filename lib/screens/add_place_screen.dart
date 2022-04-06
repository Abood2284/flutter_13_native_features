import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/image_input.dart';
import '../providers/user_places.dart';
import '../widgets/location_input.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = 'add-place';

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _textController = TextEditingController();
  File? _pickedImage;

  /// Function only the serve the purpose of getting File image from [ImageInputWidget]
  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _savePlace() {
    if (_textController.text.isEmpty || _pickedImage == null) {
      return;
    }
    Provider.of<UserPlaces>(context, listen: false)
        .addPlace(_textController.text, _pickedImage!);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a New Place'),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Expanded(
            child: SingleChildScrollView(
                child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Title'),
                controller: _textController,
              ),
              const SizedBox(
                height: 10,
              ),
              ImageInputWidget(_selectImage),
              const SizedBox(height: 10),
              const LocationInputWidget(),
            ],
          ),
        ))),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            primary: Theme.of(context).colorScheme.secondary,
            onPrimary: Colors.black,
          ),
          onPressed: _savePlace,
          icon: const Icon(Icons.add),
          label: const Text('Add place'),
        ),
      ]),
    );
  }
}

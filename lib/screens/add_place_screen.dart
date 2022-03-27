import 'package:flutter/material.dart';
import 'package:flutter_13_native_eatures/widgets/image_input.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = 'add-place';

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _textController = TextEditingController();

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
              const ImageInputWidget(),
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
          onPressed: () {},
          icon: const Icon(Icons.add),
          label: const Text('Add place'),
        ),
      ]),
    );
  }
}

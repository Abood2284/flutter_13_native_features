import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInputWidget extends StatefulWidget {
  const ImageInputWidget({Key? key}) : super(key: key);

  @override
  State<ImageInputWidget> createState() => _ImageInputWidgetState();
}

class _ImageInputWidgetState extends State<ImageInputWidget> {
  File? _storedImage;

  Future<void> _takePicture() async {
    final _imagePicker = ImagePicker();
    final _imagePicked = await _imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: _storedImage != null
              ? Image.file(
                  _storedImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : const Text('No image Selected', textAlign: TextAlign.center),
          alignment: Alignment.center,
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
            child: TextButton.icon(
          onPressed: _takePicture,
          label: const Text('Take Picture'),
          icon: const Icon(Icons.camera),
          style: TextButton.styleFrom(
            primary: Theme.of(context).primaryColor,
          ),
        )),
      ],
    );
  }
}

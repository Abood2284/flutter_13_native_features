import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInputWidget extends StatefulWidget {
  final Function selectedImageFunction;

  const ImageInputWidget(this.selectedImageFunction);

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
    // Because can tap the take picture and dont click any picture in that case _imagePicker will return null and we will be trying to save null image on drive.
    if (_imagePicked == null) {
      return;
    }
    setState(() {
      /// Becuase [_imagePicked] is of type XFile
      _storedImage = File(_imagePicked.path);
    });

    /// * Storing the image on the device Hard Drive.
    /// * Once the app is deleted all the data to it (images) will be deleted by the OS -> thats good.
    ///
    /// * Here we are storing in Documents Directory where all apps Data is managed, more DIR can be seen by your IDE preview
    ///
    /// * Once we get the DIR then we choose to use our image name same as the image name given to it by the camera (yes the cryptic one _image0840398430.png)
    ///
    /// * Then we copy our image stored in variable into appDirectory with giving our name to the file using /
    final appDirectory = await syspaths.getApplicationDocumentsDirectory();

    /// * path.basename gets you to the last of the path where name is stored i.e: path/doc/{you are here give ur name}
    final fileName = path.basename(_storedImage!.path);
    _storedImage!.copy('${appDirectory.path}/$fileName');
    widget.selectedImageFunction(_storedImage);
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

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../di.dart';

class ImagePickerWidget extends StatefulWidget {
  final Function(File?) onImageSelected;
   File? pickedImage;

   ImagePickerWidget({Key? key, required this.onImageSelected, required this.pickedImage}) : super(key: key);

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
 final ImagePicker picker = locator<ImagePicker>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 300,
      child: widget.pickedImage != null
          ? _imagePickedByUser(widget.pickedImage)
          : GestureDetector(
        onTap: () => _showPicker(context),
        child: Container(
          color: Theme.of(context).cardColor,
          width: 200,
          height: 300,
          child: Icon(
            Icons.camera_alt,
            color: Theme.of(context).textTheme.titleMedium!.color,
          ),
        ),
      ),
    );
  }

  Widget _imagePickedByUser(File? image) {
    if (image != null && image.path.isNotEmpty) {
      return Image.file(image);
    } else {
      return Container(
        color: Theme.of(context).cardColor,
        width: 200,
        height: 300,
        child: Icon(
          Icons.camera_alt,
          color: Theme.of(context).textTheme.titleMedium!.color,
        ),
      );
    }
  }

  _showPicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Wrap(
              children: [
                ListTile(
                  trailing: const Icon(Icons.arrow_forward),
                  leading: Icon(
                    Icons.camera,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  title: const Text('Galareyadan saylan'),
                  onTap: () {
                    _imageFormGallery();
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  trailing: const Icon(Icons.arrow_forward),
                  leading: Icon(
                    Icons.camera_alt_rounded,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  title: const Text('Kameradan alyn'),
                  onTap: () {
                    _imageFormCamera();
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          );
        });
  }

 void _imageFormGallery() async {
   var image = await picker.pickImage(source: ImageSource.gallery);
   setState(() {
     widget.pickedImage = image != null ? File(image.path) : null;
   });
   widget.onImageSelected(widget.pickedImage);
 }

 void _imageFormCamera() async {
   var image = await picker.pickImage(source: ImageSource.camera);
   setState(() {
     widget.pickedImage = image != null ? File(image.path) : null;
   });
   widget.onImageSelected(widget.pickedImage);
 }
}

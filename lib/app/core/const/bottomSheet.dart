import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'package:image_picker/image_picker.dart';

import '../utils/utility.dart';

class ModalImage {
  final picker = ImagePicker();

  final Function(String) onImageSelect;

  bool isImageCroppable;

  File? newImage;

  XFile? image;

  var openGallery;

  ModalImage({required this.onImageSelect, required this.isImageCroppable});

  callGallery() async {
    image = await picker.pickImage(source: ImageSource.gallery);
    final bytes = await image!.readAsBytes();
    final kb = bytes.length / 1024;
    final mb = kb / 1024;

    if (kDebugMode) {}

    final dir = await path_provider.getTemporaryDirectory();
    final targetPath = '${dir.absolute.path}/temp.jpg';

    final result = await FlutterImageCompress.compressAndGetFile(
      image!.path,
      targetPath,
      minHeight: 1080, //you can play with this to reduce siz
      minWidth: 1080,
      quality: 90, // keep this high to get the original quality of image
    );

    final data = await result!.readAsBytes();
    final newKb = data.length / 1024;
    final newMb = newKb / 1024;

    newImage = File(result.path);

    if (Utility.isNotNullEmptyOrFalse(newImage?.path ?? '')) {
      if (isImageCroppable) {
        cropImage(newImage!.path).then((croppedImagePath) {
          if (Utility.isNotNullEmptyOrFalse(croppedImagePath)) {
            onImageSelect(croppedImagePath);
          }
        });
      } else {
        onImageSelect(newImage!.path);
      }
    }
  }

  callCamera() async {
    image = await picker.pickImage(source: ImageSource.camera);

    final bytes = await image!.readAsBytes();
    final kb = bytes.length / 1024;

    final dir = await path_provider.getTemporaryDirectory();
    final targetPath = '${dir.absolute.path}/temp.jpg';

    // converting original image to compress it
    final result = await FlutterImageCompress.compressAndGetFile(
      image!.path,
      targetPath,
      minHeight: 1080, //you can play with this to reduce siz
      minWidth: 1080,
      quality: 90, // keep this high to get the original quality of image
    );

    final data = await result!.readAsBytes();
    final newKb = data.length / 1024;

    newImage = File(result.path);

    if (Utility.isNotNullEmptyOrFalse(newImage?.path ?? '')) {
      if (isImageCroppable) {
        cropImage(newImage!.path).then((croppedImagePath) {
          if (Utility.isNotNullEmptyOrFalse(croppedImagePath)) {
            onImageSelect(croppedImagePath);
          }
        });
      } else {
        onImageSelect(newImage!.path);
      }
    }
  }

  Future<String> cropImage(String imagePath) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
        sourcePath: imagePath,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        cropStyle: CropStyle.rectangle,
        compressQuality: 70,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              showCropGrid: false,
              toolbarColor: const Color.fromARGB(240, 132, 104, 236),
              // toolbarColor: Colors.lightGreen,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          )
        ]);

    if (Utility.isNotNullEmptyOrFalse(croppedImage)) {
      return croppedImage!.path;
    } else {
      return "";
    }
  }

  mainBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 235.0,
            color: const Color.fromRGBO(0, 0, 0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text("Gallery"),
                  onTap: callGallery,
                ),
                ListTile(
                  leading: const Icon(Icons.camera),
                  title: const Text("Camera"),
                  onTap: callCamera,
                ),
                ListTile(
                  leading: const Icon(Icons.cancel),
                  title: const Text("Cancel"),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        });
  }
}

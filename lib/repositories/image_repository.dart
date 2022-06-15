import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ImageRepository {
  final FirebaseAuth firebaseAuth;
  final FirebaseStorage firebaseStorage;
  final ImagePicker picker;

  const ImageRepository({
    required this.firebaseAuth,
    required this.firebaseStorage,
    required this.picker,
  });

  String _generateFileName(File file) {
    List<String> fileNameExploded = file.path.split('/').last.split('.');
    String hashName = md5
        .convert(utf8
            .encode("${fileNameExploded.first}${DateTime.now().millisecond}"))
        .toString();

    return "$hashName.${fileNameExploded.last}";
  }

  Future<String?> takePhoto() async {
    await picker.pickImage(
      source: ImageSource.camera,
    );
    return null;
  }

  Future<String?> selectPhoto() async {
    XFile? filePicker = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (filePicker == null) {
      return null;
    }

    final File file = File(filePicker.path);

    final String uid = firebaseAuth.currentUser!.uid;

    final String fileName = _generateFileName(file);

    UploadTask task = firebaseStorage
        .ref()
        .child("users")
        .child(uid)
        .child(fileName)
        .putFile(file);

    return (await task).ref.getDownloadURL();
  }
}

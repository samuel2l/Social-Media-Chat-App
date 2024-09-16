import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseStorageRepositoryProvider = Provider(
  (ref) => FirebaseStorageRepository(
    firebaseStorage: FirebaseStorage.instance,
  ),
);

class FirebaseStorageRepository {
  final FirebaseStorage firebaseStorage;
  FirebaseStorageRepository({
    required this.firebaseStorage,
  });

  Future<String> storeFileToFirebase(String ref, File file) async {
    UploadTask uploadTask = firebaseStorage.ref().child(ref).putFile(file);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
// String ref
// ref is the path in Firebase Storage where the file will be stored. It allows you to organize files with specific folder-like structures (e.g., "images/user_profile.jpg"). It is passed as a parameter to make the function flexible so different files can be stored in different locations.
// 2. firebaseStorage.ref()
// .ref() points to the root directory of Firebase Storage. It is an entry point from which you can create references to specific file paths (directories) in storage.
// 3. .child(ref)
// .child(ref) appends the value of ref to the root reference. For example, if ref is "images/pic.jpg", Firebase Storage would store the file at that specific location within your storage.
// Upload Task: It creates an UploadTask to upload a file to Firebase Storage. firebaseStorage.ref().child(ref).putFile(file) specifies the storage path (ref) and uploads the file.

// Task Snapshot: TaskSnapshot stores the result of the upload once it's complete (await uploadTask waits for the upload to finish).

// Download URL: After the upload, snap.ref.getDownloadURL() fetches the URL to access the file.
  }
}
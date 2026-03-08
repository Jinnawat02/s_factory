import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class StorageService {
  static final FirebaseStorage _storage = FirebaseStorage.instance;
  static const Uuid _uuid = Uuid();

  /// Uploads an `XFile` to Firebase Storage.
  /// Given a [folder] like 'users' or 'machines', it uploads the file to `folder/unique-id.ext`.
  /// Returns the public download URL, or null if it fails.
  static Future<String?> uploadImage(XFile file, String folder) async {
    try {
      // Determine file extension (e.g., .jpg, .png)
      final String extension = file.path.split('.').last.toLowerCase();
      // Generate a unique file name
      final String fileName = '${_uuid.v4()}.$extension';
      final Reference ref = _storage.ref().child('$folder/$fileName');

      if (kIsWeb) {
        // On Web, we must upload the bytes directly
        final Uint8List bytes = await file.readAsBytes();
        final SettableMetadata metadata = SettableMetadata(
          contentType: 'image/$extension',
        );
        await ref.putData(bytes, metadata);
      } else {
        // On Mobile/Desktop, we can upload the File directly
        final File ioFile = File(file.path);
        await ref.putFile(ioFile);
      }

      // Retrieve and return the download URL
      return await ref.getDownloadURL();
    } catch (e) {
      debugPrint('Error uploading image to Firebase Storage: $e');
      return null;
    }
  }
}

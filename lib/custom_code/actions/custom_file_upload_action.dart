// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:mime_type/mime_type.dart';

Future<String?> customFileUploadAction(
    FFUploadedFile inputFile, String currentUserUid, bool isVideo) async {
  // Add your function code here!
  String? result;

  Future<String?> uploadData(String path, Uint8List data) async {
    final storageRef = FirebaseStorage.instance.ref().child(path);
    final metadata = SettableMetadata(contentType: mime(path));
    final result = await storageRef.putData(data, metadata);
    return result.state == TaskState.success
        ? result.ref.getDownloadURL()
        : null;
  }

  String? _removeTrailingSlash(String? path) =>
      path != null && path.endsWith('/')
          ? path.substring(0, path.length - 1)
          : path;
  String _firebasePathPrefix() => 'users/$currentUserUid/uploads';

  String _getStoragePath(
    String? pathPrefix,
    String filePath,
    bool isVideo, [
    int? index,
  ]) {
    pathPrefix ??= _firebasePathPrefix();
    pathPrefix = _removeTrailingSlash(pathPrefix);
    final timestamp = DateTime.now().microsecondsSinceEpoch;
    // Workaround fixed by https://github.com/flutter/plugins/pull/3685
    // (not yet in stable).
    final ext = isVideo ? 'mp4' : filePath.split('.').last;
    final indexStr = index != null ? '_$index' : '';
    return '$pathPrefix/$timestamp$indexStr.$ext';
  }

  String storagePath = _getStoragePath(null, inputFile.name!, isVideo);

  result =
      await uploadData(storagePath, inputFile.bytes ?? Uint8List.fromList([]));

  return result;
}

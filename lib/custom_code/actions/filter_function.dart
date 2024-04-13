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

import 'dart:io';

import 'dart:async';

Future filterFunction(FFUploadedFile? mediaFile) async {
  // Add your function code here!
// mediaFile.
  Future<int> getFileSize(File mediaFile) async {
    var completer = Completer<int>();
    int size = await mediaFile.length();
    completer.complete(size);
    return completer.future;
  }
}

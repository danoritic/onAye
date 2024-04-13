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

import 'package:google_vision/google_vision.dart';

import 'dart:convert';
import 'dart:io';

import "package:video_trimmer/video_trimmer.dart";

import 'package:path/path.dart' as p;
import "package:http/http.dart" as http;

Future<bool> actionToFilterMedia(
    FFUploadedFile fileToBeUploaded, bool isPhoto) async {
  if (fileToBeUploaded.bytes == null) {
    return false;
  }
  // Add your function code here!
  bool result = false;

  Future<File?> trimVideoTo15Seconds(Uint8List inputf) async {
    File f = await File(p.current).writeAsBytes(inputf);

    File? outputFile;

    // File.fromUri(Uri)
    final Trimmer _trimmer = Trimmer();
    await _trimmer.loadVideo(videoFile: f);
    // _trimmer.
    String? filePath;
    await _trimmer.saveTrimmedVideo(
        startValue: 0,
        endValue: 15000,
        onSave: (s) {
          filePath = s;
        });

    outputFile = ((filePath != null) ? File(filePath!) : outputFile);
    return outputFile;
  }

  Future<bool> checkIfAppropriate(Uint8List inputFile) async {
    bool result = false;
    String jwt = (await http.get(Uri.parse(
            "https://us-central1-onlife-3l26ul.cloudfunctions.net/credGetter")))
        .body;
    final googleVision = await GoogleVision.withJwt(jwt);

    print('checking apropriacy...');
    // ByteBuffer bb = File('/Users/macbookpro/Downloads/food4 (1).png')
    //     .readAsBytesSync()
    //     .buffer;
    final safesearchAnnotations = await (googleVision
            .safeSearchDetection(JsonImage.fromBuffer(inputFile.buffer)))
        .timeout(Duration(minutes: 1));
    print('checking done ' * 50);

    // JsonImage.fromBuffer(bb));

    // JsonImage);

    for (var i in safesearchAnnotations?.toJson().values ?? []) {
      if (i != "VERY_LIKELY" || i != "LIKELY") {
        result = true;
      } else {
        result = false;
      }
      // hvh
    }
    return result;
  }

  print('Almost done ' * 50);
  Uint8List? b = (!isPhoto)
      ? (await trimVideoTo15Seconds(
              (fileToBeUploaded.bytes ?? [] as Uint8List)))
          ?.readAsBytesSync()
      : fileToBeUploaded.bytes;
  bool isAproipriate = await checkIfAppropriate(b!);
  // print()
  if (isPhoto) {
    return (fileToBeUploaded.bytes!.lengthInBytes < 32 * 1024 * 1024) &&
        isAproipriate;
  }
  return (fileToBeUploaded.bytes!.lengthInBytes < 340 * 1024 * 1024) &&
      isAproipriate;
}

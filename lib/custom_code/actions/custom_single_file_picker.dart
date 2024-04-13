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

import 'package:onlife/flutter_flow/upload_data.dart';

Future<FFUploadedFile?> customSingleFilePicker(
  BuildContext context,
  int? imageQuantity,
  bool allowPhoto,
  bool? allowVideo,
  Color? textColor,
  Color? bgColour,
) async {
  // Add your function code here!
  FFUploadedFile? result;

// the media picker is designed be able to select multiple parts
  // but we will be selecting only one.
  // Also it must be note that SelectedFile Data type is being returned from the image picker function.
  //  we have to convert it to FFUploadeddFile for internal use
  List<SelectedFile>? sFiles = [];
  textColor ??= const Color(0xFF111417);
  bgColour ??= const Color(0xFFF5F5F5);
  sFiles = await selectMediaWithSourceBottomSheet(
      allowPhoto: allowPhoto,
      context: context,
      allowVideo: allowVideo ?? false,
      backgroundColor: bgColour,
      imageQuality: imageQuantity,
      textColor: textColor);
  if (sFiles?.isNotEmpty ?? false) {
    SelectedFile fileInSelectedFileFormat = sFiles![0];
    // this is a lil bit abnormal because the file name contains te extention
    result = FFUploadedFile(
        bytes: fileInSelectedFileFormat.bytes,
        name: fileInSelectedFileFormat.filePath);
  }
  return result;
}

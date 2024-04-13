import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/backend/schema/structs/index.dart';
import '/auth/firebase_auth/auth_util.dart';

List<PlacesRecord>? nearLocationsGetter(
  List<PlacesRecord>? listOfLocation,
  double tresholdDistance,
  LatLng userLocation,
) {
  // fresh

  double deg2rad(double deg) => deg * math.pi / 180;
  double distance(double lat1, double lon1, double lat2, double lon2) {
    final R = 6371e3; // Earth's radius (in meters)
    var dLat = deg2rad(lat2 - lat1);
    var dLon = deg2rad(lon2 - lon1);

    var a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(deg2rad(lat1)) *
            math.cos(deg2rad(lat2)) *
            math.sin(dLon / 2) *
            math.sin(dLon / 2);
    var c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));

    return R * c;
  }

  List<PlacesRecord> result = [];
  for (PlacesRecord i in listOfLocation ?? []) {
    if (distance(i.coord?.latitude ?? 0, i.coord?.longitude ?? 0,
            userLocation.latitude, userLocation.longitude) <
        tresholdDistance) {
      result.add(i);
    }
  }

  return result;
}

bool nearLocationChecker(
  double tresholdDistance,
  LatLng? userLocation,
  LatLng placeLocation,
) {
  userLocation ??= LatLng(43.7844397, -88.7878678);

  print("fresh" * 100);
  print(tresholdDistance);
  print(userLocation);
  print(placeLocation);
  print("freshended" * 100);

  double deg2rad(double deg) => deg * math.pi / 180;
  double distance(double lat1, double lon1, double lat2, double lon2) {
    final R = 6371e3; // Earth's radius (in meters)
    var dLat = deg2rad(lat2 - lat1);
    var dLon = deg2rad(lon2 - lon1);

    var a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(deg2rad(lat1)) *
            math.cos(deg2rad(lat2)) *
            math.sin(dLon / 2) *
            math.sin(dLon / 2);
    var c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));

    return R * c;
  }

  return distance(userLocation.latitude, userLocation.longitude,
          placeLocation.latitude, placeLocation.longitude) <
      tresholdDistance;
}

DateTime addsHourToDate(
  DateTime input,
  int minutes,
) {
  DateTime result = input;

  result.add(Duration(minutes: minutes));

  return result;
}

String? functionToConvertMediaUrlToVideoPath(String inputURL) {
  return inputURL;
}

int findTheDifferenceBtwTwoDates(
  DateTime date1,
  DateTime date2,
) {
  return (date1.difference(date2).inMilliseconds > 0)
      ? date1.difference(date2).inMilliseconds
      : -1 * (date1.difference(date2).inMilliseconds);
}

String? functionToConvertMediaUrlToPhotoPath(String inputURL) {
  return inputURL;
}

String? printUserNotificationDocuments(
    UserNotificationRecord? notificationDoc) {
  print(notificationDoc);
  return null;
}

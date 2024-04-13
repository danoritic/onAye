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

Future actiontodeletealreadystaleCheckins(
  DateTime currentDate,
  List<CheckInsRecord>? listOfCheckins,
) async {
  // Add your function code here!
  for (CheckInsRecord i in listOfCheckins ?? []) {
    if (i.expirationDate?.isBefore(currentDate) ?? false) {
      await i.reference.delete();
      PlacesRecord place = PlacesRecord.fromSnapshot((await i.place!.get()));

//  deletes user ref fron place participants and chatting user
      place.userThatAreCheckedIn.remove(i.owner);
      place.usersThatAreChatting.remove(i.owner);

      // deletes the place that user checked into docs from users sub collections
      List l = (await i.owner!
              .collection("placeUserCheckedInto")
              .where({"placeRef": place.reference}).get())
          .docs;
      for (QueryDocumentSnapshot i in l) {
        await i.reference.delete();
      }
    }
  }
}

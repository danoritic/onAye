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

import 'package:onlife/flutter_flow/flutter_flow_video_player.dart';

Future addUnreadPlaceMessageToUsers(
  List<DocumentReference>? listOfUsersToAddUnreadMessageTo,
  DocumentReference? placeMessageReference,
  DocumentReference? place,
) async {
  // Add your function code here!
  for (DocumentReference i in listOfUsersToAddUnreadMessageTo ?? []) {
    QuerySnapshot q = (await i
        .collection('placeUserCheckedInto')
        .where("placeRef", isEqualTo: place)
        .get());
    Map formerDetail = (q.docs?[0].data() as Map);
    await q.docs?[0].reference.update({
      'lastMessage': placeMessageReference,
      "noOfUnreadMessage": formerDetail["formerDetail"] + 1
    });
    // add(
    //     {'isPrivate': false, "placeChatRealDocRef": placeMessageReference});
  }
// FlutterFlowVideoPlayer(
//   path:
//       'https://assets.mixkit.co/videos/preview/mixkit-forest-stream-in-the-sunlight-529-large.mp4',
//   videoType: VideoType.network,
//   autoPlay: false,
//   looping: true,
//   showControls: true,
//   allowFullScreen: true,
//   allowPlaybackSpeedMenu: false,
// ).
}

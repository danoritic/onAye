import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_video_player.dart';
import 'checkins_card_widget.dart' show CheckinsCardWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CheckinsCardModel extends FlutterFlowModel<CheckinsCardWidget> {
  ///  Local state fields for this component.

  bool isLoved = false;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - Read Document] action in CheckinsCard widget.
  UsersRecord? ownerUserDoc;
  // Stores action output result for [Backend Call - Read Document] action in CheckinsCard widget.
  PlacesRecord? checkinPlaceDoc;
  // Stores action output result for [Firestore Query - Query a collection] action in Icon widget.
  FriendRecord? foundFriendDoc;
  // Stores action output result for [Firestore Query - Query a collection] action in Icon widget.
  List<UserPotentialChatMateRecord>? listofPotentialChatMate;
  // Stores action output result for [Firestore Query - Query a collection] action in Icon widget.
  List<UserPotentialChatMateRecord>? listOfPotentialChatMateOfTheOwner;
  // Stores action output result for [Backend Call - Create Document] action in Icon widget.
  UserNotificationRecord? createdUserNotificationDoc;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}

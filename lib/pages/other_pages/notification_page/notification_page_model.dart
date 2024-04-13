import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/empty_list_component_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'notification_page_widget.dart' show NotificationPageWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class NotificationPageModel extends FlutterFlowModel<NotificationPageWidget> {
  ///  Local state fields for this page.

  List<DocumentReference> participants = [];
  void addToParticipants(DocumentReference item) => participants.add(item);
  void removeFromParticipants(DocumentReference item) =>
      participants.remove(item);
  void removeAtIndexFromParticipants(int index) => participants.removeAt(index);
  void insertAtIndexInParticipants(int index, DocumentReference item) =>
      participants.insert(index, item);
  void updateParticipantsAtIndex(
          int index, Function(DocumentReference) updateFn) =>
      participants[index] = updateFn(participants[index]);

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Backend Call - Read Document] action in Container widget.
  CheckInsRecord? checkinDoc;
  // Stores action output result for [Backend Call - Read Document] action in Container widget.
  CheckInsRecord? checkinDocforReaction;
  // Stores action output result for [Backend Call - Read Document] action in Container widget.
  PlacesRecord? placeDoc;
  // Stores action output result for [Backend Call - Read Document] action in Container widget.
  FriendRecord? chatMateDoc;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}

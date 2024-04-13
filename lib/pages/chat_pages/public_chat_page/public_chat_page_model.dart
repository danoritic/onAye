import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/components/empty_list_component_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import '/custom_code/actions/index.dart' as actions;
import 'public_chat_page_widget.dart' show PublicChatPageWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PublicChatPageModel extends FlutterFlowModel<PublicChatPageWidget> {
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

  int participantCounter = 0;

  List<FriendRecord> usersFriends = [];
  void addToUsersFriends(FriendRecord item) => usersFriends.add(item);
  void removeFromUsersFriends(FriendRecord item) => usersFriends.remove(item);
  void removeAtIndexFromUsersFriends(int index) => usersFriends.removeAt(index);
  void insertAtIndexInUsersFriends(int index, FriendRecord item) =>
      usersFriends.insert(index, item);
  void updateUsersFriendsAtIndex(int index, Function(FriendRecord) updateFn) =>
      usersFriends[index] = updateFn(usersFriends[index]);

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  List<PlaceChatRealRecord>? publicChatPagePreviousSnapshot;
  // Stores action output result for [Firestore Query - Query a collection] action in publicChatPage widget.
  PlaceUserCheckedIntoRecord? placeThatUserCheckedIntoRef;
  // Stores action output result for [Firestore Query - Query a collection] action in publicChatPage widget.
  List<FriendRecord>? friendList;
  // Stores action output result for [Firestore Query - Query a collection] action in publicChatPage widget.
  List<PlaceChatRealRecord>? placeRealChatList;
  // State field(s) for ListView widget.
  ScrollController? listViewController;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [Backend Call - Create Document] action in TextField widget.
  PlaceChatRealRecord? createdPlaceChatCopy;
  // Stores action output result for [Firestore Query - Query a collection] action in TextField widget.
  PlaceUserCheckedIntoRecord? placeUserCheckIntoDocCopy;
  // Stores action output result for [Backend Call - Create Document] action in IconButton widget.
  PlaceChatRealRecord? createdPlaceChat;
  // Stores action output result for [Firestore Query - Query a collection] action in IconButton widget.
  PlaceUserCheckedIntoRecord? placeUserCheckIntoDoc;

  @override
  void initState(BuildContext context) {
    listViewController = ScrollController();
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    listViewController?.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}

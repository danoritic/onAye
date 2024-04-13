import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'private_chat_page_widget.dart' show PrivateChatPageWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PrivateChatPageModel extends FlutterFlowModel<PrivateChatPageWidget> {
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
  // Stores action output result for [Backend Call - Read Document] action in privateChatPage widget.
  UsersRecord? friendUserDoc;
  // State field(s) for ListView widget.
  ScrollController? listViewController;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [Backend Call - Create Document] action in TextField widget.
  PrivateChatRealRecord? createdChatDocumentCopy;
  // Stores action output result for [Firestore Query - Query a collection] action in TextField widget.
  FriendRecord? friendsFriendUserDocCopy;
  // Stores action output result for [Backend Call - Create Document] action in IconButton widget.
  PrivateChatRealRecord? createdChatDocument;
  // Stores action output result for [Firestore Query - Query a collection] action in IconButton widget.
  FriendRecord? friendsFriendUserDoc;

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

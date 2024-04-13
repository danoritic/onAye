import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/empty_list_component_widget.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'chat_list_page_widget.dart' show ChatListPageWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ChatListPageModel extends FlutterFlowModel<ChatListPageWidget> {
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

  List<PlaceUserCheckedIntoRecord> listOfPlacesThatUsersCheckedInto = [];
  void addToListOfPlacesThatUsersCheckedInto(PlaceUserCheckedIntoRecord item) =>
      listOfPlacesThatUsersCheckedInto.add(item);
  void removeFromListOfPlacesThatUsersCheckedInto(
          PlaceUserCheckedIntoRecord item) =>
      listOfPlacesThatUsersCheckedInto.remove(item);
  void removeAtIndexFromListOfPlacesThatUsersCheckedInto(int index) =>
      listOfPlacesThatUsersCheckedInto.removeAt(index);
  void insertAtIndexInListOfPlacesThatUsersCheckedInto(
          int index, PlaceUserCheckedIntoRecord item) =>
      listOfPlacesThatUsersCheckedInto.insert(index, item);
  void updateListOfPlacesThatUsersCheckedIntoAtIndex(
          int index, Function(PlaceUserCheckedIntoRecord) updateFn) =>
      listOfPlacesThatUsersCheckedInto[index] =
          updateFn(listOfPlacesThatUsersCheckedInto[index]);

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Firestore Query - Query a collection] action in chatListPage widget.
  List<PlaceUserCheckedIntoRecord>? listOfCheckeInPlacDocs;
  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController;
  String? get choiceChipsValue =>
      choiceChipsValueController?.value?.firstOrNull;
  set choiceChipsValue(String? val) =>
      choiceChipsValueController?.value = val != null ? [val] : [];

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}

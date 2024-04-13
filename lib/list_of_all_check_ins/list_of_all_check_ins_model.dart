import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/checkins_card_for_see_all_page/checkins_card_for_see_all_page_widget.dart';
import '/components/empty_list_component_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'list_of_all_check_ins_widget.dart' show ListOfAllCheckInsWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ListOfAllCheckInsModel extends FlutterFlowModel<ListOfAllCheckInsWidget> {
  ///  Local state fields for this page.

  List<CheckInsRecord> checkinDocs = [];
  void addToCheckinDocs(CheckInsRecord item) => checkinDocs.add(item);
  void removeFromCheckinDocs(CheckInsRecord item) => checkinDocs.remove(item);
  void removeAtIndexFromCheckinDocs(int index) => checkinDocs.removeAt(index);
  void insertAtIndexInCheckinDocs(int index, CheckInsRecord item) =>
      checkinDocs.insert(index, item);
  void updateCheckinDocsAtIndex(int index, Function(CheckInsRecord) updateFn) =>
      checkinDocs[index] = updateFn(checkinDocs[index]);

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Firestore Query - Query a collection] action in ListOfAllCheckIns widget.
  List<CheckInsRecord>? checkinDocLists;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}

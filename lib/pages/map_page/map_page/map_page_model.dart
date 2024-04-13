import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/components/edit_profile_component/edit_profile_component_widget.dart';
import '/components/top_place_checked_in_component/top_place_checked_in_component_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'map_page_widget.dart' show MapPageWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MapPageModel extends FlutterFlowModel<MapPageWidget> {
  ///  Local state fields for this page.

  LatLng? centeredLocation;

  bool showNearPlaces = false;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Firestore Query - Query a collection] action in MapPage widget.
  List<CheckInsRecord>? allCheckins;
  // Stores action output result for [Backend Call - API (getCred)] action in MapPage widget.
  ApiCallResponse? apiResult8kp;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}

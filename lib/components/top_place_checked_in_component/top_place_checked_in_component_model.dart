import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/maps_popup_component/maps_popup_component_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'top_place_checked_in_component_widget.dart'
    show TopPlaceCheckedInComponentWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TopPlaceCheckedInComponentModel
    extends FlutterFlowModel<TopPlaceCheckedInComponentWidget> {
  ///  Local state fields for this component.

  bool isCheckedIn = false;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Firestore Query - Query a collection] action in topPlaceCheckedInComponent widget.
  List<CheckInsRecord>? listOfUsersCheckinPlaces;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}

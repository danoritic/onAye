import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_video_player.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/backend/schema/structs/index.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'tiktok_status_like_media_display_widget.dart'
    show TiktokStatusLikeMediaDisplayWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class TiktokStatusLikeMediaDisplayModel
    extends FlutterFlowModel<TiktokStatusLikeMediaDisplayWidget> {
  ///  Local state fields for this page.

  int? currentPage;

  int timeLength = 10;

  bool isLoved = false;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Backend Call - Read Document] action in tiktokStatusLikeMediaDisplay widget.
  PlacesRecord? checkInPlaceDoc;
  // State field(s) for Timer widget.
  int timerMilliseconds1 = 0;
  String timerValue1 = StopWatchTimer.getDisplayTime(
    0,
    hours: false,
    milliSecond: false,
  );
  FlutterFlowTimerController timerController1 =
      FlutterFlowTimerController(StopWatchTimer(mode: StopWatchMode.countDown));

  // Stores action output result for [Firestore Query - Query a collection] action in IconButton widget.
  FriendRecord? foundFriendDoc;
  // Stores action output result for [Firestore Query - Query a collection] action in IconButton widget.
  List<UserPotentialChatMateRecord>? listofPotentialChatMate;
  // Stores action output result for [Firestore Query - Query a collection] action in IconButton widget.
  List<UserPotentialChatMateRecord>? listOfPotentialChatMateOfTheOwner;
  // State field(s) for Timer widget.
  int timerMilliseconds2 = 15000;
  String timerValue2 = StopWatchTimer.getDisplayTime(
    15000,
    hours: false,
    milliSecond: false,
  );
  FlutterFlowTimerController timerController2 =
      FlutterFlowTimerController(StopWatchTimer(mode: StopWatchMode.countDown));

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    timerController1.dispose();
    timerController2.dispose();
  }
}

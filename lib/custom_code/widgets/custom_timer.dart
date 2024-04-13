// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:onlife/flutter_flow/flutter_flow_timer.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class CustomTimer extends StatefulWidget {
  const CustomTimer({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  State<CustomTimer> createState() => _CustomTimerState();
}

class _CustomTimerState extends State<CustomTimer> {
  @override
  initState() {
    timerController2.onStartTimer();
    super.initState();
  }

  int timerMilliseconds2 = 15000;
  String timerValue2 = StopWatchTimer.getDisplayTime(
    15000,
    hours: false,
    milliSecond: false,
  );
  FlutterFlowTimerController timerController2 =
      FlutterFlowTimerController(StopWatchTimer(mode: StopWatchMode.countDown));

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
      child: FlutterFlowTimer(
        initialTime: timerMilliseconds2,
        getDisplayTime: (value) => StopWatchTimer.getDisplayTime(
          value,
          hours: false,
          milliSecond: false,
        ),
        controller: timerController2,
        updateStateInterval: Duration(milliseconds: 1000),
        onChanged: (value, displayTime, shouldUpdate) {
          timerMilliseconds2 = value;
          timerValue2 = displayTime;
          if (shouldUpdate) setState(() {});
          FFAppState().statusTimeRatioOver1500 = value / 15000;
          FFAppState().update(() {});
        },
        onEnded: () async {
          await printsInputy(
            valueOrDefault<String>(
              timerValue2,
              'j',
            ),
          );
        },
        textAlign: TextAlign.start,
        style: FlutterFlowTheme.of(context).headlineSmall.override(
              fontFamily: 'Outfit',
              color: Colors.white,
              fontSize: 16,
              letterSpacing: 0,
            ),
      ),
    );
  }
}

class _model {}

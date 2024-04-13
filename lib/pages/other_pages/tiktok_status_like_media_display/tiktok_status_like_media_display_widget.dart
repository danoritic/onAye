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
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'tiktok_status_like_media_display_model.dart';
export 'tiktok_status_like_media_display_model.dart';

class TiktokStatusLikeMediaDisplayWidget extends StatefulWidget {
  const TiktokStatusLikeMediaDisplayWidget({
    super.key,
    required this.jasonVersionOfMediaType,
    required this.checkin,
    bool? isOpenedByTheOwner,
  }) : this.isOpenedByTheOwner = isOpenedByTheOwner ?? true;

  final dynamic jasonVersionOfMediaType;
  final CheckInsRecord? checkin;
  final bool isOpenedByTheOwner;

  @override
  State<TiktokStatusLikeMediaDisplayWidget> createState() =>
      _TiktokStatusLikeMediaDisplayWidgetState();
}

class _TiktokStatusLikeMediaDisplayWidgetState
    extends State<TiktokStatusLikeMediaDisplayWidget> {
  late TiktokStatusLikeMediaDisplayModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TiktokStatusLikeMediaDisplayModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.timerController1.onStartTimer();
      _model.timerController2.onStartTimer();
      _model.checkInPlaceDoc =
          await PlacesRecord.getDocumentOnce(widget.checkin!.place!);
      setState(() {
        _model.isLoved =
            widget.checkin!.reactants.contains(currentUserReference);
      });
      await Future.delayed(const Duration(milliseconds: 15000));
      context.safePop();
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).tertiary,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.white,
              size: 30.0,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
          actions: [],
          centerTitle: true,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Builder(
                      builder: (context) {
                        if (valueOrDefault<bool>(
                          MediaPathStruct.maybeFromMap(
                                  widget.jasonVersionOfMediaType)
                              ?.isPhoto,
                          false,
                        )) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(0.0),
                            child: Image.network(
                              MediaPathStruct.maybeFromMap(
                                      widget.jasonVersionOfMediaType!)!
                                  .photoPath,
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          );
                        } else {
                          return Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: FlutterFlowVideoPlayer(
                              path: MediaPathStruct.maybeFromMap(
                                      widget.jasonVersionOfMediaType!)!
                                  .videoPath,
                              videoType: VideoType.network,
                              autoPlay: false,
                              looping: true,
                              showControls: true,
                              allowFullScreen: true,
                              allowPlaybackSpeedMenu: false,
                            ),
                          );
                        }
                      },
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 0.0),
                      child: LinearPercentIndicator(
                        percent: FFAppState().statusTimeRatioOver1500,
                        lineHeight: 5.0,
                        animation: true,
                        animateFromLastPercent: true,
                        progressColor: FlutterFlowTheme.of(context).tertiary,
                        backgroundColor: FlutterFlowTheme.of(context).accent3,
                        padding: EdgeInsets.zero,
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(1.0, 1.0),
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (widget.isOpenedByTheOwner)
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color:
                                          FlutterFlowTheme.of(context).tertiary,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.timer_outlined,
                                        color: Colors.white,
                                        size: 24.0,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color:
                                          FlutterFlowTheme.of(context).tertiary,
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10.0, 0.0, 10.0, 0.0),
                                      child: FlutterFlowTimer(
                                        initialTime: functions
                                            .findTheDifferenceBtwTwoDates(
                                                widget.checkin!.time!,
                                                getCurrentTimestamp),
                                        getDisplayTime: (value) =>
                                            StopWatchTimer.getDisplayTime(
                                          value,
                                          hours: false,
                                          milliSecond: false,
                                        ),
                                        controller: _model.timerController1,
                                        updateStateInterval:
                                            Duration(milliseconds: 1000),
                                        onChanged:
                                            (value, displayTime, shouldUpdate) {
                                          _model.timerMilliseconds1 = value;
                                          _model.timerValue1 = displayTime;
                                          if (shouldUpdate) setState(() {});
                                        },
                                        textAlign: TextAlign.start,
                                        style: FlutterFlowTheme.of(context)
                                            .headlineSmall
                                            .override(
                                              fontFamily: 'Outfit',
                                              color: Colors.white,
                                              fontSize: 16.0,
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                    ),
                                  ),
                                ].divide(SizedBox(height: 5.0)),
                              ),
                            if (widget.isOpenedByTheOwner)
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color:
                                          FlutterFlowTheme.of(context).tertiary,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.favorite,
                                        color: Colors.white,
                                        size: 24.0,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color:
                                          FlutterFlowTheme.of(context).tertiary,
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          5.0, 0.0, 5.0, 0.0),
                                      child: Text(
                                        formatNumber(
                                          widget.checkin!.noOfReactants,
                                          formatType: FormatType.compact,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Readex Pro',
                                              color: Colors.white,
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                    ),
                                  ),
                                ].divide(SizedBox(height: 5.0)),
                              ),
                            Builder(
                              builder: (context) {
                                if (!widget.isOpenedByTheOwner) {
                                  return FlutterFlowIconButton(
                                    borderColor:
                                        FlutterFlowTheme.of(context).tertiary,
                                    borderRadius: 20.0,
                                    borderWidth: 1.0,
                                    buttonSize: 40.0,
                                    fillColor:
                                        FlutterFlowTheme.of(context).tertiary,
                                    icon: Icon(
                                      Icons.favorite,
                                      color: valueOrDefault<Color>(
                                        _model.isLoved
                                            ? FlutterFlowTheme.of(context).error
                                            : FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                        FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                      ),
                                      size: 24.0,
                                    ),
                                    onPressed: () async {
                                      setState(() {
                                        _model.isLoved = true;
                                      });

                                      await widget.checkin!.reference.update({
                                        ...mapToFirestore(
                                          {
                                            'Reactants': FieldValue.arrayUnion(
                                                [currentUserReference]),
                                            'noOfReactants':
                                                FieldValue.increment(1),
                                          },
                                        ),
                                      });
                                      _model.foundFriendDoc =
                                          await queryFriendRecordOnce(
                                        parent: currentUserReference,
                                        queryBuilder: (friendRecord) =>
                                            friendRecord.where(
                                          'friendUserRef',
                                          isEqualTo: widget.checkin?.owner,
                                        ),
                                        singleRecord: true,
                                      ).then((s) => s.firstOrNull);
                                      if (_model.foundFriendDoc != null) {
                                        triggerPushNotification(
                                          notificationTitle: 'Post reaction',
                                          notificationText:
                                              'Your post at ${_model.checkInPlaceDoc?.name}was liked by ${currentUserDisplayName}react to their checkin photo, to chat with them privately',
                                          notificationImageUrl:
                                              currentUserPhoto,
                                          userRefs: [widget.checkin!.owner!],
                                          initialPageName: 'ProfilePage',
                                          parameterData: {
                                            'isOpenedByOwner': false,
                                            'isOpenedByFriend': false,
                                            'profileDoc': currentUserReference,
                                          },
                                        );
                                      } else {
                                        _model.listofPotentialChatMate =
                                            await queryUserPotentialChatMateRecordOnce(
                                          parent: currentUserReference,
                                          queryBuilder:
                                              (userPotentialChatMateRecord) =>
                                                  userPotentialChatMateRecord
                                                      .where(
                                            'userThatReacted',
                                            isEqualTo: widget.checkin?.owner,
                                          ),
                                        );
                                        if (_model.listofPotentialChatMate !=
                                                null &&
                                            (_model.listofPotentialChatMate)!
                                                .isNotEmpty) {
                                          await FriendRecord.createDoc(
                                                  currentUserReference!)
                                              .set(createFriendRecordData(
                                            friendUserRef:
                                                widget.checkin?.owner,
                                            noOfUnreadMessages: 0,
                                          ));

                                          await FriendRecord.createDoc(
                                                  widget.checkin!.owner!)
                                              .set(createFriendRecordData(
                                            friendUserRef: currentUserReference,
                                            noOfUnreadMessages: 0,
                                          ));
                                          await _model.listofPotentialChatMate!
                                              .first.reference
                                              .delete();
                                          triggerPushNotification(
                                            notificationTitle: 'Post reaction',
                                            notificationText:
                                                'Your post at ${_model.checkInPlaceDoc?.name}was liked by ${currentUserDisplayName}react to their checkin photo, to chat with them privately',
                                            notificationImageUrl:
                                                currentUserPhoto,
                                            userRefs: [widget.checkin!.owner!],
                                            initialPageName: 'ProfilePage',
                                            parameterData: {
                                              'isOpenedByOwner': false,
                                              'isOpenedByFriend': false,
                                              'profileDoc':
                                                  currentUserReference,
                                            },
                                          );
                                        } else {
                                          _model.listOfPotentialChatMateOfTheOwner =
                                              await queryUserPotentialChatMateRecordOnce(
                                            parent: widget.checkin?.owner,
                                            queryBuilder:
                                                (userPotentialChatMateRecord) =>
                                                    userPotentialChatMateRecord
                                                        .where(
                                              'userThatReacted',
                                              isEqualTo: currentUserReference,
                                            ),
                                          );
                                          if (!(_model.listOfPotentialChatMateOfTheOwner !=
                                                  null &&
                                              (_model.listOfPotentialChatMateOfTheOwner)!
                                                  .isNotEmpty)) {
                                            await UserPotentialChatMateRecord
                                                    .createDoc(
                                                        widget.checkin!.owner!)
                                                .set(
                                                    createUserPotentialChatMateRecordData(
                                              checkIn:
                                                  widget.checkin?.reference,
                                              userThatReacted:
                                                  currentUserReference,
                                            ));
                                          }
                                          triggerPushNotification(
                                            notificationTitle: 'Post reaction',
                                            notificationText:
                                                'Your post at ${_model.checkInPlaceDoc?.name}was liked by ${currentUserDisplayName}react to their checkin photo, to chat with them privately',
                                            notificationImageUrl:
                                                currentUserPhoto,
                                            userRefs: [widget.checkin!.owner!],
                                            initialPageName: 'ProfilePage',
                                            parameterData: {
                                              'isOpenedByOwner': false,
                                              'isOpenedByFriend': false,
                                              'profileDoc':
                                                  currentUserReference,
                                            },
                                          );
                                        }
                                      }

                                      setState(() {});
                                    },
                                  );
                                } else {
                                  return FlutterFlowIconButton(
                                    borderColor:
                                        FlutterFlowTheme.of(context).tertiary,
                                    borderRadius: 20.0,
                                    borderWidth: 1.0,
                                    buttonSize: 40.0,
                                    fillColor:
                                        FlutterFlowTheme.of(context).tertiary,
                                    icon: Icon(
                                      Icons.delete_forever,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      size: 24.0,
                                    ),
                                    onPressed: () async {
                                      var confirmDialogResponse =
                                          await showDialog<bool>(
                                                context: context,
                                                builder: (alertDialogContext) {
                                                  return AlertDialog(
                                                    title: Text('delete post'),
                                                    content: Text(
                                                        'This will check you out of the place'),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                alertDialogContext,
                                                                false),
                                                        child: Text('No'),
                                                      ),
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                alertDialogContext,
                                                                true),
                                                        child: Text('Yes'),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              ) ??
                                              false;
                                      if (confirmDialogResponse) {
                                        await widget.checkin!.reference
                                            .delete();
                                        context.safePop();
                                      }
                                    },
                                  );
                                }
                              },
                            ),
                          ].divide(SizedBox(height: 15.0)),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                      child: FlutterFlowTimer(
                        initialTime: _model.timerMilliseconds2,
                        getDisplayTime: (value) =>
                            StopWatchTimer.getDisplayTime(
                          value,
                          hours: false,
                          milliSecond: false,
                        ),
                        controller: _model.timerController2,
                        updateStateInterval: Duration(milliseconds: 1000),
                        onChanged: (value, displayTime, shouldUpdate) {
                          _model.timerMilliseconds2 = value;
                          _model.timerValue2 = displayTime;
                          if (shouldUpdate) setState(() {});
                        },
                        onEnded: () async {
                          await actions.printsInputy(
                            valueOrDefault<String>(
                              _model.timerValue2,
                              'j',
                            ),
                          );
                        },
                        textAlign: TextAlign.start,
                        style:
                            FlutterFlowTheme.of(context).headlineSmall.override(
                                  fontFamily: 'Outfit',
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(-0.9, -0.57),
                      child: Container(
                        width: 12.0,
                        height: 12.0,
                        child: custom_widgets.CustomTimer(
                          width: 12.0,
                          height: 12.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.0, 1.0),
                child: Container(
                  width: double.infinity,
                  constraints: BoxConstraints(
                    maxHeight: 150.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(0.0),
                      bottomRight: Radius.circular(0.0),
                      topLeft: Radius.circular(0.0),
                      topRight: Radius.circular(0.0),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 5.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (!widget.isOpenedByTheOwner)
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              StreamBuilder<UsersRecord>(
                                stream: UsersRecord.getDocument(
                                    widget.checkin!.owner!),
                                builder: (context, snapshot) {
                                  // Customize what your widget looks like when it's loading.
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: SizedBox(
                                        width: 50.0,
                                        height: 50.0,
                                        child: CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                            FlutterFlowTheme.of(context)
                                                .primary,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  final circleImageUsersRecord = snapshot.data!;
                                  return Container(
                                    width: 50.0,
                                    height: 50.0,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.network(
                                      valueOrDefault<String>(
                                        circleImageUsersRecord.photoUrl,
                                        'https://i.ibb.co/gM8GFCN/user-avatar.png',
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                },
                              ),
                              StreamBuilder<UsersRecord>(
                                stream: UsersRecord.getDocument(
                                    widget.checkin!.owner!),
                                builder: (context, snapshot) {
                                  // Customize what your widget looks like when it's loading.
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: SizedBox(
                                        width: 50.0,
                                        height: 50.0,
                                        child: CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                            FlutterFlowTheme.of(context)
                                                .primary,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  final richTextUsersRecord = snapshot.data!;
                                  return RichText(
                                    textScaler:
                                        MediaQuery.of(context).textScaler,
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: '@ ',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Readex Pro',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                        TextSpan(
                                          text: richTextUsersRecord.displayName,
                                          style: TextStyle(
                                            color: FlutterFlowTheme.of(context)
                                                .tertiary,
                                          ),
                                        )
                                      ],
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Readex Pro',
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                  );
                                },
                              ),
                            ].divide(SizedBox(width: 5.0)),
                          ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'Caption :  ${widget.checkin?.caption}'
                                  .maybeHandleOverflow(
                                maxChars: 150,
                                replacement: '…',
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    color:
                                        FlutterFlowTheme.of(context).tertiary,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                          ],
                        ),
                      ].divide(SizedBox(height: 5.0)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

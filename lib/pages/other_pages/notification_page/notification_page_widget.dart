import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/empty_list_component_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'notification_page_model.dart';
export 'notification_page_model.dart';

class NotificationPageWidget extends StatefulWidget {
  const NotificationPageWidget({super.key});

  @override
  State<NotificationPageWidget> createState() => _NotificationPageWidgetState();
}

class _NotificationPageWidgetState extends State<NotificationPageWidget> {
  late NotificationPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NotificationPageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        _model.addToParticipants(currentUserReference!);
      });
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<UserNotificationRecord>>(
      stream: queryUserNotificationRecord(
        parent: currentUserReference,
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            ),
          );
        }
        List<UserNotificationRecord>
            notificationPageUserNotificationRecordList = snapshot.data!;
        return GestureDetector(
          onTap: () => _model.unfocusNode.canRequestFocus
              ? FocusScope.of(context).requestFocus(_model.unfocusNode)
              : FocusScope.of(context).unfocus(),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
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
              title: Align(
                alignment: AlignmentDirectional(0.0, 0.0),
                child: Text(
                  'Notifications',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Readex Pro',
                        color: Colors.white,
                        fontSize: 24.0,
                        letterSpacing: 0.0,
                      ),
                ),
              ),
              actions: [],
              centerTitle: true,
              elevation: 2.0,
            ),
            body: SafeArea(
              top: true,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          FlutterFlowTheme.of(context).primary,
                          FlutterFlowTheme.of(context).tertiary
                        ],
                        stops: [0.0, 1.0],
                        begin: AlignmentDirectional(0.87, -1.0),
                        end: AlignmentDirectional(-0.87, 1.0),
                      ),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 0.0),
                      child: Builder(
                        builder: (context) {
                          final notifications =
                              notificationPageUserNotificationRecordList
                                  .toList();
                          if (notifications.isEmpty) {
                            return EmptyListComponentWidget(
                              message: 'No notifications yet',
                            );
                          }
                          return ListView.separated(
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.vertical,
                            itemCount: notifications.length,
                            separatorBuilder: (_, __) => SizedBox(height: 10.0),
                            itemBuilder: (context, notificationsIndex) {
                              final notificationsItem =
                                  notifications[notificationsIndex];
                              return InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  await actions.printsInputy(
                                    functions.printUserNotificationDocuments(
                                        notificationsItem),
                                  );
                                  if (notificationsItem.isPostRenewal) {
                                    _model.checkinDoc =
                                        await CheckInsRecord.getDocumentOnce(
                                            notificationsItem.checkIn!);

                                    context.pushNamed(
                                      'tiktokStatusLikeMediaDisplay',
                                      queryParameters: {
                                        'jasonVersionOfMediaType':
                                            serializeParam(
                                          _model.checkinDoc?.media?.toMap(),
                                          ParamType.JSON,
                                        ),
                                        'checkin': serializeParam(
                                          _model.checkinDoc,
                                          ParamType.Document,
                                        ),
                                        'isOpenedByTheOwner': serializeParam(
                                          true,
                                          ParamType.bool,
                                        ),
                                      }.withoutNulls,
                                      extra: <String, dynamic>{
                                        'checkin': _model.checkinDoc,
                                      },
                                    );
                                  } else {
                                    if (notificationsItem.isReaction) {
                                      _model.checkinDocforReaction =
                                          await CheckInsRecord.getDocumentOnce(
                                              notificationsItem.checkIn!);

                                      context.pushNamed(
                                        'tiktokStatusLikeMediaDisplay',
                                        queryParameters: {
                                          'jasonVersionOfMediaType':
                                              serializeParam(
                                            _model.checkinDocforReaction?.media
                                                ?.toMap(),
                                            ParamType.JSON,
                                          ),
                                          'checkin': serializeParam(
                                            _model.checkinDocforReaction,
                                            ParamType.Document,
                                          ),
                                          'isOpenedByTheOwner': serializeParam(
                                            false,
                                            ParamType.bool,
                                          ),
                                        }.withoutNulls,
                                        extra: <String, dynamic>{
                                          'checkin':
                                              _model.checkinDocforReaction,
                                        },
                                      );
                                    } else {
                                      if (notificationsItem.isPublicChat) {
                                        _model.placeDoc =
                                            await PlacesRecord.getDocumentOnce(
                                                notificationsItem.place!);

                                        context.pushNamed(
                                          'publicChatPage',
                                          queryParameters: {
                                            'place': serializeParam(
                                              _model.placeDoc,
                                              ParamType.Document,
                                            ),
                                          }.withoutNulls,
                                          extra: <String, dynamic>{
                                            'place': _model.placeDoc,
                                          },
                                        );
                                      } else {
                                        if (notificationsItem.isPrivateChat) {
                                          _model.chatMateDoc =
                                              await FriendRecord
                                                  .getDocumentOnce(
                                                      notificationsItem
                                                          .chatMate!);

                                          context.pushNamed(
                                            'privateChatPage',
                                            queryParameters: {
                                              'chatMate': serializeParam(
                                                _model.chatMateDoc,
                                                ParamType.Document,
                                              ),
                                            }.withoutNulls,
                                            extra: <String, dynamic>{
                                              'chatMate': _model.chatMateDoc,
                                            },
                                          );
                                        }
                                      }
                                    }
                                  }

                                  setState(() {});
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 80.0,
                                  decoration: BoxDecoration(
                                    color: notificationsItem.isViewed
                                        ? FlutterFlowTheme.of(context)
                                            .secondaryText
                                        : FlutterFlowTheme.of(context).tertiary,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 4.0,
                                        color: Color(0x33000000),
                                        offset: Offset(
                                          2.0,
                                          2.0,
                                        ),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(18.0),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10.0, 0.0, 10.0, 0.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Icon(
                                              Icons.notifications_rounded,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              size: 34.0,
                                            ),
                                            Container(
                                              width: 280.0,
                                              decoration: BoxDecoration(),
                                              child: Text(
                                                notificationsItem.message,
                                                maxLines: 2,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Readex Pro',
                                                          letterSpacing: 0.0,
                                                        ),
                                              ),
                                            ),
                                          ].divide(SizedBox(width: 10.0)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

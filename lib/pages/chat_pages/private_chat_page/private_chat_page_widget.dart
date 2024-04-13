import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'private_chat_page_model.dart';
export 'private_chat_page_model.dart';

class PrivateChatPageWidget extends StatefulWidget {
  const PrivateChatPageWidget({
    super.key,
    required this.chatMate,
  });

  final FriendRecord? chatMate;

  @override
  State<PrivateChatPageWidget> createState() => _PrivateChatPageWidgetState();
}

class _PrivateChatPageWidgetState extends State<PrivateChatPageWidget>
    with TickerProviderStateMixin {
  late PrivateChatPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = {
    'textFieldOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
      ],
    ),
  };

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PrivateChatPageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        _model.addToParticipants(widget.chatMate!.friendUserRef!);
      });
      setState(() {
        _model.addToParticipants(currentUserReference!);
      });
      _model.friendUserDoc =
          await UsersRecord.getDocumentOnce(widget.chatMate!.friendUserRef!);
      await _model.listViewController?.animateTo(
        _model.listViewController!.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
      );
      await Future.delayed(const Duration(milliseconds: 5000));

      await widget.chatMate!.reference.update(createFriendRecordData(
        noOfUnreadMessages: 0,
      ));
    });

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<PrivateChatRealRecord>>(
      stream: queryPrivateChatRealRecord(
        queryBuilder: (privateChatRealRecord) =>
            privateChatRealRecord.whereIn('sender', _model.participants),
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
        List<PrivateChatRealRecord> privateChatPagePrivateChatRealRecordList =
            snapshot.data!;
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
                child: Stack(
                  children: [
                    Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 40.0, 0.0),
                        child: Text(
                          'Chat',
                          style: FlutterFlowTheme.of(context)
                              .headlineMedium
                              .override(
                                fontFamily: 'Outfit',
                                color: Colors.white,
                                fontSize: 22.0,
                                letterSpacing: 0.0,
                              ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(1.0, 1.0),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          context.pushNamed(
                            'ProfilePage',
                            queryParameters: {
                              'isOpenedByOwner': serializeParam(
                                false,
                                ParamType.bool,
                              ),
                              'isOpenedByFriend': serializeParam(
                                true,
                                ParamType.bool,
                              ),
                              'profileDoc': serializeParam(
                                _model.friendUserDoc,
                                ParamType.Document,
                              ),
                            }.withoutNulls,
                            extra: <String, dynamic>{
                              'profileDoc': _model.friendUserDoc,
                            },
                          );
                        },
                        child: Container(
                          width: 40.0,
                          height: 40.0,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.network(
                            _model.friendUserDoc!.photoUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
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
                          EdgeInsetsDirectional.fromSTEB(10.0, 5.0, 10.0, 75.0),
                      child: Builder(
                        builder: (context) {
                          final message =
                              privateChatPagePrivateChatRealRecordList
                                  .sortedList((e) => e.date!)
                                  .toList();
                          return ListView.separated(
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.vertical,
                            itemCount: message.length,
                            separatorBuilder: (_, __) => SizedBox(height: 10.0),
                            itemBuilder: (context, messageIndex) {
                              final messageItem = message[messageIndex];
                              return Builder(
                                builder: (context) {
                                  if (messageItem.sender !=
                                      currentUserReference) {
                                    return Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Color(0x0014181B),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                constraints: BoxConstraints(
                                                  minWidth: 100.0,
                                                  minHeight: 25.0,
                                                  maxWidth:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          0.6,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .tertiary,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(20.0),
                                                    bottomRight:
                                                        Radius.circular(20.0),
                                                    topLeft:
                                                        Radius.circular(0.0),
                                                    topRight:
                                                        Radius.circular(20.0),
                                                  ),
                                                  border: Border.all(
                                                    color: (messageItem
                                                                    .sender !=
                                                                currentUserReference) &&
                                                            !messageItem
                                                                .isRecievedAndRead
                                                        ? FlutterFlowTheme.of(
                                                                context)
                                                            .secondary
                                                        : Colors.transparent,
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.all(10.0),
                                                  child: Text(
                                                    messageItem.message,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Readex Pro',
                                                          color: Colors.white,
                                                          letterSpacing: 0.0,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                dateTimeFormat(
                                                  'jm',
                                                  messageItem.date!,
                                                  locale: FFLocalizations.of(
                                                          context)
                                                      .languageCode,
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Readex Pro',
                                                          color: Colors.white,
                                                          fontSize: 12.0,
                                                          letterSpacing: 0.0,
                                                        ),
                                              ),
                                            ],
                                          ),
                                        ].divide(SizedBox(width: 5.0)),
                                      ),
                                    );
                                  } else {
                                    return Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Color(0x0014181B),
                                      ),
                                      child: Align(
                                        alignment:
                                            AlignmentDirectional(1.0, 0.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  1.0, 0.0),
                                              child: Container(
                                                constraints: BoxConstraints(
                                                  minWidth: 40.0,
                                                  minHeight: 25.0,
                                                  maxWidth:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          0.6,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      blurRadius: 4.0,
                                                      color: Color(0x33000000),
                                                      offset: Offset(
                                                        0.0,
                                                        2.0,
                                                      ),
                                                    )
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(20.0),
                                                    bottomRight:
                                                        Radius.circular(20.0),
                                                    topLeft:
                                                        Radius.circular(20.0),
                                                    topRight:
                                                        Radius.circular(0.0),
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.all(10.0),
                                                  child: Text(
                                                    messageItem.message,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Readex Pro',
                                                          color: Colors.white,
                                                          letterSpacing: 0.0,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  1.0, 0.0),
                                              child: Text(
                                                dateTimeFormat(
                                                  'jm',
                                                  messageItem.date!,
                                                  locale: FFLocalizations.of(
                                                          context)
                                                      .languageCode,
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Readex Pro',
                                                          color: Colors.white,
                                                          fontSize: 12.0,
                                                          letterSpacing: 0.0,
                                                        ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }
                                },
                              );
                            },
                            controller: _model.listViewController,
                          );
                        },
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(0.0, 1.0),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 0.95,
                      height: 80.0,
                      child: Stack(
                        children: [
                          Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  8.0, 0.0, 8.0, 20.0),
                              child: TextFormField(
                                controller: _model.textController,
                                focusNode: _model.textFieldFocusNode,
                                onFieldSubmitted: (_) async {
                                  if (_model.textController.text != null &&
                                      _model.textController.text != '') {
                                    var privateChatRealRecordReference =
                                        PrivateChatRealRecord.collection.doc();
                                    await privateChatRealRecordReference
                                        .set(createPrivateChatRealRecordData(
                                      sender: currentUserReference,
                                      reciever: widget.chatMate?.friendUserRef,
                                      message: _model.textController.text,
                                      date: getCurrentTimestamp,
                                      isRecievedAndRead: false,
                                    ));
                                    _model.createdChatDocumentCopy =
                                        PrivateChatRealRecord
                                            .getDocumentFromData(
                                                createPrivateChatRealRecordData(
                                                  sender: currentUserReference,
                                                  reciever: widget
                                                      .chatMate?.friendUserRef,
                                                  message: _model
                                                      .textController.text,
                                                  date: getCurrentTimestamp,
                                                  isRecievedAndRead: false,
                                                ),
                                                privateChatRealRecordReference);
                                    setState(() {
                                      _model.textController?.clear();
                                    });
                                    unawaited(
                                      () async {
                                        await _model.listViewController
                                            ?.animateTo(
                                          _model.listViewController!.position
                                              .maxScrollExtent,
                                          duration: Duration(milliseconds: 100),
                                          curve: Curves.ease,
                                        );
                                      }(),
                                    );
                                    // friend is chat mate

                                    await widget.chatMate!.reference.update({
                                      ...createFriendRecordData(
                                        lastMessage: _model
                                            .createdChatDocumentCopy?.reference,
                                      ),
                                      ...mapToFirestore(
                                        {
                                          'noOfUnreadMessages':
                                              FieldValue.increment(1),
                                        },
                                      ),
                                    });
                                    _model.friendsFriendUserDocCopy =
                                        await queryFriendRecordOnce(
                                      parent: widget.chatMate?.friendUserRef,
                                      queryBuilder: (friendRecord) =>
                                          friendRecord.where(
                                        'friendUserRef',
                                        isEqualTo: currentUserReference,
                                      ),
                                      singleRecord: true,
                                    ).then((s) => s.firstOrNull);

                                    await UserNotificationRecord.createDoc(
                                            widget.chatMate!.friendUserRef!)
                                        .set(createUserNotificationRecordData(
                                      isPostRenewal: false,
                                      message:
                                          'message from ${_model.friendUserDoc?.displayName}',
                                      userThatSentMessage: currentUserReference,
                                      isPublicChat: false,
                                      isPrivateChat: true,
                                      chatMate: widget.chatMate?.reference,
                                      timeOfPosting: getCurrentTimestamp,
                                      isReaction: false,
                                    ));
                                    triggerPushNotification(
                                      notificationTitle: 'New message',
                                      notificationText:
                                          'message from ${_model.friendUserDoc?.displayName}',
                                      notificationImageUrl:
                                          _model.friendUserDoc?.photoUrl,
                                      userRefs: [
                                        _model.friendUserDoc!.reference
                                      ],
                                      initialPageName: 'privateChatPage',
                                      parameterData: {
                                        'chatMate':
                                            _model.friendsFriendUserDocCopy,
                                      },
                                    );
                                  }

                                  setState(() {});
                                },
                                autofocus: true,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: 'Message here...',
                                  labelStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        letterSpacing: 0.0,
                                      ),
                                  hintStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        letterSpacing: 0.0,
                                      ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .alternate,
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(24.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(24.0),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(24.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(24.0),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      color: Colors.black,
                                      letterSpacing: 0.0,
                                    ),
                                maxLines: 3,
                                minLines: null,
                                validator: _model.textControllerValidator
                                    .asValidator(context),
                              ).animateOnPageLoad(animationsMap[
                                  'textFieldOnPageLoadAnimation']!),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(1.0, 0.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 15.0, 20.0),
                              child: FlutterFlowIconButton(
                                borderRadius: 20.0,
                                borderWidth: 1.0,
                                buttonSize: 40.0,
                                fillColor: FlutterFlowTheme.of(context).accent1,
                                icon: Icon(
                                  Icons.send,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 24.0,
                                ),
                                onPressed: () async {
                                  if (_model.textController.text != null &&
                                      _model.textController.text != '') {
                                    var privateChatRealRecordReference =
                                        PrivateChatRealRecord.collection.doc();
                                    await privateChatRealRecordReference
                                        .set(createPrivateChatRealRecordData(
                                      sender: currentUserReference,
                                      reciever: widget.chatMate?.friendUserRef,
                                      message: _model.textController.text,
                                      date: getCurrentTimestamp,
                                      isRecievedAndRead: false,
                                    ));
                                    _model.createdChatDocument =
                                        PrivateChatRealRecord
                                            .getDocumentFromData(
                                                createPrivateChatRealRecordData(
                                                  sender: currentUserReference,
                                                  reciever: widget
                                                      .chatMate?.friendUserRef,
                                                  message: _model
                                                      .textController.text,
                                                  date: getCurrentTimestamp,
                                                  isRecievedAndRead: false,
                                                ),
                                                privateChatRealRecordReference);
                                    setState(() {
                                      _model.textController?.clear();
                                    });
                                    unawaited(
                                      () async {
                                        await _model.listViewController
                                            ?.animateTo(
                                          _model.listViewController!.position
                                              .maxScrollExtent,
                                          duration: Duration(milliseconds: 100),
                                          curve: Curves.ease,
                                        );
                                      }(),
                                    );
                                    // friend is chat mate

                                    await widget.chatMate!.reference.update({
                                      ...createFriendRecordData(
                                        lastMessage: _model
                                            .createdChatDocument?.reference,
                                      ),
                                      ...mapToFirestore(
                                        {
                                          'noOfUnreadMessages':
                                              FieldValue.increment(1),
                                        },
                                      ),
                                    });
                                    _model.friendsFriendUserDoc =
                                        await queryFriendRecordOnce(
                                      parent: widget.chatMate?.friendUserRef,
                                      queryBuilder: (friendRecord) =>
                                          friendRecord.where(
                                        'friendUserRef',
                                        isEqualTo: currentUserReference,
                                      ),
                                      singleRecord: true,
                                    ).then((s) => s.firstOrNull);

                                    await UserNotificationRecord.createDoc(
                                            widget.chatMate!.friendUserRef!)
                                        .set(createUserNotificationRecordData(
                                      isPostRenewal: false,
                                      message:
                                          'message from ${_model.friendUserDoc?.displayName}',
                                      userThatSentMessage: currentUserReference,
                                      isPublicChat: false,
                                      isPrivateChat: true,
                                      chatMate: widget.chatMate?.reference,
                                      timeOfPosting: getCurrentTimestamp,
                                      isReaction: false,
                                    ));
                                    triggerPushNotification(
                                      notificationTitle: 'New message',
                                      notificationText:
                                          'message from ${_model.friendUserDoc?.displayName}',
                                      notificationImageUrl:
                                          _model.friendUserDoc?.photoUrl,
                                      userRefs: [
                                        _model.friendUserDoc!.reference
                                      ],
                                      initialPageName: 'privateChatPage',
                                      parameterData: {
                                        'chatMate': _model.friendsFriendUserDoc,
                                      },
                                    );
                                  }

                                  setState(() {});
                                },
                              ),
                            ),
                          ),
                        ],
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

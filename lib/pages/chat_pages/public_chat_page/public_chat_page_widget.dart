import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/components/empty_list_component_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import '/custom_code/actions/index.dart' as actions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'public_chat_page_model.dart';
export 'public_chat_page_model.dart';

class PublicChatPageWidget extends StatefulWidget {
  const PublicChatPageWidget({
    super.key,
    required this.place,
  });

  final PlacesRecord? place;

  @override
  State<PublicChatPageWidget> createState() => _PublicChatPageWidgetState();
}

class _PublicChatPageWidgetState extends State<PublicChatPageWidget>
    with TickerProviderStateMixin {
  late PublicChatPageModel _model;

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
    _model = createModel(context, () => PublicChatPageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await widget.place!.reference.update({
        ...mapToFirestore(
          {
            'usersThatAreChatting':
                FieldValue.arrayUnion([currentUserReference]),
          },
        ),
      });
      _model.placeThatUserCheckedIntoRef =
          await queryPlaceUserCheckedIntoRecordOnce(
        parent: currentUserReference,
        queryBuilder: (placeUserCheckedIntoRecord) =>
            placeUserCheckedIntoRecord.where(
          'placeRef',
          isEqualTo: widget.place?.reference,
        ),
        singleRecord: true,
      ).then((s) => s.firstOrNull);

      await _model.placeThatUserCheckedIntoRef!.reference
          .update(createPlaceUserCheckedIntoRecordData(
        noOfUnreadMessage: 0,
      ));
      _model.friendList = await queryFriendRecordOnce(
        parent: currentUserReference,
      );
      setState(() {
        _model.usersFriends = _model.friendList!.toList().cast<FriendRecord>();
      });
      _model.placeRealChatList = await queryPlaceChatRealRecordOnce(
        queryBuilder: (placeChatRealRecord) => placeChatRealRecord.where(
          'place',
          isEqualTo: widget.place?.reference,
        ),
      );
      await actions.placeMessageRedAction(
        currentUserReference!,
        _model.placeRealChatList?.toList(),
      );
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
    return StreamBuilder<List<PlaceChatRealRecord>>(
      stream: queryPlaceChatRealRecord(
        queryBuilder: (placeChatRealRecord) => placeChatRealRecord.where(
          'place',
          isEqualTo: widget.place?.reference,
        ),
      )..listen((snapshot) async {
          List<PlaceChatRealRecord> publicChatPagePlaceChatRealRecordList =
              snapshot;
          if (_model.publicChatPagePreviousSnapshot != null &&
              !const ListEquality(PlaceChatRealRecordDocumentEquality()).equals(
                  publicChatPagePlaceChatRealRecordList,
                  _model.publicChatPagePreviousSnapshot)) {
            await actions.placeMessageRedAction(
              currentUserReference!,
              _model.placeRealChatList?.toList(),
            );

            setState(() {});
          }
          _model.publicChatPagePreviousSnapshot = snapshot;
        }),
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
        List<PlaceChatRealRecord> publicChatPagePlaceChatRealRecordList =
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
              title: Text(
                'group chat (${widget.place?.name})',
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                      fontFamily: 'Outfit',
                      color: Colors.white,
                      fontSize: 22.0,
                      letterSpacing: 0.0,
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
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          10.0, 10.0, 10.0, 75.0),
                      child: Builder(
                        builder: (context) {
                          final message = publicChatPagePlaceChatRealRecordList
                              .sortedList((e) => e.date!)
                              .toList();
                          if (message.isEmpty) {
                            return EmptyListComponentWidget();
                          }
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
                                    return Align(
                                      alignment:
                                          AlignmentDirectional(-1.0, 0.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Align(
                                            alignment:
                                                AlignmentDirectional(0.0, -1.0),
                                            child: StreamBuilder<UsersRecord>(
                                              stream: UsersRecord.getDocument(
                                                  messageItem.sender!),
                                              builder: (context, snapshot) {
                                                // Customize what your widget looks like when it's loading.
                                                if (!snapshot.hasData) {
                                                  return Center(
                                                    child: SizedBox(
                                                      width: 50.0,
                                                      height: 50.0,
                                                      child:
                                                          CircularProgressIndicator(
                                                        valueColor:
                                                            AlwaysStoppedAnimation<
                                                                Color>(
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }
                                                final circleImageUsersRecord =
                                                    snapshot.data!;
                                                return InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    context.pushNamed(
                                                      'ProfilePage',
                                                      queryParameters: {
                                                        'isOpenedByOwner':
                                                            serializeParam(
                                                          false,
                                                          ParamType.bool,
                                                        ),
                                                        'isOpenedByFriend':
                                                            serializeParam(
                                                          _model.usersFriends
                                                              .where((e) =>
                                                                  e.friendUserRef ==
                                                                  circleImageUsersRecord
                                                                      .reference)
                                                              .toList()
                                                              .isNotEmpty,
                                                          ParamType.bool,
                                                        ),
                                                        'profileDoc':
                                                            serializeParam(
                                                          circleImageUsersRecord,
                                                          ParamType.Document,
                                                        ),
                                                      }.withoutNulls,
                                                      extra: <String, dynamic>{
                                                        'profileDoc':
                                                            circleImageUsersRecord,
                                                      },
                                                    );
                                                  },
                                                  child: Container(
                                                    width: 40.0,
                                                    height: 40.0,
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Image.network(
                                                      circleImageUsersRecord
                                                          .photoUrl,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                constraints: BoxConstraints(
                                                  minWidth: 100.0,
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
                                                    color: messageItem
                                                            .paticipantsThatHasReadTheMessage
                                                            .contains(
                                                                currentUserReference)
                                                        ? Colors.transparent
                                                        : FlutterFlowTheme.of(
                                                                context)
                                                            .secondary,
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
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    -1.0, 0.0),
                                                child: Text(
                                                  dateTimeFormat(
                                                    'jm',
                                                    messageItem.date!,
                                                    locale: FFLocalizations.of(
                                                            context)
                                                        .languageCode,
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
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
                                        ].divide(SizedBox(width: 5.0)),
                                      ),
                                    );
                                  } else {
                                    return Align(
                                      alignment: AlignmentDirectional(1.0, 0.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Container(
                                                constraints: BoxConstraints(
                                                  minWidth: 100.0,
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
                            alignment: AlignmentDirectional(0.0, 1.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  8.0, 0.0, 8.0, 20.0),
                              child: TextFormField(
                                controller: _model.textController,
                                focusNode: _model.textFieldFocusNode,
                                onFieldSubmitted: (_) async {
                                  if (_model.textController.text != null &&
                                      _model.textController.text != '') {
                                    var placeChatRealRecordReference =
                                        PlaceChatRealRecord.collection.doc();
                                    await placeChatRealRecordReference.set({
                                      ...createPlaceChatRealRecordData(
                                        sender: currentUserReference,
                                        message: _model.textController.text,
                                        date: getCurrentTimestamp,
                                        place: widget.place?.reference,
                                      ),
                                      ...mapToFirestore(
                                        {
                                          'participants': widget
                                              .place?.usersThatAreChatting,
                                        },
                                      ),
                                    });
                                    _model.createdPlaceChatCopy =
                                        PlaceChatRealRecord.getDocumentFromData(
                                            {
                                          ...createPlaceChatRealRecordData(
                                            sender: currentUserReference,
                                            message: _model.textController.text,
                                            date: getCurrentTimestamp,
                                            place: widget.place?.reference,
                                          ),
                                          ...mapToFirestore(
                                            {
                                              'participants': widget
                                                  .place?.usersThatAreChatting,
                                            },
                                          ),
                                        },
                                            placeChatRealRecordReference);

                                    await widget.place!.reference
                                        .update(createPlacesRecordData(
                                      lastMessage: widget.place?.lastMessage,
                                    ));
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
                                    await actions.addUnreadPlaceMessageToUsers(
                                      widget.place?.userThatAreCheckedIn
                                          ?.where((e) => !widget
                                              .place!.usersThatAreChatting
                                              .contains(e))
                                          .toList()
                                          ?.toList(),
                                      _model.createdPlaceChatCopy?.reference,
                                      widget.place?.reference,
                                    );

                                    await UserNotificationRecord.createDoc(
                                            widget.place!.userThatAreCheckedIn
                                                .first)
                                        .set(createUserNotificationRecordData(
                                      isPostRenewal: false,
                                      message:
                                          'New message at${widget.place?.name}',
                                      userThatSentMessage: currentUserReference,
                                      isPublicChat: true,
                                      isPrivateChat: false,
                                      place: widget.place?.reference,
                                      isReaction: false,
                                      timeOfPosting: getCurrentTimestamp,
                                    ));
                                    _model.placeUserCheckIntoDocCopy =
                                        await queryPlaceUserCheckedIntoRecordOnce(
                                      parent: currentUserReference,
                                      queryBuilder:
                                          (placeUserCheckedIntoRecord) =>
                                              placeUserCheckedIntoRecord.where(
                                        'placeRef',
                                        isEqualTo: widget.place?.reference,
                                      ),
                                      singleRecord: true,
                                    ).then((s) => s.firstOrNull);
                                    triggerPushNotification(
                                      notificationTitle: 'New group message',
                                      notificationText:
                                          'New message at${widget.place?.name}',
                                      notificationImageUrl: currentUserPhoto,
                                      notificationSound: 'default',
                                      userRefs: widget
                                          .place!.userThatAreCheckedIn
                                          .where((e) => !widget
                                              .place!.usersThatAreChatting
                                              .contains(e))
                                          .toList(),
                                      initialPageName: 'publicChatPage',
                                      parameterData: {
                                        'place': widget.place,
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
                                      color: Colors.white,
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
                                      letterSpacing: 0.0,
                                    ),
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
                                  0.0, 0.0, 15.0, 10.0),
                              child: FlutterFlowIconButton(
                                borderRadius: 20.0,
                                borderWidth: 1.0,
                                buttonSize: 40.0,
                                fillColor: FlutterFlowTheme.of(context).accent1,
                                icon: Icon(
                                  Icons.send,
                                  color: Colors.black,
                                  size: 20.0,
                                ),
                                onPressed: () async {
                                  if (_model.textController.text != null &&
                                      _model.textController.text != '') {
                                    var placeChatRealRecordReference =
                                        PlaceChatRealRecord.collection.doc();
                                    await placeChatRealRecordReference.set({
                                      ...createPlaceChatRealRecordData(
                                        sender: currentUserReference,
                                        message: _model.textController.text,
                                        date: getCurrentTimestamp,
                                        place: widget.place?.reference,
                                      ),
                                      ...mapToFirestore(
                                        {
                                          'participants': widget
                                              .place?.usersThatAreChatting,
                                        },
                                      ),
                                    });
                                    _model.createdPlaceChat =
                                        PlaceChatRealRecord.getDocumentFromData(
                                            {
                                          ...createPlaceChatRealRecordData(
                                            sender: currentUserReference,
                                            message: _model.textController.text,
                                            date: getCurrentTimestamp,
                                            place: widget.place?.reference,
                                          ),
                                          ...mapToFirestore(
                                            {
                                              'participants': widget
                                                  .place?.usersThatAreChatting,
                                            },
                                          ),
                                        },
                                            placeChatRealRecordReference);

                                    await widget.place!.reference
                                        .update(createPlacesRecordData(
                                      lastMessage:
                                          _model.createdPlaceChat?.reference,
                                    ));
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
                                    await actions.addUnreadPlaceMessageToUsers(
                                      widget.place?.userThatAreCheckedIn
                                          ?.where((e) => !widget
                                              .place!.usersThatAreChatting
                                              .contains(e))
                                          .toList()
                                          ?.toList(),
                                      _model.createdPlaceChat?.reference,
                                      widget.place?.reference,
                                    );

                                    await UserNotificationRecord.createDoc(
                                            widget.place!.userThatAreCheckedIn
                                                .first)
                                        .set(createUserNotificationRecordData(
                                      isPostRenewal: false,
                                      message:
                                          'New message at${widget.place?.name}',
                                      userThatSentMessage: currentUserReference,
                                      isPublicChat: true,
                                      isPrivateChat: false,
                                      place: widget.place?.reference,
                                      isReaction: false,
                                      timeOfPosting: getCurrentTimestamp,
                                    ));
                                    _model.placeUserCheckIntoDoc =
                                        await queryPlaceUserCheckedIntoRecordOnce(
                                      parent: currentUserReference,
                                      queryBuilder:
                                          (placeUserCheckedIntoRecord) =>
                                              placeUserCheckedIntoRecord.where(
                                        'placeRef',
                                        isEqualTo: widget.place?.reference,
                                      ),
                                      singleRecord: true,
                                    ).then((s) => s.firstOrNull);
                                    triggerPushNotification(
                                      notificationTitle: 'New group message',
                                      notificationText:
                                          'New message at${widget.place?.name}',
                                      notificationImageUrl: currentUserPhoto,
                                      notificationSound: 'default',
                                      userRefs: widget
                                          .place!.userThatAreCheckedIn
                                          .where((e) => !widget
                                              .place!.usersThatAreChatting
                                              .contains(e))
                                          .toList(),
                                      initialPageName: 'publicChatPage',
                                      parameterData: {
                                        'place': widget.place,
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

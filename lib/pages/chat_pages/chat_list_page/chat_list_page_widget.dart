import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/empty_list_component_widget.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'chat_list_page_model.dart';
export 'chat_list_page_model.dart';

class ChatListPageWidget extends StatefulWidget {
  const ChatListPageWidget({super.key});

  @override
  State<ChatListPageWidget> createState() => _ChatListPageWidgetState();
}

class _ChatListPageWidgetState extends State<ChatListPageWidget> {
  late ChatListPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChatListPageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        _model.addToParticipants(currentUserReference!);
      });
      _model.listOfCheckeInPlacDocs = await queryPlaceUserCheckedIntoRecordOnce(
        parent: currentUserReference,
      );
      setState(() {
        _model.listOfPlacesThatUsersCheckedInto = _model.listOfCheckeInPlacDocs!
            .toList()
            .cast<PlaceUserCheckedIntoRecord>();
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
    return StreamBuilder<List<FriendRecord>>(
      stream: queryFriendRecord(
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
        List<FriendRecord> chatListPageFriendRecordList = snapshot.data!;
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
                'Chats',
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
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(18.0),
                          child: FlutterFlowChoiceChips(
                            options: [
                              ChipData('Private Chats', Icons.chat),
                              ChipData('place Chats', Icons.chat)
                            ],
                            onChanged: (val) => setState(() =>
                                _model.choiceChipsValue = val?.firstOrNull),
                            selectedChipStyle: ChipStyle(
                              backgroundColor:
                                  FlutterFlowTheme.of(context).tertiary,
                              textStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    letterSpacing: 0.0,
                                  ),
                              iconColor:
                                  FlutterFlowTheme.of(context).primaryText,
                              iconSize: 18.0,
                              elevation: 4.0,
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            unselectedChipStyle: ChipStyle(
                              backgroundColor:
                                  FlutterFlowTheme.of(context).alternate,
                              textStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    letterSpacing: 0.0,
                                  ),
                              iconColor:
                                  FlutterFlowTheme.of(context).secondaryText,
                              iconSize: 18.0,
                              elevation: 0.0,
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            chipSpacing: 12.0,
                            rowSpacing: 12.0,
                            multiselect: false,
                            initialized: _model.choiceChipsValue != null,
                            alignment: WrapAlignment.start,
                            controller: _model.choiceChipsValueController ??=
                                FormFieldController<List<String>>(
                              ['Private Chats'],
                            ),
                            wrapped: true,
                          ),
                        ),
                        Builder(
                          builder: (context) {
                            if (_model.choiceChipsValue == 'Private Chats') {
                              return Container(
                                constraints: BoxConstraints(
                                  maxHeight:
                                      MediaQuery.sizeOf(context).height * 0.8,
                                ),
                                decoration: BoxDecoration(),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10.0, 10.0, 10.0, 0.0),
                                  child: Builder(
                                    builder: (context) {
                                      final message =
                                          chatListPageFriendRecordList.toList();
                                      if (message.isEmpty) {
                                        return EmptyListComponentWidget(
                                          message: 'No private chat yet',
                                        );
                                      }
                                      return ListView.builder(
                                        padding: EdgeInsets.zero,
                                        scrollDirection: Axis.vertical,
                                        itemCount: message.length,
                                        itemBuilder: (context, messageIndex) {
                                          final messageItem =
                                              message[messageIndex];
                                          return Card(
                                            clipBehavior:
                                                Clip.antiAliasWithSaveLayer,
                                            color: Colors.white,
                                            elevation: 4.0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                            ),
                                            child: Container(
                                              width: double.infinity,
                                              height: 80.0,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .tertiary,
                                                borderRadius:
                                                    BorderRadius.circular(18.0),
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(10.0, 0.0,
                                                                10.0, 0.0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        StreamBuilder<
                                                            UsersRecord>(
                                                          stream: UsersRecord
                                                              .getDocument(
                                                                  messageItem
                                                                      .friendUserRef!),
                                                          builder: (context,
                                                              snapshot) {
                                                            // Customize what your widget looks like when it's loading.
                                                            if (!snapshot
                                                                .hasData) {
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
                                                            return Container(
                                                              width: 60.0,
                                                              height: 60.0,
                                                              clipBehavior: Clip
                                                                  .antiAlias,
                                                              decoration:
                                                                  BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                              child:
                                                                  Image.network(
                                                                valueOrDefault<
                                                                    String>(
                                                                  circleImageUsersRecord
                                                                      .photoUrl,
                                                                  'https://i.ibb.co/gM8GFCN/user-avatar.png',
                                                                ),
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                        Container(
                                                          constraints:
                                                              BoxConstraints(
                                                            maxWidth: 220.0,
                                                          ),
                                                          decoration:
                                                              BoxDecoration(),
                                                          child: StreamBuilder<
                                                              PrivateChatRealRecord>(
                                                            stream: PrivateChatRealRecord
                                                                .getDocument(
                                                                    messageItem
                                                                        .lastMessage!),
                                                            builder: (context,
                                                                snapshot) {
                                                              // Customize what your widget looks like when it's loading.
                                                              if (!snapshot
                                                                  .hasData) {
                                                                return Center(
                                                                  child:
                                                                      SizedBox(
                                                                    width: 50.0,
                                                                    height:
                                                                        50.0,
                                                                    child:
                                                                        CircularProgressIndicator(
                                                                      valueColor:
                                                                          AlwaysStoppedAnimation<
                                                                              Color>(
                                                                        FlutterFlowTheme.of(context)
                                                                            .primary,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              }
                                                              final textPrivateChatRealRecord =
                                                                  snapshot
                                                                      .data!;
                                                              return Text(
                                                                textPrivateChatRealRecord
                                                                    .message,
                                                                maxLines: 1,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Readex Pro',
                                                                      letterSpacing:
                                                                          0.0,
                                                                    ),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ].divide(SizedBox(
                                                          width: 10.0)),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.all(16.0),
                                                    child: Container(
                                                      height: 20.0,
                                                      constraints:
                                                          BoxConstraints(
                                                        minWidth: 20.0,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16.0),
                                                        shape:
                                                            BoxShape.rectangle,
                                                      ),
                                                      child: Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                0.0, 0.0),
                                                        child: Text(
                                                          messageItem
                                                              .noOfUnreadMessages
                                                              .toString(),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Readex Pro',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .tertiary,
                                                                letterSpacing:
                                                                    0.0,
                                                              ),
                                                        ),
                                                      ),
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
                              );
                            } else {
                              return Container(
                                width: double.infinity,
                                constraints: BoxConstraints(
                                  maxHeight:
                                      MediaQuery.sizeOf(context).height * 0.8,
                                ),
                                decoration: BoxDecoration(),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10.0, 10.0, 10.0, 0.0),
                                  child: Builder(
                                    builder: (context) {
                                      final checkedInPlace = _model
                                              .listOfCheckeInPlacDocs
                                              ?.toList() ??
                                          [];
                                      if (checkedInPlace.isEmpty) {
                                        return EmptyListComponentWidget(
                                          message: 'No public chat yet',
                                        );
                                      }
                                      return ListView.builder(
                                        padding: EdgeInsets.zero,
                                        scrollDirection: Axis.vertical,
                                        itemCount: checkedInPlace.length,
                                        itemBuilder:
                                            (context, checkedInPlaceIndex) {
                                          final checkedInPlaceItem =
                                              checkedInPlace[
                                                  checkedInPlaceIndex];
                                          return Card(
                                            clipBehavior:
                                                Clip.antiAliasWithSaveLayer,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                            elevation: 4.0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                            ),
                                            child: Visibility(
                                              visible:
                                                  checkedInPlaceItem.placeRef !=
                                                      null,
                                              child:
                                                  StreamBuilder<PlacesRecord>(
                                                stream:
                                                    PlacesRecord.getDocument(
                                                        checkedInPlaceItem
                                                            .placeRef!),
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
                                                  final containerPlacesRecord =
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
                                                        'publicChatPage',
                                                        queryParameters: {
                                                          'place':
                                                              serializeParam(
                                                            containerPlacesRecord,
                                                            ParamType.Document,
                                                          ),
                                                        }.withoutNulls,
                                                        extra: <String,
                                                            dynamic>{
                                                          'place':
                                                              containerPlacesRecord,
                                                        },
                                                      );
                                                    },
                                                    child: Container(
                                                      width: double.infinity,
                                                      height: 80.0,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .tertiary,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(18.0),
                                                      ),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        10.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Container(
                                                                  width: 60.0,
                                                                  height: 60.0,
                                                                  clipBehavior:
                                                                      Clip.antiAlias,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                  ),
                                                                  child: Image
                                                                      .network(
                                                                    valueOrDefault<
                                                                        String>(
                                                                      containerPlacesRecord
                                                                          .thumbnailImage,
                                                                      'https://picsum.photos/seed/8/600',
                                                                    ),
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                                Builder(
                                                                  builder:
                                                                      (context) {
                                                                    if (containerPlacesRecord
                                                                            .lastMessage !=
                                                                        null) {
                                                                      return Container(
                                                                        constraints:
                                                                            BoxConstraints(
                                                                          maxWidth:
                                                                              220.0,
                                                                        ),
                                                                        decoration:
                                                                            BoxDecoration(),
                                                                        child: StreamBuilder<
                                                                            PlaceChatRealRecord>(
                                                                          stream:
                                                                              PlaceChatRealRecord.getDocument(containerPlacesRecord.lastMessage!),
                                                                          builder:
                                                                              (context, snapshot) {
                                                                            // Customize what your widget looks like when it's loading.
                                                                            if (!snapshot.hasData) {
                                                                              return Center(
                                                                                child: SizedBox(
                                                                                  width: 20.0,
                                                                                  height: 20.0,
                                                                                  child: CircularProgressIndicator(
                                                                                    valueColor: AlwaysStoppedAnimation<Color>(
                                                                                      FlutterFlowTheme.of(context).primary,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            }
                                                                            final textPlaceChatRealRecord =
                                                                                snapshot.data!;
                                                                            return Text(
                                                                              textPlaceChatRealRecord.message,
                                                                              maxLines: 1,
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: 'Readex Pro',
                                                                                    letterSpacing: 0.0,
                                                                                  ),
                                                                            );
                                                                          },
                                                                        ),
                                                                      );
                                                                    } else {
                                                                      return Container(
                                                                        decoration:
                                                                            BoxDecoration(),
                                                                      );
                                                                    }
                                                                  },
                                                                ),
                                                              ].divide(SizedBox(
                                                                  width: 10.0)),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    16.0),
                                                            child: Container(
                                                              height: 20.0,
                                                              constraints:
                                                                  BoxConstraints(
                                                                minWidth: 20.0,
                                                              ),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            16.0),
                                                                shape: BoxShape
                                                                    .rectangle,
                                                              ),
                                                              child: Visibility(
                                                                visible:
                                                                    checkedInPlaceItem
                                                                            .noOfUnreadMessage !=
                                                                        null,
                                                                child: Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          0.0,
                                                                          0.0),
                                                                  child: Text(
                                                                    valueOrDefault<
                                                                        String>(
                                                                      checkedInPlaceItem
                                                                          .noOfUnreadMessage
                                                                          .toString(),
                                                                      'fiudgffs',
                                                                    ),
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              'Readex Pro',
                                                                          color:
                                                                              FlutterFlowTheme.of(context).tertiary,
                                                                          letterSpacing:
                                                                              0.0,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ],
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

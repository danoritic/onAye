import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/edit_profile_component/edit_profile_component_widget.dart';
import '/components/empty_list_component_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_video_player.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'profile_page_model.dart';
export 'profile_page_model.dart';

class ProfilePageWidget extends StatefulWidget {
  const ProfilePageWidget({
    super.key,
    bool? isOpenedByOwner,
    bool? isOpenedByFriend,
    this.profileDoc,
  })  : this.isOpenedByOwner = isOpenedByOwner ?? true,
        this.isOpenedByFriend = isOpenedByFriend ?? false;

  final bool isOpenedByOwner;
  final bool isOpenedByFriend;
  final UsersRecord? profileDoc;

  @override
  State<ProfilePageWidget> createState() => _ProfilePageWidgetState();
}

class _ProfilePageWidgetState extends State<ProfilePageWidget> {
  late ProfilePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfilePageModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).tertiary,
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
              size: 24.0,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
          title: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 0.0, 0.0),
            child: Text(
              'Profile Page',
              style: FlutterFlowTheme.of(context).headlineMedium.override(
                    fontFamily: 'Outfit',
                    color: Colors.white,
                    fontSize: 22.0,
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
          child: Align(
            alignment: AlignmentDirectional(0.0, -1.0),
            child: Container(
              width: double.infinity,
              constraints: BoxConstraints(
                maxWidth: 770.0,
              ),
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
              child: Stack(
                children: [
                  Align(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 45.0, 0.0, 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Container(
                              width: 90.0,
                              height: 90.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).accent2,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).secondary,
                                  width: 2.0,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(4.0),
                                child: AuthUserStreamWidget(
                                  builder: (context) => ClipRRect(
                                    borderRadius: BorderRadius.circular(50.0),
                                    child: CachedNetworkImage(
                                      fadeInDuration:
                                          Duration(milliseconds: 500),
                                      fadeOutDuration:
                                          Duration(milliseconds: 500),
                                      imageUrl: valueOrDefault<String>(
                                        widget.profileDoc != null
                                            ? widget.profileDoc?.photoUrl
                                            : currentUserPhoto,
                                        'https://i.ibb.co/gM8GFCN/user-avatar.png',
                                      ),
                                      width: 100.0,
                                      height: 100.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          AuthUserStreamWidget(
                            builder: (context) => Text(
                              valueOrDefault<String>(
                                widget.profileDoc != null
                                    ? widget.profileDoc?.displayName
                                    : currentUserDisplayName,
                                'No Name',
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .displaySmall
                                  .override(
                                    fontFamily: 'Outfit',
                                    fontSize: 24.0,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                          ),
                          if (widget.isOpenedByOwner)
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 10.0, 10.0, 0.0),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  GoRouter.of(context).prepareAuthEvent();
                                  await authManager.signOut();
                                  GoRouter.of(context).clearRedirectLocation();

                                  context.goNamedAuth(
                                      'InitialPage', context.mounted);
                                },
                                text: 'Log out',
                                options: FFButtonOptions(
                                  height: 30.0,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      24.0, 0.0, 24.0, 0.0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color: FlutterFlowTheme.of(context).tertiary,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color: Colors.white,
                                        fontSize: 14.0,
                                        letterSpacing: 0.0,
                                      ),
                                  elevation: 3.0,
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(14.0),
                                ),
                              ),
                            ),
                          Align(
                            alignment: AlignmentDirectional(-1.0, 0.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  24.0, 4.0, 0.0, 0.0),
                              child: Text(
                                'Media',
                                style: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                      fontSize: 18.0,
                                      letterSpacing: 0.0,
                                    ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: StreamBuilder<List<CheckInsRecord>>(
                                  stream: queryCheckInsRecord(
                                    queryBuilder: (checkInsRecord) =>
                                        checkInsRecord.where(
                                      'owner',
                                      isEqualTo: widget.profileDoc != null
                                          ? widget.profileDoc?.reference
                                          : currentUserReference,
                                    ),
                                  ),
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
                                    List<CheckInsRecord>
                                        gridViewCheckInsRecordList =
                                        snapshot.data!;
                                    if (gridViewCheckInsRecordList.isEmpty) {
                                      return EmptyListComponentWidget(
                                        message: 'No checkins here',
                                      );
                                    }
                                    return GridView.builder(
                                      padding: EdgeInsets.zero,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 5.0,
                                        mainAxisSpacing: 5.0,
                                        childAspectRatio: 0.65,
                                      ),
                                      scrollDirection: Axis.vertical,
                                      itemCount:
                                          gridViewCheckInsRecordList.length,
                                      itemBuilder: (context, gridViewIndex) {
                                        final gridViewCheckInsRecord =
                                            gridViewCheckInsRecordList[
                                                gridViewIndex];
                                        return InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            context.pushNamed(
                                              'tiktokStatusLikeMediaDisplay',
                                              queryParameters: {
                                                'jasonVersionOfMediaType':
                                                    serializeParam(
                                                  gridViewCheckInsRecord.media
                                                      .toMap(),
                                                  ParamType.JSON,
                                                ),
                                                'checkin': serializeParam(
                                                  gridViewCheckInsRecord,
                                                  ParamType.Document,
                                                ),
                                                'isOpenedByTheOwner':
                                                    serializeParam(
                                                  widget.isOpenedByOwner,
                                                  ParamType.bool,
                                                ),
                                              }.withoutNulls,
                                              extra: <String, dynamic>{
                                                'checkin':
                                                    gridViewCheckInsRecord,
                                              },
                                            );
                                          },
                                          child: Container(
                                            width: 100.0,
                                            height: 100.0,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .tertiary,
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            child: Stack(
                                              children: [
                                                Builder(
                                                  builder: (context) {
                                                    if (gridViewCheckInsRecord
                                                                .media
                                                                .isPhoto !=
                                                            null
                                                        ? gridViewCheckInsRecord
                                                            .media.isPhoto
                                                        : false) {
                                                      return ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                        child: Image.network(
                                                          gridViewCheckInsRecord
                                                              .media.photoPath,
                                                          width: 300.0,
                                                          height: 200.0,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      );
                                                    } else {
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
                                                            'tiktokStatusLikeMediaDisplay',
                                                            queryParameters: {
                                                              'jasonVersionOfMediaType':
                                                                  serializeParam(
                                                                gridViewCheckInsRecord
                                                                    .media
                                                                    .toMap(),
                                                                ParamType.JSON,
                                                              ),
                                                              'checkin':
                                                                  serializeParam(
                                                                gridViewCheckInsRecord,
                                                                ParamType
                                                                    .Document,
                                                              ),
                                                              'isOpenedByTheOwner':
                                                                  serializeParam(
                                                                widget
                                                                    .isOpenedByOwner,
                                                                ParamType.bool,
                                                              ),
                                                            }.withoutNulls,
                                                            extra: <String,
                                                                dynamic>{
                                                              'checkin':
                                                                  gridViewCheckInsRecord,
                                                            },
                                                          );
                                                        },
                                                        child:
                                                            FlutterFlowVideoPlayer(
                                                          path:
                                                              gridViewCheckInsRecord
                                                                  .media
                                                                  .videoPath,
                                                          videoType:
                                                              VideoType.network,
                                                          height: 31000.0,
                                                          aspectRatio: 1.00,
                                                          autoPlay: false,
                                                          looping: true,
                                                          showControls: false,
                                                          allowFullScreen: true,
                                                          allowPlaybackSpeedMenu:
                                                              false,
                                                        ),
                                                      );
                                                    }
                                                  },
                                                ),
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.0, 1.01),
                                                  child: Container(
                                                    width: double.infinity,
                                                    height: 30.0,
                                                    decoration: BoxDecoration(
                                                      color: Color(0x3EFFFFFF),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(
                                                                10.0),
                                                        bottomRight:
                                                            Radius.circular(
                                                                10.0),
                                                        topLeft:
                                                            Radius.circular(
                                                                0.0),
                                                        topRight:
                                                            Radius.circular(
                                                                0.0),
                                                      ),
                                                    ),
                                                    child: Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0.0, 0.0),
                                                      child: StreamBuilder<
                                                          PlacesRecord>(
                                                        stream: PlacesRecord
                                                            .getDocument(
                                                                gridViewCheckInsRecord
                                                                    .place!),
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
                                                          final textPlacesRecord =
                                                              snapshot.data!;
                                                          return Text(
                                                            textPlacesRecord
                                                                .name,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Readex Pro',
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                          );
                                                        },
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
                            ),
                          ),
                        ].divide(SizedBox(height: 10.0)),
                      ),
                    ),
                  ),
                  if (widget.isOpenedByFriend)
                    Align(
                      alignment: AlignmentDirectional(-1.0, -1.0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            10.0, 10.0, 0.0, 0.0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            _model.friendDoc = await queryFriendRecordOnce(
                              parent: currentUserReference,
                              queryBuilder: (friendRecord) =>
                                  friendRecord.where(
                                'friendUserRef',
                                isEqualTo: widget.profileDoc?.reference,
                              ),
                              singleRecord: true,
                            ).then((s) => s.firstOrNull);
                            // chat mate is friend

                            context.pushNamed(
                              'privateChatPage',
                              queryParameters: {
                                'chatMate': serializeParam(
                                  _model.friendDoc,
                                  ParamType.Document,
                                ),
                              }.withoutNulls,
                              extra: <String, dynamic>{
                                'chatMate': _model.friendDoc,
                              },
                            );

                            setState(() {});
                          },
                          text: 'Chat',
                          options: FFButtonOptions(
                            height: 30.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                24.0, 0.0, 24.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context).tertiary,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  fontFamily: 'Readex Pro',
                                  color: Colors.white,
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                ),
                            elevation: 3.0,
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                        ),
                      ),
                    ),
                  Align(
                    alignment: AlignmentDirectional(1.0, -1.0),
                    child: Builder(
                      builder: (context) {
                        if (widget.isOpenedByOwner) {
                          return Visibility(
                            visible: widget.isOpenedByOwner,
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 10.0, 10.0, 0.0),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  await showModalBottomSheet(
                                    isScrollControlled: true,
                                    backgroundColor: Color(0x3A000000),
                                    useSafeArea: true,
                                    context: context,
                                    builder: (context) {
                                      return GestureDetector(
                                        onTap: () => _model
                                                .unfocusNode.canRequestFocus
                                            ? FocusScope.of(context)
                                                .requestFocus(
                                                    _model.unfocusNode)
                                            : FocusScope.of(context).unfocus(),
                                        child: Padding(
                                          padding:
                                              MediaQuery.viewInsetsOf(context),
                                          child: EditProfileComponentWidget(
                                            userRef: currentUserReference!,
                                          ),
                                        ),
                                      );
                                    },
                                  ).then((value) => safeSetState(() {}));
                                },
                                text: 'Edit profile',
                                options: FFButtonOptions(
                                  height: 30.0,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      24.0, 0.0, 24.0, 0.0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color: FlutterFlowTheme.of(context).tertiary,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color: Colors.white,
                                        fontSize: 14.0,
                                        letterSpacing: 0.0,
                                      ),
                                  elevation: 3.0,
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(14.0),
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Visibility(
                            visible: widget.isOpenedByOwner,
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 10.0, 10.0, 0.0),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  await showModalBottomSheet(
                                    isScrollControlled: true,
                                    backgroundColor: Color(0x3A000000),
                                    useSafeArea: true,
                                    context: context,
                                    builder: (context) {
                                      return GestureDetector(
                                        onTap: () => _model
                                                .unfocusNode.canRequestFocus
                                            ? FocusScope.of(context)
                                                .requestFocus(
                                                    _model.unfocusNode)
                                            : FocusScope.of(context).unfocus(),
                                        child: Padding(
                                          padding:
                                              MediaQuery.viewInsetsOf(context),
                                          child: EditProfileComponentWidget(
                                            userRef: currentUserReference!,
                                          ),
                                        ),
                                      );
                                    },
                                  ).then((value) => safeSetState(() {}));
                                },
                                text: 'common check ins',
                                options: FFButtonOptions(
                                  height: 30.0,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      24.0, 0.0, 24.0, 0.0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color: FlutterFlowTheme.of(context).tertiary,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color: Colors.white,
                                        fontSize: 14.0,
                                        letterSpacing: 0.0,
                                      ),
                                  elevation: 3.0,
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(14.0),
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

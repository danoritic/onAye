import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_video_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'checkins_card_for_see_all_page_model.dart';
export 'checkins_card_for_see_all_page_model.dart';

class CheckinsCardForSeeAllPageWidget extends StatefulWidget {
  const CheckinsCardForSeeAllPageWidget({
    super.key,
    required this.checkInDocument,
  });

  final CheckInsRecord? checkInDocument;

  @override
  State<CheckinsCardForSeeAllPageWidget> createState() =>
      _CheckinsCardForSeeAllPageWidgetState();
}

class _CheckinsCardForSeeAllPageWidgetState
    extends State<CheckinsCardForSeeAllPageWidget> {
  late CheckinsCardForSeeAllPageModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CheckinsCardForSeeAllPageModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.ownerUserDoc =
          await UsersRecord.getDocumentOnce(widget.checkInDocument!.owner!);
      _model.checkinPlaceDoc =
          await PlacesRecord.getDocumentOnce(widget.checkInDocument!.place!);
      setState(() {
        _model.isLoved =
            widget.checkInDocument!.reactants.contains(currentUserReference);
      });
    });
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 12.0),
      child: Container(
        width: double.infinity,
        height: 356.0,
        constraints: BoxConstraints(
          maxWidth: 500.0,
        ),
        decoration: BoxDecoration(
          color: Color(0xFFF6E8E2),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(4.0, 4.0, 4.0, 12.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: 60.0,
                    height: 60.0,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.network(
                      _model.ownerUserDoc!.photoUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    width: 140.0,
                    decoration: BoxDecoration(),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 0.0),
                      child: StreamBuilder<UsersRecord>(
                        stream: UsersRecord.getDocument(
                            widget.checkInDocument!.owner!),
                        builder: (context, snapshot) {
                          // Customize what your widget looks like when it's loading.
                          if (!snapshot.hasData) {
                            return Center(
                              child: SizedBox(
                                width: 50.0,
                                height: 50.0,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    FlutterFlowTheme.of(context).primary,
                                  ),
                                ),
                              ),
                            );
                          }
                          final textUsersRecord = snapshot.data!;
                          return Text(
                            textUsersRecord.displayName,
                            style:
                                FlutterFlowTheme.of(context).bodyLarge.override(
                                      fontFamily: 'Readex Pro',
                                      letterSpacing: 0.0,
                                    ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                  child: Container(
                    height: 179.0,
                    child: Stack(
                      children: [
                        Builder(
                          builder: (context) {
                            if (widget.checkInDocument?.media != null) {
                              return InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  context.pushNamed(
                                    'tiktokStatusLikeMediaDisplay',
                                    queryParameters: {
                                      'jasonVersionOfMediaType': serializeParam(
                                        widget.checkInDocument?.media?.toMap(),
                                        ParamType.JSON,
                                      ),
                                      'checkin': serializeParam(
                                        widget.checkInDocument,
                                        ParamType.Document,
                                      ),
                                    }.withoutNulls,
                                    extra: <String, dynamic>{
                                      'checkin': widget.checkInDocument,
                                    },
                                  );
                                },
                                child: Builder(
                                  builder: (context) {
                                    if (valueOrDefault<bool>(
                                      widget.checkInDocument?.media?.isPhoto,
                                      true,
                                    )) {
                                      return ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        child: Image.network(
                                          widget
                                              .checkInDocument!.media.photoPath,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      );
                                    } else {
                                      return Container(
                                        width: 190.0,
                                        height: double.infinity,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        child: FlutterFlowVideoPlayer(
                                          path: widget
                                              .checkInDocument!.media.videoPath,
                                          videoType: VideoType.network,
                                          width: double.infinity,
                                          height: 335.0,
                                          autoPlay: false,
                                          looping: true,
                                          showControls: false,
                                          allowFullScreen: true,
                                          allowPlaybackSpeedMenu: false,
                                        ),
                                      );
                                    }
                                  },
                                ),
                              );
                            } else {
                              return Align(
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    'https://i.ibb.co/gM8GFCN/user-avatar.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                        Align(
                          alignment: AlignmentDirectional(0.0, 1.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0x5514181B),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20.0),
                                bottomRight: Radius.circular(20.0),
                                topLeft: Radius.circular(0.0),
                                topRight: Radius.circular(0.0),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 2.5),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      if (!_model.isLoved) {
                                        setState(() {
                                          _model.isLoved = true;
                                        });

                                        await widget.checkInDocument!.reference
                                            .update({
                                          ...mapToFirestore(
                                            {
                                              'Reactants':
                                                  FieldValue.arrayUnion(
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
                                            isEqualTo:
                                                widget.checkInDocument?.owner,
                                          ),
                                          singleRecord: true,
                                        ).then((s) => s.firstOrNull);
                                        if (_model.foundFriendDoc != null) {
                                          triggerPushNotification(
                                            notificationTitle: 'Post reaction',
                                            notificationText:
                                                'Your post at ${_model.checkinPlaceDoc?.name}was liked by ${currentUserDisplayName}react to their checkin photo, to chat with them privately',
                                            notificationImageUrl:
                                                currentUserPhoto,
                                            userRefs: [
                                              widget.checkInDocument!.owner!
                                            ],
                                            initialPageName: 'ProfilePage',
                                            parameterData: {
                                              'isOpenedByOwner': false,
                                              'isOpenedByFriend': false,
                                              'profileDoc':
                                                  currentUserReference,
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
                                              isEqualTo:
                                                  widget.checkInDocument?.owner,
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
                                                  widget.checkInDocument?.owner,
                                              noOfUnreadMessages: 0,
                                            ));

                                            await FriendRecord.createDoc(widget
                                                    .checkInDocument!.owner!)
                                                .set(createFriendRecordData(
                                              friendUserRef:
                                                  currentUserReference,
                                              noOfUnreadMessages: 0,
                                            ));
                                            await _model
                                                .listofPotentialChatMate!
                                                .first
                                                .reference
                                                .delete();
                                            triggerPushNotification(
                                              notificationTitle:
                                                  'Post reaction',
                                              notificationText:
                                                  'Your post at ${_model.checkinPlaceDoc?.name}was liked by ${currentUserDisplayName}react to their checkin photo, to chat with them privately',
                                              notificationImageUrl:
                                                  currentUserPhoto,
                                              userRefs: [
                                                widget.checkInDocument!.owner!
                                              ],
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
                                              parent:
                                                  widget.checkInDocument?.owner,
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
                                                      .createDoc(widget
                                                          .checkInDocument!
                                                          .owner!)
                                                  .set(
                                                      createUserPotentialChatMateRecordData(
                                                checkIn: widget
                                                    .checkInDocument?.reference,
                                                userThatReacted:
                                                    currentUserReference,
                                              ));
                                            }
                                            triggerPushNotification(
                                              notificationTitle:
                                                  'Post reaction',
                                              notificationText:
                                                  'Your post at ${_model.checkinPlaceDoc?.name}was liked by ${currentUserDisplayName}react to their checkin photo, to chat with them privately',
                                              notificationImageUrl:
                                                  currentUserPhoto,
                                              userRefs: [
                                                widget.checkInDocument!.owner!
                                              ],
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

                                        var userNotificationRecordReference =
                                            UserNotificationRecord.createDoc(
                                                widget.checkInDocument!.owner!);
                                        await userNotificationRecordReference
                                            .set(
                                                createUserNotificationRecordData(
                                          isPostRenewal: false,
                                          message:
                                              'Your post at ${_model.checkinPlaceDoc?.name}was liked by ${currentUserDisplayName}react to their checkin photo, to chat with them privately',
                                          userThatSentMessage:
                                              currentUserReference,
                                          timeOfPosting: getCurrentTimestamp,
                                          isReaction: true,
                                          isPublicChat: false,
                                          isPrivateChat: false,
                                          place: widget.checkInDocument?.place,
                                          checkIn:
                                              widget.checkInDocument?.reference,
                                        ));
                                        _model.createdUserNotificationDoc =
                                            UserNotificationRecord.getDocumentFromData(
                                                createUserNotificationRecordData(
                                                  isPostRenewal: false,
                                                  message:
                                                      'Your post at ${_model.checkinPlaceDoc?.name}was liked by ${currentUserDisplayName}react to their checkin photo, to chat with them privately',
                                                  userThatSentMessage:
                                                      currentUserReference,
                                                  timeOfPosting:
                                                      getCurrentTimestamp,
                                                  isReaction: true,
                                                  isPublicChat: false,
                                                  isPrivateChat: false,
                                                  place: widget
                                                      .checkInDocument?.place,
                                                  checkIn: widget
                                                      .checkInDocument
                                                      ?.reference,
                                                ),
                                                userNotificationRecordReference);
                                      }

                                      setState(() {});
                                    },
                                    child: Icon(
                                      Icons.favorite_rounded,
                                      color: valueOrDefault<Color>(
                                        _model.isLoved
                                            ? FlutterFlowTheme.of(context).error
                                            : Colors.white,
                                        Colors.white,
                                      ),
                                      size: 24.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 4.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      dateTimeFormat(
                        'relative',
                        widget.checkInDocument!.time!,
                        locale: FFLocalizations.of(context).languageCode,
                      ),
                      style: FlutterFlowTheme.of(context).labelSmall.override(
                            fontFamily: 'Readex Pro',
                            letterSpacing: 0.0,
                          ),
                    ),
                    Text(
                      '${widget.checkInDocument?.noOfReactants?.toString()} Reactions',
                      style: FlutterFlowTheme.of(context).labelSmall.override(
                            fontFamily: 'Readex Pro',
                            letterSpacing: 0.0,
                          ),
                    ),
                  ],
                ),
              ),
            ].divide(SizedBox(height: 5.0)),
          ),
        ),
      ),
    );
  }
}

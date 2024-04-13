import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'maps_popup_component_model.dart';
export 'maps_popup_component_model.dart';

class MapsPopupComponentWidget extends StatefulWidget {
  const MapsPopupComponentWidget({
    super.key,
    required this.placeToCheckInto,
  });

  final PlacesRecord? placeToCheckInto;

  @override
  State<MapsPopupComponentWidget> createState() =>
      _MapsPopupComponentWidgetState();
}

class _MapsPopupComponentWidgetState extends State<MapsPopupComponentWidget> {
  late MapsPopupComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MapsPopupComponentModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: AlignmentDirectional(0.0, 1.0),
          child: Container(
            width: double.infinity,
            constraints: BoxConstraints(
              maxHeight: MediaQuery.sizeOf(context).height * 0.66,
            ),
            decoration: BoxDecoration(
              color: Color(0xFFF6E8E2),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0.0),
                bottomRight: Radius.circular(0.0),
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                  alignment: AlignmentDirectional(0.0, -1.0),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                    child: Container(
                      width: 30.0,
                      height: 5.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).tertiary,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: FlutterFlowTheme.of(context).tertiary,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(),
                    child: Container(
                      width: double.infinity,
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 40.0),
                        child: PageView(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: _model.pageViewController ??=
                              PageController(
                                  initialPage: min(
                                      valueOrDefault<int>(
                                        _model.shownIndex,
                                        0,
                                      ),
                                      1)),
                          scrollDirection: Axis.horizontal,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Align(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: Builder(
                                    builder: (context) {
                                      if (!_model.uploadedMediaType) {
                                        return Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              'Add a photo or  video for \nothers to see',
                                              textAlign: TextAlign.center,
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Readex Pro',
                                                    color: Color(0xFF9BA5AD),
                                                    letterSpacing: 0.0,
                                                  ),
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Container(
                                                  width: 100.0,
                                                  height: 105.0,
                                                  child: Stack(
                                                    children: [
                                                      Container(
                                                        width: 100.0,
                                                        height: 105.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      12.0),
                                                          border: Border.all(
                                                            color: Color(
                                                                0xFF9BA5AD),
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  6.0),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .photo_camera,
                                                                color: Color(
                                                                    0xFF9BA5AD),
                                                                size: 70.0,
                                                              ),
                                                              Text(
                                                                'Upload photo',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Readex Pro',
                                                                      color: Color(
                                                                          0xFF9BA5AD),
                                                                      fontSize:
                                                                          12.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                    ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      FFButtonWidget(
                                                        onPressed: () async {
                                                          _model.photoFile =
                                                              await actions
                                                                  .customSingleFilePicker(
                                                            context,
                                                            70,
                                                            true,
                                                            false,
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .tertiary,
                                                          );
                                                          _model.isFitForUploa =
                                                              await actions
                                                                  .actionToFilterMedia(
                                                            _model.photoFile!,
                                                            true,
                                                          );
                                                          if (_model
                                                              .isFitForUploa!) {
                                                            setState(() {
                                                              _model.uploadedMediaType =
                                                                  true;
                                                              _model.uploadedMediaFile =
                                                                  _model
                                                                      .photoFile;
                                                            });
                                                          } else {
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              SnackBar(
                                                                content: Text(
                                                                  'Your image too large, it must not be more than 32 mb',
                                                                  style:
                                                                      TextStyle(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryText,
                                                                  ),
                                                                ),
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        4000),
                                                                backgroundColor:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondary,
                                                              ),
                                                            );
                                                            await showDialog(
                                                              context: context,
                                                              builder:
                                                                  (alertDialogContext) {
                                                                return AlertDialog(
                                                                  title: Text(
                                                                      'Media Error'),
                                                                  content: Text(
                                                                      'Your image too large, it must not be more than 32 mb'),
                                                                  actions: [
                                                                    TextButton(
                                                                      onPressed:
                                                                          () =>
                                                                              Navigator.pop(alertDialogContext),
                                                                      child: Text(
                                                                          'Ok'),
                                                                    ),
                                                                  ],
                                                                );
                                                              },
                                                            );
                                                          }

                                                          setState(() {});
                                                        },
                                                        text: '',
                                                        options:
                                                            FFButtonOptions(
                                                          width:
                                                              double.infinity,
                                                          height:
                                                              double.infinity,
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      24.0,
                                                                      0.0,
                                                                      24.0,
                                                                      0.0),
                                                          iconPadding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          color:
                                                              Color(0x004B39EF),
                                                          textStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleSmall
                                                                  .override(
                                                                    fontFamily:
                                                                        'Readex Pro',
                                                                    color: Colors
                                                                        .white,
                                                                    letterSpacing:
                                                                        0.0,
                                                                  ),
                                                          elevation: 0.0,
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors
                                                                .transparent,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Stack(
                                                  children: [
                                                    Container(
                                                      width: 100.0,
                                                      height: 105.0,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12.0),
                                                        border: Border.all(
                                                          color:
                                                              Color(0xFF9BA5AD),
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(6.0),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .video_camera_front_rounded,
                                                              color: Color(
                                                                  0xFF9BA5AD),
                                                              size: 70.0,
                                                            ),
                                                            Text(
                                                              'Upload video',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Readex Pro',
                                                                    color: Color(
                                                                        0xFF9BA5AD),
                                                                    fontSize:
                                                                        12.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                  ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    FFButtonWidget(
                                                      onPressed: () async {
                                                        _model.videoFile =
                                                            await actions
                                                                .customSingleFilePicker(
                                                          context,
                                                          70,
                                                          false,
                                                          true,
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .tertiary,
                                                        );
                                                        _model.isVideoSizeCorrect =
                                                            await actions
                                                                .actionToFilterMedia(
                                                          _model.videoFile!,
                                                          false,
                                                        );
                                                        if (_model
                                                            .isVideoSizeCorrect!) {
                                                          setState(() {
                                                            _model.uploadedMediaType =
                                                                true;
                                                            _model.uploadedMediaFile =
                                                                _model
                                                                    .videoFile;
                                                          });
                                                        } else {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                              content: Text(
                                                                'video Too Large, it must not be more than 340 mb',
                                                                style:
                                                                    TextStyle(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                ),
                                                              ),
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      4000),
                                                              backgroundColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondary,
                                                            ),
                                                          );
                                                        }

                                                        setState(() {});
                                                      },
                                                      text: '',
                                                      options: FFButtonOptions(
                                                        width: 100.0,
                                                        height: 100.0,
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    24.0,
                                                                    0.0,
                                                                    24.0,
                                                                    0.0),
                                                        iconPadding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0),
                                                        color:
                                                            Color(0x004B39EF),
                                                        textStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .override(
                                                                  fontFamily:
                                                                      'Readex Pro',
                                                                  color: Colors
                                                                      .white,
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                        elevation: 0.0,
                                                        borderSide: BorderSide(
                                                          color: Colors
                                                              .transparent,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ].divide(SizedBox(height: 30.0)),
                                        );
                                      } else {
                                        return Builder(
                                          builder: (context) {
                                            if (_model.photoFile != null &&
                                                (_model.photoFile?.bytes
                                                        ?.isNotEmpty ??
                                                    false)) {
                                              return Builder(
                                                builder: (context) {
                                                  if (_model.uploadedMediaFile !=
                                                          null &&
                                                      (_model
                                                              .uploadedMediaFile
                                                              ?.bytes
                                                              ?.isNotEmpty ??
                                                          false)) {
                                                    return ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                      child: Image.memory(
                                                        _model.uploadedMediaFile
                                                                ?.bytes ??
                                                            Uint8List.fromList(
                                                                []),
                                                        width: 300.0,
                                                        height: 200.0,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    );
                                                  } else {
                                                    return Icon(
                                                      Icons.perm_media,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryText,
                                                      size: 150.0,
                                                    );
                                                  }
                                                },
                                              );
                                            } else {
                                              return Container(
                                                width: double.infinity,
                                                height: 200.0,
                                                child: custom_widgets
                                                    .CustomVideoPlayer(
                                                  width: double.infinity,
                                                  height: 200.0,
                                                  file: _model.videoFile!,
                                                ),
                                              );
                                            }
                                          },
                                        );
                                      }
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      15.0, 0.0, 15.0, 0.0),
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      await _model.pageViewController?.nextPage(
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.ease,
                                      );
                                    },
                                    text: 'Add caption',
                                    options: FFButtonOptions(
                                      width: double.infinity,
                                      height: 40.0,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          24.0, 0.0, 24.0, 0.0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color:
                                          FlutterFlowTheme.of(context).tertiary,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            fontFamily: 'Readex Pro',
                                            color: Colors.white,
                                            letterSpacing: 0.0,
                                          ),
                                      elevation: 3.0,
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(18.0),
                                    ),
                                  ),
                                ),
                              ].divide(SizedBox(height: 20.0)),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: AlignmentDirectional(-1.0, 1.0),
                                  child: FlutterFlowIconButton(
                                    borderWidth: 1.0,
                                    icon: Icon(
                                      Icons.arrow_left_rounded,
                                      color:
                                          FlutterFlowTheme.of(context).tertiary,
                                      size: 54.0,
                                    ),
                                    onPressed: () async {
                                      await _model.pageViewController
                                          ?.previousPage(
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.ease,
                                      );
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      8.0, 0.0, 8.0, 0.0),
                                  child: TextFormField(
                                    controller: _model.textController,
                                    focusNode: _model.textFieldFocusNode,
                                    autofocus: true,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      labelText:
                                          'Enter your caption here.......',
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
                                          color: Color(0xFF9BA5AD),
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      filled: true,
                                      fillColor: Colors.transparent,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          color: Color(0xFE14181B),
                                          letterSpacing: 0.0,
                                        ),
                                    maxLines: null,
                                    minLines: 4,
                                    maxLength: 150,
                                    validator: _model.textControllerValidator
                                        .asValidator(context),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10.0, 0.0, 10.0, 0.0),
                                  child: FlutterFlowDropDown<String>(
                                    controller:
                                        _model.dropDownValueController ??=
                                            FormFieldController<String>(
                                      _model.dropDownValue ??= '1 hour',
                                    ),
                                    options: ['1 hour', 'unlimited'],
                                    onChanged: (val) => setState(
                                        () => _model.dropDownValue = val),
                                    width: double.infinity,
                                    height: 50.0,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          color: Colors.white,
                                          letterSpacing: 0.0,
                                        ),
                                    hintText: 'visibility hours',
                                    icon: Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      color: Colors.white,
                                      size: 24.0,
                                    ),
                                    fillColor:
                                        FlutterFlowTheme.of(context).tertiary,
                                    elevation: 0.0,
                                    borderColor: Colors.transparent,
                                    borderWidth: 2.0,
                                    borderRadius: 8.0,
                                    margin: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 4.0, 16.0, 4.0),
                                    hidesUnderline: true,
                                    isOverButton: true,
                                    isSearchable: false,
                                    isMultiSelect: false,
                                  ),
                                ),
                                Container(
                                  constraints: BoxConstraints(
                                    maxWidth: 300.0,
                                  ),
                                  decoration: BoxDecoration(),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        15.0, 0.0, 15.0, 0.0),
                                    child: FFButtonWidget(
                                      onPressed: () async {
                                        if (_model.photoFile != null &&
                                            (_model.photoFile?.bytes
                                                    ?.isNotEmpty ??
                                                false)) {
                                          _model.photoUrl = await actions
                                              .customFileUploadAction(
                                            _model.photoFile!,
                                            currentUserUid,
                                            false,
                                          );

                                          await CheckInsRecord.collection
                                              .doc()
                                              .set(createCheckInsRecordData(
                                                time: getCurrentTimestamp,
                                                place: widget.placeToCheckInto
                                                    ?.reference,
                                                owner: currentUserReference,
                                                media: updateMediaPathStruct(
                                                  MediaPathStruct(
                                                    photoPath:
                                                        valueOrDefault<String>(
                                                      functions
                                                          .functionToConvertMediaUrlToPhotoPath(
                                                              _model.photoUrl!),
                                                      'https://i.ibb.co/gM8GFCN/user-avatar.png',
                                                    ),
                                                    isPhoto: true,
                                                  ),
                                                  clearUnsetFields: false,
                                                  create: true,
                                                ),
                                                caption:
                                                    _model.textController.text,
                                                nameOfOwner:
                                                    currentUserDisplayName,
                                                canExpire:
                                                    _model.dropDownValue ==
                                                        '1 hour',
                                                expirationDate: _model
                                                            .dropDownValue ==
                                                        '1 hour'
                                                    ? functions.addsHourToDate(
                                                        getCurrentTimestamp, 60)
                                                    : null,
                                                dateAdded: getCurrentTimestamp,
                                                hasExpired: false,
                                              ));
                                        } else {
                                          _model.videoUrl = await actions
                                              .customFileUploadAction(
                                            _model.videoFile!,
                                            currentUserUid,
                                            true,
                                          );

                                          await CheckInsRecord.collection
                                              .doc()
                                              .set(createCheckInsRecordData(
                                                time: getCurrentTimestamp,
                                                place: widget.placeToCheckInto
                                                    ?.reference,
                                                owner: currentUserReference,
                                                media: updateMediaPathStruct(
                                                  MediaPathStruct(
                                                    isPhoto: true,
                                                    videoPath: functions
                                                        .functionToConvertMediaUrlToVideoPath(
                                                            _model.videoUrl!),
                                                  ),
                                                  clearUnsetFields: false,
                                                  create: true,
                                                ),
                                                caption:
                                                    _model.textController.text,
                                                nameOfOwner:
                                                    currentUserDisplayName,
                                                hasExpired: false,
                                                expirationDate:
                                                    functions.addsHourToDate(
                                                        getCurrentTimestamp,
                                                        60),
                                                dateAdded: getCurrentTimestamp,
                                                canExpire:
                                                    _model.dropDownValue ==
                                                        '1 hour',
                                              ));
                                        }

                                        var placeUserCheckedIntoRecordReference =
                                            PlaceUserCheckedIntoRecord
                                                .createDoc(
                                                    currentUserReference!);
                                        await placeUserCheckedIntoRecordReference
                                            .set(
                                                createPlaceUserCheckedIntoRecordData(
                                          placeRef: widget
                                              .placeToCheckInto?.reference,
                                          noOfUnreadMessage: 0,
                                        ));
                                        _model.createdPlaceThatUserCheckedInDoc =
                                            PlaceUserCheckedIntoRecord
                                                .getDocumentFromData(
                                                    createPlaceUserCheckedIntoRecordData(
                                                      placeRef: widget
                                                          .placeToCheckInto
                                                          ?.reference,
                                                      noOfUnreadMessage: 0,
                                                    ),
                                                    placeUserCheckedIntoRecordReference);
                                        Navigator.pop(context);

                                        await widget.placeToCheckInto!.reference
                                            .update({
                                          ...mapToFirestore(
                                            {
                                              'noOfCheckings':
                                                  FieldValue.increment(1),
                                            },
                                          ),
                                        });
                                        if (_model.dropDownValue == '1 hour') {
                                          triggerPushNotification(
                                            notificationTitle:
                                                'checkin about to expire',
                                            notificationText:
                                                'your checkin at ${widget.placeToCheckInto?.name}is about to expire',
                                            scheduledTime:
                                                functions.addsHourToDate(
                                                    getCurrentTimestamp, 45),
                                            notificationSound: 'default',
                                            userRefs: [currentUserReference!],
                                            initialPageName: 'LoginPage',
                                            parameterData: {},
                                          );
                                        }
                                        await actions.printsInput(
                                          true,
                                        );

                                        context.pushNamed(
                                          'VenueSpecificPage',
                                          queryParameters: {
                                            'place': serializeParam(
                                              widget
                                                  .placeToCheckInto?.reference,
                                              ParamType.DocumentReference,
                                            ),
                                            'isNew': serializeParam(
                                              true,
                                              ParamType.bool,
                                            ),
                                          }.withoutNulls,
                                        );

                                        setState(() {});
                                      },
                                      text: 'Complete',
                                      options: FFButtonOptions(
                                        width: double.infinity,
                                        height: 40.0,
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            24.0, 0.0, 24.0, 0.0),
                                        iconPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 0.0, 0.0),
                                        color: FlutterFlowTheme.of(context)
                                            .tertiary,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              fontFamily: 'Readex Pro',
                                              color: Colors.white,
                                              letterSpacing: 0.0,
                                            ),
                                        elevation: 3.0,
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ].divide(SizedBox(height: 40.0)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ].divide(SizedBox(height: 15.0)),
            ),
          ),
        ),
      ],
    );
  }
}

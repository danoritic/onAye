import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/checkins_card/checkins_card_widget.dart';
import '/components/empty_list_component_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'venue_specific_page_model.dart';
export 'venue_specific_page_model.dart';

class VenueSpecificPageWidget extends StatefulWidget {
  const VenueSpecificPageWidget({
    super.key,
    required this.place,
    bool? isNew,
  }) : this.isNew = isNew ?? true;

  final DocumentReference? place;
  final bool isNew;

  @override
  State<VenueSpecificPageWidget> createState() =>
      _VenueSpecificPageWidgetState();
}

class _VenueSpecificPageWidgetState extends State<VenueSpecificPageWidget> {
  late VenueSpecificPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => VenueSpecificPageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.checkinDocLists = await queryCheckInsRecordOnce(
        queryBuilder: (checkInsRecord) => checkInsRecord
            .where(
              'place',
              isEqualTo: widget.place,
            )
            .where(
              'owner',
              isNotEqualTo: currentUserReference,
            ),
      );
      setState(() {
        _model.checkinDocs =
            _model.checkinDocLists!.toList().cast<CheckInsRecord>();
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
    return StreamBuilder<PlacesRecord>(
      stream: PlacesRecord.getDocument(widget.place!),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).primaryText,
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
        final venueSpecificPagePlacesRecord = snapshot.data!;
        return GestureDetector(
          onTap: () => _model.unfocusNode.canRequestFocus
              ? FocusScope.of(context).requestFocus(_model.unfocusNode)
              : FocusScope.of(context).unfocus(),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryText,
            body: SafeArea(
              top: true,
              child: Container(
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
                  padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 5.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 200.0,
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(0.0),
                              child: Image.network(
                                venueSpecificPagePlacesRecord.mainImage,
                                width: double.infinity,
                                height: 200.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(-1.0, 1.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10.0, 0.0, 0.0, 10.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Color(0x56FFFFFF),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(4.0),
                                        child: Text(
                                          venueSpecificPagePlacesRecord.name,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Readex Pro',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .alternate,
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                      ),
                                    ),
                                    RatingBarIndicator(
                                      itemBuilder: (context, index) => Icon(
                                        Icons.star_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .tertiary,
                                      ),
                                      direction: Axis.horizontal,
                                      rating: venueSpecificPagePlacesRecord
                                          .rating
                                          .toDouble(),
                                      unratedColor:
                                          FlutterFlowTheme.of(context).accent3,
                                      itemCount: 5,
                                      itemSize: 20.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            FlutterFlowIconButton(
                              borderColor: Color(0x004B39EF),
                              borderRadius: 2.0,
                              borderWidth: 1.0,
                              buttonSize: 40.0,
                              fillColor: Color(0x004B39EF),
                              icon: Icon(
                                Icons.arrow_back_ios_new,
                                color: FlutterFlowTheme.of(context).tertiary,
                                size: 24.0,
                              ),
                              onPressed: () async {
                                context.safePop();
                              },
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'Description: ${venueSpecificPagePlacesRecord.description}',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Readex Pro',
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              fontSize: 16.0,
                              letterSpacing: 0.0,
                            ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Recent check ins',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      fontSize: 20.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              FFButtonWidget(
                                onPressed: () async {
                                  context.pushNamed(
                                    'ListOfAllCheckIns',
                                    queryParameters: {
                                      'place': serializeParam(
                                        _model.placeDocument,
                                        ParamType.Document,
                                      ),
                                    }.withoutNulls,
                                    extra: <String, dynamic>{
                                      'place': _model.placeDocument,
                                    },
                                  );
                                },
                                text: 'See All',
                                icon: Icon(
                                  Icons.arrow_right_alt,
                                  size: 15.0,
                                ),
                                options: FFButtonOptions(
                                  height: 40.0,
                                  padding: EdgeInsets.all(0.0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color: Color(0x00EE8B60),
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color: Colors.white,
                                        letterSpacing: 0.0,
                                      ),
                                  elevation: 0.0,
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(0.0),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 318.0,
                            decoration: BoxDecoration(),
                            child: Builder(
                              builder: (context) {
                                final checkins = _model.checkinDocs.toList();
                                if (checkins.isEmpty) {
                                  return EmptyListComponentWidget(
                                    message: 'No Checkins Yet',
                                  );
                                }
                                return ListView.separated(
                                  padding: EdgeInsets.zero,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: checkins.length,
                                  separatorBuilder: (_, __) =>
                                      SizedBox(width: 10.0),
                                  itemBuilder: (context, checkinsIndex) {
                                    final checkinsItem =
                                        checkins[checkinsIndex];
                                    return CheckinsCardWidget(
                                      key: Key(
                                          'Keyaa1_${checkinsIndex}_of_${checkins.length}'),
                                      checkInDocument: checkinsItem,
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            15.0, 0.0, 15.0, 0.0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            _model.placeDocument =
                                await PlacesRecord.getDocumentOnce(
                                    widget.place!);

                            context.pushNamed(
                              'publicChatPage',
                              queryParameters: {
                                'place': serializeParam(
                                  venueSpecificPagePlacesRecord,
                                  ParamType.Document,
                                ),
                              }.withoutNulls,
                              extra: <String, dynamic>{
                                'place': venueSpecificPagePlacesRecord,
                              },
                            );

                            setState(() {});
                          },
                          text: widget.isNew
                              ? 'Join the conversation'
                              : 'Enter group chat',
                          options: FFButtonOptions(
                            width: double.infinity,
                            height: 40.0,
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
                    ].divide(SizedBox(height: 10.0)),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

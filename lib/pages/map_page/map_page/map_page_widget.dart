import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/components/edit_profile_component/edit_profile_component_widget.dart';
import '/components/top_place_checked_in_component/top_place_checked_in_component_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'map_page_model.dart';
export 'map_page_model.dart';

class MapPageWidget extends StatefulWidget {
  const MapPageWidget({super.key});

  @override
  State<MapPageWidget> createState() => _MapPageWidgetState();
}

class _MapPageWidgetState extends State<MapPageWidget> {
  late MapPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  LatLng? currentUserLocationValue;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MapPageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      currentUserLocationValue =
          await getCurrentUserLocation(defaultLocation: LatLng(0.0, 0.0));
      setState(() {
        _model.centeredLocation = currentUserLocationValue;
      });
      await Future.delayed(const Duration(milliseconds: 2000));
      if (valueOrDefault(currentUserDocument?.noOfLoginTimes, 0) == 0) {
        await currentUserReference!.update({
          ...mapToFirestore(
            {
              'noOfLoginTimes': FieldValue.increment(1),
            },
          ),
        });
        var confirmDialogResponse = await showDialog<bool>(
              context: context,
              builder: (alertDialogContext) {
                return AlertDialog(
                  content: Text('please upload your profile picture'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(alertDialogContext, false),
                      child: Text('Later'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(alertDialogContext, true),
                      child: Text('Sure'),
                    ),
                  ],
                );
              },
            ) ??
            false;
        if (confirmDialogResponse) {
          await showModalBottomSheet(
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            enableDrag: false,
            context: context,
            builder: (context) {
              return GestureDetector(
                onTap: () => _model.unfocusNode.canRequestFocus
                    ? FocusScope.of(context).requestFocus(_model.unfocusNode)
                    : FocusScope.of(context).unfocus(),
                child: Padding(
                  padding: MediaQuery.viewInsetsOf(context),
                  child: EditProfileComponentWidget(
                    userRef: currentUserReference!,
                  ),
                ),
              );
            },
          ).then((value) => safeSetState(() {}));
        }
      }

      await currentUserReference!.update({
        ...mapToFirestore(
          {
            'noOfLoginTimes': FieldValue.increment(1),
          },
        ),
      });
      await actions.printsInputy(
        currentUserDisplayName,
      );
      _model.allCheckins = await queryCheckInsRecordOnce();
      await actions.actiontodeletealreadystaleCheckins(
        getCurrentTimestamp,
        _model.allCheckins?.toList(),
      );
      _model.apiResult8kp = await GetCredCall.call();
      if ((_model.apiResult8kp?.succeeded ?? true)) {
        await actions.printsInputy(
          (_model.apiResult8kp?.jsonBody ?? '').toString(),
        );
      } else {
        await actions.printsInputy(
          (_model.apiResult8kp?.jsonBody ?? '').toString(),
        );
      }

      await actions.printsInputy(
        'fvhdfhvsfgdfjhsdfjsfhsdjhfvhvhbbbcbckjdcjdscsdbcscbhbhvbhsdhcjkcdschjvsdcgscvcgghcvhgsdvcdjhdbjhcbjscbdsjhbcjhsbdchcdscsccscshbdjcsdjcjchbcjhbdcbjbdsbcccbhjbscsdcbhcbdxhbcdcsc',
      );
    });

    getCurrentUserLocation(defaultLocation: LatLng(0.0, 0.0), cached: true)
        .then((loc) => setState(() => currentUserLocationValue = loc));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    if (currentUserLocationValue == null) {
      return Container(
        color: FlutterFlowTheme.of(context).primaryBackground,
        child: Center(
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

    return StreamBuilder<List<PlacesRecord>>(
      stream: queryPlacesRecord(
        queryBuilder: (placesRecord) =>
            placesRecord.orderBy('number_of_checkings', descending: true),
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
        List<PlacesRecord> mapPagePlacesRecordList = snapshot.data!;
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
              title: Text(
                'Map',
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
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 50.0),
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            child: custom_widgets.CustomMap(
                              width: double.infinity,
                              height: double.infinity,
                              isMobile: true,
                              updaterParameter: FFAppState().mapCurrentCoord,
                              markersList: mapPagePlacesRecordList,
                              userLocation: currentUserLocationValue,
                              markerClickedCallback: () async {},
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(0.0, 1.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Align(
                                alignment: AlignmentDirectional(0.0, 1.0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10.0, 0.0, 0.0, 60.0),
                                  child: Builder(
                                    builder: (context) {
                                      final places =
                                          mapPagePlacesRecordList.toList();
                                      return Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: List.generate(places.length,
                                            (placesIndex) {
                                          final placesItem =
                                              places[placesIndex];
                                          return TopPlaceCheckedInComponentWidget(
                                            key: Key(
                                                'Keyvsw_${placesIndex}_of_${places.length}'),
                                            place: placesItem,
                                          );
                                        }).divide(SizedBox(width: 10.0)),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(0.0, -1.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 10.0, 0.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    FFButtonWidget(
                                      onPressed: () async {
                                        setState(() {
                                          FFAppState().nearPlaceLIstVisible =
                                              !FFAppState()
                                                  .nearPlaceLIstVisible;
                                        });
                                      },
                                      text: 'Nearest Location',
                                      options: FFButtonOptions(
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
                                    FFButtonWidget(
                                      onPressed: () async {
                                        currentUserLocationValue =
                                            await getCurrentUserLocation(
                                                defaultLocation:
                                                    LatLng(0.0, 0.0));
                                        setState(() {
                                          FFAppState().mapCurrentCoord =
                                              currentUserLocationValue;
                                        });
                                      },
                                      text: 'Veiw My Location',
                                      options: FFButtonOptions(
                                        height: 40.0,
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            24.0, 0.0, 24.0, 0.0),
                                        iconPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 0.0, 0.0),
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
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
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (FFAppState().nearPlaceLIstVisible)
                          Align(
                            alignment: AlignmentDirectional(-1.0, -1.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  10.0, 55.0, 0.0, 0.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Container(
                                  width: 300.0,
                                  constraints: BoxConstraints(
                                    minHeight: 200.0,
                                    maxHeight:
                                        MediaQuery.sizeOf(context).height * 0.5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(0x3AFFFFFF),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Align(
                                    alignment: AlignmentDirectional(-1.0, -1.0),
                                    child: Builder(
                                      builder: (context) {
                                        final nearPlace =
                                            mapPagePlacesRecordList.toList();
                                        return ListView.separated(
                                          padding: EdgeInsets.zero,
                                          scrollDirection: Axis.vertical,
                                          itemCount: nearPlace.length,
                                          separatorBuilder: (_, __) =>
                                              SizedBox(height: 10.0),
                                          itemBuilder:
                                              (context, nearPlaceIndex) {
                                            final nearPlaceItem =
                                                nearPlace[nearPlaceIndex];
                                            return TopPlaceCheckedInComponentWidget(
                                              key: Key(
                                                  'Keycqs_${nearPlaceIndex}_of_${nearPlace.length}'),
                                              place: nearPlaceItem,
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
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

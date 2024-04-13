import '/backend/backend.dart';
import '/components/maps_popup_component/maps_popup_component_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'positioned_indicator_detail_component_model.dart';
export 'positioned_indicator_detail_component_model.dart';

class PositionedIndicatorDetailComponentWidget extends StatefulWidget {
  const PositionedIndicatorDetailComponentWidget({
    super.key,
    required this.place,
  });

  final PlacesRecord? place;

  @override
  State<PositionedIndicatorDetailComponentWidget> createState() =>
      _PositionedIndicatorDetailComponentWidgetState();
}

class _PositionedIndicatorDetailComponentWidgetState
    extends State<PositionedIndicatorDetailComponentWidget> {
  late PositionedIndicatorDetailComponentModel _model;

  LatLng? currentUserLocationValue;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model =
        createModel(context, () => PositionedIndicatorDetailComponentModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180.0,
      height: 136.0,
      decoration: BoxDecoration(
        color: Color(0xFFF6E8E2),
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
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    widget.place!.thumbnailImage,
                    width: 60.0,
                    height: 60.0,
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      valueOrDefault<String>(
                        widget.place?.name,
                        'null',
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Readex Pro',
                            color: Color(0xFF070809),
                            fontSize: 14.0,
                            letterSpacing: 0.0,
                          ),
                    ),
                    RatingBarIndicator(
                      itemBuilder: (context, index) => Icon(
                        Icons.star_rounded,
                        color: FlutterFlowTheme.of(context).tertiary,
                      ),
                      direction: Axis.horizontal,
                      rating: 3.0,
                      unratedColor: FlutterFlowTheme.of(context).accent3,
                      itemCount: 5,
                      itemSize: 10.0,
                    ),
                    Text(
                      valueOrDefault<String>(
                        widget.place?.bussinessType,
                        'null',
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Readex Pro',
                            color: Color(0xFF070809),
                            fontSize: 10.0,
                            letterSpacing: 0.0,
                          ),
                    ),
                  ],
                ),
              ].divide(SizedBox(width: 10.0)),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FFButtonWidget(
                  onPressed: () async {
                    if (functions.nearLocationChecker(
                        10.0, currentUserLocationValue, widget.place!.coord!)) {
                      await showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: Color(0x3A000000),
                        useSafeArea: true,
                        context: context,
                        builder: (context) {
                          return Padding(
                            padding: MediaQuery.viewInsetsOf(context),
                            child: MapsPopupComponentWidget(
                              placeToCheckInto: widget.place!,
                            ),
                          );
                        },
                      ).then((value) => safeSetState(() {}));
                    } else {
                      await showDialog(
                        context: context,
                        builder: (alertDialogContext) {
                          return AlertDialog(
                            content: Text(
                                'sorry you are too far to check into this place.'),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(alertDialogContext),
                                child: Text('Ok'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  text: 'Check in',
                  options: FFButtonOptions(
                    height: 30.0,
                    padding:
                        EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: FlutterFlowTheme.of(context).tertiary,
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}

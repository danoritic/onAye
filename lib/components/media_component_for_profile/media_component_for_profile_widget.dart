import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_video_player.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'media_component_for_profile_model.dart';
export 'media_component_for_profile_model.dart';

class MediaComponentForProfileWidget extends StatefulWidget {
  const MediaComponentForProfileWidget({
    super.key,
    required this.media,
    required this.place,
  });

  final MediaPathStruct? media;
  final PlacesRecord? place;

  @override
  State<MediaComponentForProfileWidget> createState() =>
      _MediaComponentForProfileWidgetState();
}

class _MediaComponentForProfileWidgetState
    extends State<MediaComponentForProfileWidget> {
  late MediaComponentForProfileModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MediaComponentForProfileModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.8,
        height: MediaQuery.sizeOf(context).height * 0.8,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).primaryText,
        ),
        child: Stack(
          alignment: AlignmentDirectional(0.0, 0.0),
          children: [
            Builder(
              builder: (context) {
                if (widget.media?.isPhoto ?? false) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      widget.media!.photoPath,
                      width: 300.0,
                      height: 200.0,
                      fit: BoxFit.fill,
                    ),
                  );
                } else {
                  return FlutterFlowVideoPlayer(
                    path: widget.media!.videoPath,
                    videoType: VideoType.network,
                    aspectRatio: 0.98,
                    autoPlay: false,
                    looping: true,
                    showControls: false,
                    allowFullScreen: true,
                    allowPlaybackSpeedMenu: false,
                  );
                }
              },
            ),
            Align(
              alignment: AlignmentDirectional(0.0, 1.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 10.0),
                    child: FlutterFlowIconButton(
                      borderColor: FlutterFlowTheme.of(context).tertiary,
                      borderRadius: 20.0,
                      borderWidth: 1.0,
                      buttonSize: 40.0,
                      fillColor: FlutterFlowTheme.of(context).tertiary,
                      icon: Icon(
                        Icons.delete_outline,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 24.0,
                      ),
                      onPressed: () {
                        print('IconButton pressed ...');
                      },
                    ),
                  ),
                  RichText(
                    textScaler: MediaQuery.of(context).textScaler,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '@ ',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Readex Pro',
                                    color: FlutterFlowTheme.of(context).primary,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        TextSpan(
                          text: valueOrDefault<String>(
                            widget.place?.name,
                            'null',
                          ),
                          style: TextStyle(
                            color: FlutterFlowTheme.of(context).tertiary,
                          ),
                        )
                      ],
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Readex Pro',
                            letterSpacing: 0.0,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

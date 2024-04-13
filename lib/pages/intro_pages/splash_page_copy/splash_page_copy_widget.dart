import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_video_player.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'splash_page_copy_model.dart';
export 'splash_page_copy_model.dart';

class SplashPageCopyWidget extends StatefulWidget {
  const SplashPageCopyWidget({super.key});

  @override
  State<SplashPageCopyWidget> createState() => _SplashPageCopyWidgetState();
}

class _SplashPageCopyWidgetState extends State<SplashPageCopyWidget> {
  late SplashPageCopyModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SplashPageCopyModel());
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
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                FlutterFlowTheme.of(context).tertiary,
                FlutterFlowTheme.of(context).primary
              ],
              stops: [0.4, 1.0],
              begin: AlignmentDirectional(0.87, -1.0),
              end: AlignmentDirectional(-0.87, 1.0),
            ),
          ),
          child: Align(
            alignment: AlignmentDirectional(0.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 12.0, 0.0),
                      child: Icon(
                        Icons.flourescent_rounded,
                        color: FlutterFlowTheme.of(context).info,
                        size: 44.0,
                      ),
                    ),
                    Text(
                      'OnLife',
                      style: FlutterFlowTheme.of(context).displaySmall.override(
                            fontFamily: 'Outfit',
                            color: FlutterFlowTheme.of(context).info,
                            letterSpacing: 0.0,
                          ),
                    ),
                  ],
                ),
                FlutterFlowVideoPlayer(
                  path:
                      'https://assets.mixkit.co/videos/preview/mixkit-forest-stream-in-the-sunlight-529-large.mp4',
                  videoType: VideoType.network,
                  autoPlay: false,
                  looping: true,
                  showControls: true,
                  allowFullScreen: true,
                  allowPlaybackSpeedMenu: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

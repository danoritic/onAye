import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_video_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'media_component_model.dart';
export 'media_component_model.dart';

class MediaComponentWidget extends StatefulWidget {
  const MediaComponentWidget({
    super.key,
    required this.media,
  });

  final MediaPathStruct? media;

  @override
  State<MediaComponentWidget> createState() => _MediaComponentWidgetState();
}

class _MediaComponentWidgetState extends State<MediaComponentWidget> {
  late MediaComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MediaComponentModel());
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
          color: FlutterFlowTheme.of(context).secondaryBackground,
        ),
        child: Builder(
          builder: (context) {
            if (widget.media?.isPhoto ?? false) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  widget.media!.photoPath,
                  width: 300.0,
                  height: 200.0,
                  fit: BoxFit.cover,
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
      ),
    );
  }
}

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'empty_list_component_model.dart';
export 'empty_list_component_model.dart';

class EmptyListComponentWidget extends StatefulWidget {
  const EmptyListComponentWidget({
    super.key,
    String? message,
  }) : this.message = message ?? 'EmptyList';

  final String message;

  @override
  State<EmptyListComponentWidget> createState() =>
      _EmptyListComponentWidgetState();
}

class _EmptyListComponentWidgetState extends State<EmptyListComponentWidget> {
  late EmptyListComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EmptyListComponentModel());
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
        width: MediaQuery.sizeOf(context).width * 0.6,
        child: Stack(
          alignment: AlignmentDirectional(0.0, 0.0),
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Icon(
                    Icons.list_rounded,
                    color: FlutterFlowTheme.of(context).secondaryText,
                    size: 100.0,
                  ),
                ),
                Text(
                  widget.message,
                  style: FlutterFlowTheme.of(context).titleSmall.override(
                        fontFamily: 'Readex Pro',
                        letterSpacing: 0.0,
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

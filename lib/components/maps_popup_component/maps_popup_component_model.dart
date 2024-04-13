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
import 'maps_popup_component_widget.dart' show MapsPopupComponentWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MapsPopupComponentModel
    extends FlutterFlowModel<MapsPopupComponentWidget> {
  ///  Local state fields for this component.

  int? shownIndex = 0;

  MediaPathStruct? selectedMedia;
  void updateSelectedMediaStruct(Function(MediaPathStruct) updateFn) =>
      updateFn(selectedMedia ??= MediaPathStruct());

  bool uploadedMediaType = false;

  bool hasCompleted = false;

  FFUploadedFile? uploadedMediaFile;

  ///  State fields for stateful widgets in this component.

  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  // Stores action output result for [Custom Action - customSingleFilePicker] action in Button widget.
  FFUploadedFile? photoFile;
  // Stores action output result for [Custom Action - actionToFilterMedia] action in Button widget.
  bool? isFitForUploa;
  // Stores action output result for [Custom Action - customSingleFilePicker] action in Button widget.
  FFUploadedFile? videoFile;
  // Stores action output result for [Custom Action - actionToFilterMedia] action in Button widget.
  bool? isVideoSizeCorrect;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // Stores action output result for [Custom Action - customFileUploadAction] action in Button widget.
  String? photoUrl;
  // Stores action output result for [Custom Action - customFileUploadAction] action in Button widget.
  String? videoUrl;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  PlaceUserCheckedIntoRecord? createdPlaceThatUserCheckedInDoc;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}

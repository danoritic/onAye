import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/checkins_card_for_see_all_page/checkins_card_for_see_all_page_widget.dart';
import '/components/empty_list_component_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'list_of_all_check_ins_model.dart';
export 'list_of_all_check_ins_model.dart';

class ListOfAllCheckInsWidget extends StatefulWidget {
  const ListOfAllCheckInsWidget({
    super.key,
    required this.place,
  });

  final PlacesRecord? place;

  @override
  State<ListOfAllCheckInsWidget> createState() =>
      _ListOfAllCheckInsWidgetState();
}

class _ListOfAllCheckInsWidgetState extends State<ListOfAllCheckInsWidget> {
  late ListOfAllCheckInsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ListOfAllCheckInsModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.checkinDocLists = await queryCheckInsRecordOnce(
        queryBuilder: (checkInsRecord) => checkInsRecord
            .where(
              'place',
              isEqualTo: widget.place?.reference,
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

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
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
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.white,
              size: 30.0,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
          actions: [],
          centerTitle: true,
          elevation: 2.0,
        ),
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
              padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22.0),
                      border: Border.all(
                        color: Color(0xFFF3C5B2),
                        width: 1.0,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                8.0, 0.0, 8.0, 0.0),
                            child: TextFormField(
                              controller: _model.textController,
                              focusNode: _model.textFieldFocusNode,
                              autofocus: true,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Label here...',
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
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).primary,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                errorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).error,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedErrorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).error,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    color:
                                        FlutterFlowTheme.of(context).tertiary,
                                    letterSpacing: 0.0,
                                  ),
                              minLines: null,
                              validator: _model.textControllerValidator
                                  .asValidator(context),
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(1.0, 0.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 10.0, 0.0),
                            child: FlutterFlowIconButton(
                              borderColor: Color(0x00FFFFFF),
                              borderRadius: 20.0,
                              borderWidth: 1.0,
                              buttonSize: 40.0,
                              icon: Icon(
                                Icons.search_outlined,
                                color: FlutterFlowTheme.of(context).tertiary,
                                size: 25.0,
                              ),
                              onPressed: () {
                                print('IconButton pressed ...');
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: MediaQuery.sizeOf(context).height * 0.6,
                      decoration: BoxDecoration(),
                      child: StreamBuilder<List<CheckInsRecord>>(
                        stream: queryCheckInsRecord(
                          queryBuilder: (checkInsRecord) => checkInsRecord
                              .where(
                                'place',
                                isEqualTo: widget.place?.reference,
                              )
                              .where(
                                'owner',
                                isNotEqualTo: currentUserReference,
                              ),
                        ),
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
                          List<CheckInsRecord> listViewCheckInsRecordList =
                              snapshot.data!;
                          if (listViewCheckInsRecordList.isEmpty) {
                            return EmptyListComponentWidget(
                              message: 'No checkins yet',
                            );
                          }
                          return ListView.builder(
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.vertical,
                            itemCount: listViewCheckInsRecordList.length,
                            itemBuilder: (context, listViewIndex) {
                              final listViewCheckInsRecord =
                                  listViewCheckInsRecordList[listViewIndex];
                              return CheckinsCardForSeeAllPageWidget(
                                key: Key(
                                    'Keyac0_${listViewIndex}_of_${listViewCheckInsRecordList.length}'),
                                checkInDocument: listViewCheckInsRecord,
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ].addToStart(SizedBox(height: 20.0)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

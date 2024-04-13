// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:flutter/gestures.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:onlife/components/maps_popup_component/maps_popup_component_widget.dart';
import 'package:onlife/flutter_flow/flutter_flow_widgets.dart';

// import 'package:google_maps/google_maps.dart';

// Set your widget name, define your parameter, and then add the
// boilerplate code using the green button on the right!

// import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
// df

import 'dart:math';
import 'package:flutter/services.dart';
import 'package:mapbox_gl_flutterflow/mapbox_gl_flutterflow.dart'
    as mapbox; // Use 'mapbox' as a prefix
import 'package:http/http.dart' as http;

class CustomMap extends StatefulWidget {
  CustomMap(
      {Key? key,
      this.width,
      this.height,
      required this.isMobile,
      required this.markerClickedCallback,
      this.updaterParameter,
      this.userLocation,
      this.markersList})
      : super(key: key);

  final double? width;
  final double? height;
  final bool isMobile;
  final List<PlacesRecord>? markersList;
  final List<LatLonObjectStruct>? markers = [];
  final Future<dynamic> Function() markerClickedCallback;
  final LatLonObjectStruct origin = LatLonObjectStruct();
  final LatLng? updaterParameter;
  final LatLng? userLocation;

  @override
  _CustomMapState createState() => _CustomMapState();
}

// FFButtonWidget(
//   onPressed: () async {},
//   text: 'Nearest Location',
//   options: FFButtonOptions(
//     height: 40,
//     padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
//     iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
//     color: FlutterFlowTheme.of(context).tertiary,
//     textStyle: FlutterFlowTheme.of(context).titleSmall.override(
//           fontFamily: 'Readex Pro',
//           color: Colors.white,
//         ),
//     elevation: 3,
//     borderSide: BorderSide(
//       color: Colors.transparent,
//       width: 1,
//     ),
//     borderRadius: BorderRadius.circular(18),
//   ),
// )

class LatLonObjectStruct {
  double lat = 0;
  double lon = 0;
}

class _CustomMapState extends State<CustomMap> {
  PlacesRecord? indicatorDisplayedPlace;

  mapbox.MapboxMapController? mapController;

  _onMapCreated(mapbox.MapboxMapController controller) {
    mapController = controller;
    for (PlacesRecord? i in widget.markersList ?? []) {
      // posibility of giving wrong location ***********************
      mapController?.addCircle(mapbox.CircleOptions(
          circleColor: "#EE8B60",
          geometry: mapbox.LatLng(
              i?.coord?.latitude ?? 0, i?.coord?.longitude ?? 0)));
    }
  }

  _onStyleLoadedCallback() {
    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //   content: Text("Style loaded: ${mapbox.MapboxStyles.LIGHT}"),
    //   backgroundColor: Theme.of(context).primaryColor,
    //   duration: Duration(seconds: ),
    // ));
    _updateMarkers();
    // addImageFromAsset("basic-marker", "assets/images/basic-marker.png");
    addImageFromUrl();
    debugPrint("style load cb");
  }

  Future<void> addImageFromAsset(String name, String assetName) async {
    final bytes = await rootBundle.load(assetName);
    final Uint8List list = bytes.buffer.asUint8List();
    return mapController!.addImage(name, list);
  }

  Future<void> addImageFromUrl() async {
    var response =
        await http.get(Uri.parse("https://i.ibb.co/gM8GFCN/user-avatar.png"));
    await mapController?.addImage("testImage", response.bodyBytes);
//  Image.network('').image.
  }

  void _addMarker(double lat, double lng) {
    // mapController?.addCircle(mapbox.CircleOptions())
    mapController?.addSymbol(
      mapbox.SymbolOptions(
        geometry: mapbox.LatLng(lat, lng), // Replace with your coordinates
        iconImage: "testImage", // Replace with your marker icon
        iconSize: .06,
      ),
    );
    // mapController.cl
  }

  void _onMarkerClickedCallback() {
    debugPrint("marker click");
    widget.markerClickedCallback();
  }

  @override
  void didUpdateWidget(covariant CustomMap oldWidget) {
    super.didUpdateWidget(oldWidget);
    debugPrint("didupdate");
    if (oldWidget.markers != widget.markers) {
      _updateMarkers();
      debugPrint("_update triggered");
    }
  }

  Future<void> _updateMarkers() async {
    // Clear existing markers
    debugPrint("_update called");
    await mapController?.clearSymbols();

    // Add new markers'

    _addMarker(widget.userLocation?.latitude ?? 0,
        widget.userLocation?.longitude ?? 0);
    if (widget.markers != null) {
      for (var marker in widget.markers!) {
        _addMarker(marker.lat, marker.lon);
      }
    }
  }

// "mapbox://styles/buyblvdryan/clrff17o6004701re2j5thsbf"
  @override
  Widget build(BuildContext context) {
    mapController?.animateCamera(mapbox.CameraUpdate.newLatLng(
      mapbox.LatLng(
        FFAppState().mapCurrentCoord!.latitude,
        FFAppState().mapCurrentCoord!.longitude,
      ),
    ));
    for (PlacesRecord? i in widget.markersList ?? []) {
      // posibility of giving wrong location ***********************
      mapController?.addCircle(mapbox.CircleOptions(
          circleColor: FlutterFlowTheme.of(context).tertiary.toHexStringRGB(),
          geometry: mapbox.LatLng(
              i?.coord?.latitude ?? 0, i?.coord?.longitude ?? 0)));
    }
    // mapbox.CameraPosition(
    //             target: mapbox.LatLng(
    //               FFAppState().mapCurrentCoord!.latitude,
    //               FFAppState().mapCurrentCoord!.longitude,
    //             ));
    List<double> position = [0, 0];
    return new Scaffold(
        body: Stack(
      children: [
        mapbox.MapboxMap(
            onMapClick: (point, coordinates) {
              for (PlacesRecord? i in widget.markersList ?? []) {
                if ((coordinates.latitude == i?.coord!.latitude) &&
                    (coordinates.latitude == i?.coord!.longitude)) {
                  position[0] = point.x;
                  position[1] = point.y;
                  indicatorDisplayedPlace = i;
                  print(position);
                  print(indicatorDisplayedPlace);
                } else {
                  indicatorDisplayedPlace = null;
                }
              }
            },
            styleString: mapbox.MapboxStyles.MAPBOX_STREETS,
            accessToken:
                "pk.eyJ1Ijoib25saWZlIiwiYSI6ImNsdHQ2ejJzZjB5NDUyb29hejI5bnJreGEifQ.d0Xhj3uTFZTZx8kZBJxeQg",
            // "pk.eyJ1Ijoib25saWZlIiwiYSI6ImNsdHExMjNzdTAxNjUya29ieDVyYjM1NW8ifQ.m5_wT6w-bNPgRJZ2vpi8vA",
            // "pk.eyJ1Ijoic2NvdGhpcyIsImEiOiJjaWp1Y2ltYmUwMDBicmJrdDQ4ZDBkaGN4In0.sbihZCZJ56-fsFNKHXF8YQ",
            onMapCreated: _onMapCreated,
            initialCameraPosition: mapbox.CameraPosition(
                target: mapbox.LatLng(
                  FFAppState().mapCurrentCoord!.latitude,
                  FFAppState().mapCurrentCoord!.longitude,
                ),
                zoom: 11),
            myLocationEnabled: true,
            compassEnabled: false,
            onStyleLoadedCallback: _onStyleLoadedCallback,
            onAttributionClick: _onMarkerClickedCallback),
        ((indicatorDisplayedPlace != null)
            ? Positioned(
                bottom: position.last,
                left: position.first,
                child: Container(
                  width: 180,
                  height: 136,
                  decoration: BoxDecoration(
                    color: Color(0xFFF6E8E2),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4,
                        color: Color(0x33000000),
                        offset: Offset(0, 2),
                      )
                    ],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                indicatorDisplayedPlace!.thumbnailImage,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  valueOrDefault<String>(
                                    indicatorDisplayedPlace?.name,
                                    'null',
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color: Color(0xFF070809),
                                        fontSize: 14,
                                      ),
                                ),
                                RatingBarIndicator(
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star_rounded,
                                    color:
                                        FlutterFlowTheme.of(context).tertiary,
                                  ),
                                  direction: Axis.horizontal,
                                  rating: 3,
                                  unratedColor:
                                      FlutterFlowTheme.of(context).accent3,
                                  itemCount: 5,
                                  itemSize: 10,
                                ),
                                Text(
                                  valueOrDefault<String>(
                                    indicatorDisplayedPlace!.bussinessType,
                                    'null',
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color: Color(0xFF070809),
                                        fontSize: 10,
                                      ),
                                ),
                              ],
                            ),
                          ].divide(SizedBox(width: 10)),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            FFButtonWidget(
                              onPressed: () async {
                                await showModalBottomSheet(
                                  isScrollControlled: true,
                                  backgroundColor: Color(0x3A000000),
                                  useSafeArea: true,
                                  context: context,
                                  builder: (context) {
                                    return Padding(
                                      padding: MediaQuery.viewInsetsOf(context),
                                      child: MapsPopupComponentWidget(
                                        placeToCheckInto:
                                            indicatorDisplayedPlace,
                                      ),
                                    );
                                  },
                                ).then((value) => safeSetState(() {}));
                              },
                              text: 'Check in',
                              options: FFButtonOptions(
                                height: 30,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    24, 0, 24, 0),
                                iconPadding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                color: FlutterFlowTheme.of(context).tertiary,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                elevation: 3,
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ))
            : Container())
      ],
    ));
  }
}

// Set your widget name, define your parameter, and then ad2d the
// boilerplate code using the green button on the right!

// // import 'package:mapbox_maps_example/animated_route.dart';
// // import 'package:mapbox_maps_example/animation.dart';
// // import 'package:mapbox_maps_example/camera.dart';
// // import 'package:mapbox_maps_example/circle_annotations.dart';
// // import 'package:mapbox_maps_example/cluster.dart';
// // import 'package:mapbox_maps_example/ornaments.dart';
// // import 'package:mapbox_maps_example/geojson_line.dart';
// // import 'package:mapbox_maps_example/image_source.dart';
// // import 'package:mapbox_maps_example/map_interface.dart';
// // import 'package:mapbox_maps_example/polygon_annotations.dart';
// // import 'package:mapbox_maps_example/polyline_annotations.dart';
// // import 'package:mapbox_maps_example/tile_json.dart';
// // import 'package:mapbox_maps_example/vector_tile_source.dart';

// // import 'full_map.dart';
// // import 'location.dart';
// // import 'page.dart';
// // import 'point_annotations.dart';
// // import 'projection.dart';
// // import 'style.dart';
// // import 'gestures.dart';

// // final List<ExamplePage> _allPages = <ExamplePage>[
// //   CustomMapPage(),
// //   StylePage(),
// //   CameraPage(),
// //   ProjectionPage(),
// //   MapInterfacePage(),
// //   StyleClustersPage(),
// //   AnimationPage(),
// //   PointAnnotationPage(),
// //   CircleAnnotationPage(),
// //   PolylineAnnotationPage(),
// //   PolygonAnnotationPage(),
// //   VectorTileSourcePage(),
// //   DrawGeoJsonLinePage(),
// //   ImageSourcePage(),
// //   TileJsonPage(),
// //   LocationPage(),
// //   GesturesPage(),
// //   OrnamentsPage(),
// //   AnimatedRoutePage(),
// // ];

// class CustomMap extends StatefulWidget {
//   final double? height;

//   final double? width;

//   CustomMap({super.key, this.height, this.width});
//   // FIXME: You need to pass in your access token via the command line argument
//   // --dart-define=ACCESS_TOKEN=ADD_YOUR_TOKEN_HERE
//   // It is also possible to pass it in while running the app via an IDE by
//   // passing the same args there.
//   //
//   // Alternatively you can replace `String.fromEnvironment("ACCESS_TOKEN")`
//   // in the following line with your access token directly.
//   static const String ACCESS_TOKEN =
//       'pk.eyJ1Ijoib25saWZlIiwiYSI6ImNsdHExMjNzdTAxNjUya29ieDVyYjM1NW8ifQ.m5_wT6w-bNPgRJZ2vpi8vA';

//   @override
//   State<CustomMap> createState() => _CustomMapState();
// }

// class _CustomMapState extends State<CustomMap> {
//   // void _pushPage(BuildContext context, ExamplePage page) async {
//   //   Navigator.of(context).push(MaterialPageRoute<void>(
//   //       builder: (_) => Scaffold(
//   //             appBar: AppBar(title: Text(page.title)),
//   //             body: page,
//   //           )));
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(title: const Text('MapboxMaps examples')),
//         body: CustomMap.ACCESS_TOKEN.isEmpty ||
//                 CustomMap.ACCESS_TOKEN.contains("YOUR_TOKEN")
//             ? buildAccessTokenWarning()
//             : MapWidget()
//         // ListView.separated(
//         //     itemCount: _allPages.length,
//         //     separatorBuilder: (BuildContext context, int index) =>
//         //         const Divider(height: 1),
//         //     itemBuilder: (_, int index) => ListTile(
//         //       leading: _allPages[index].leading,
//         //       title: Text(_allPages[index].title),
//         //       onTap: () => _pushPage(context, _allPages[index]),
//         //     ),
//         //   ),
//         );
//   }

//   Widget buildAccessTokenWarning() {
//     return Container(
//       color: Colors.red[900],
//       child: SizedBox.expand(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             "Please pass in your access token with",
//             "--dart-define=ACCESS_TOKEN=ADD_YOUR_TOKEN_HERE",
//             "passed into flutter run or add it to args in vscode's launch.json",
//           ]
//               .map((text) => Padding(
//                     padding: EdgeInsets.all(8),
//                     child: Text(text,
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white)),
//                   ))
//               .toList(),
//         ),
//       ),
//     );
//   }
// }

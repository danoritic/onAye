import 'package:flutter/material.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import 'backend/api_requests/api_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {}

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  LatLng? _mapCurrentCoord = LatLng(43.7844397, -88.7878678);
  LatLng? get mapCurrentCoord => _mapCurrentCoord;
  set mapCurrentCoord(LatLng? _value) {
    _mapCurrentCoord = _value;
  }

  bool _nearPlaceLIstVisible = false;
  bool get nearPlaceLIstVisible => _nearPlaceLIstVisible;
  set nearPlaceLIstVisible(bool _value) {
    _nearPlaceLIstVisible = _value;
  }

  double _statusTimeRatioOver1500 = 0.0;
  double get statusTimeRatioOver1500 => _statusTimeRatioOver1500;
  set statusTimeRatioOver1500(double _value) {
    _statusTimeRatioOver1500 = _value;
  }
}

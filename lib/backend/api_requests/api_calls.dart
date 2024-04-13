import 'dart:convert';
import 'dart:typed_data';
import '../cloud_functions/cloud_functions.dart';
import '../schema/structs/index.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

class GetCredCall {
  static Future<ApiCallResponse> call() async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'GetCredCall',
        'variables': {},
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class GoogleCall {
  static Future<ApiCallResponse> call() async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'GoogleCall',
        'variables': {},
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list);
  } catch (_) {
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar);
  } catch (_) {
    return isList ? '[]' : '{}';
  }
}

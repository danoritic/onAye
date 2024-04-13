import 'dart:async';
import 'dart:convert';

import 'serialization_util.dart';
import '../backend.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../../index.dart';
import '../../main.dart';

final _handledMessageIds = <String?>{};

class PushNotificationsHandler extends StatefulWidget {
  const PushNotificationsHandler({Key? key, required this.child})
      : super(key: key);

  final Widget child;

  @override
  _PushNotificationsHandlerState createState() =>
      _PushNotificationsHandlerState();
}

class _PushNotificationsHandlerState extends State<PushNotificationsHandler> {
  bool _loading = false;

  Future handleOpenedPushNotification() async {
    if (isWeb) {
      return;
    }

    final notification = await FirebaseMessaging.instance.getInitialMessage();
    if (notification != null) {
      await _handlePushNotification(notification);
    }
    FirebaseMessaging.onMessageOpenedApp.listen(_handlePushNotification);
  }

  Future _handlePushNotification(RemoteMessage message) async {
    if (_handledMessageIds.contains(message.messageId)) {
      return;
    }
    _handledMessageIds.add(message.messageId);

    if (mounted) {
      setState(() => _loading = true);
    }
    try {
      final initialPageName = message.data['initialPageName'] as String;
      final initialParameterData = getInitialParameterData(message.data);
      final parametersBuilder = parametersBuilderMap[initialPageName];
      if (parametersBuilder != null) {
        final parameterData = await parametersBuilder(initialParameterData);
        context.pushNamed(
          initialPageName,
          pathParameters: parameterData.pathParameters,
          extra: parameterData.extra,
        );
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    handleOpenedPushNotification();
  }

  @override
  Widget build(BuildContext context) => _loading
      ? Container(
          color: Colors.transparent,
          child: Center(
            child: Image.asset(
              'assets/images/splashImage.png',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        )
      : widget.child;
}

class ParameterData {
  const ParameterData(
      {this.requiredParams = const {}, this.allParams = const {}});
  final Map<String, String?> requiredParams;
  final Map<String, dynamic> allParams;

  Map<String, String> get pathParameters => Map.fromEntries(
        requiredParams.entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
  Map<String, dynamic> get extra => Map.fromEntries(
        allParams.entries.where((e) => e.value != null),
      );

  static Future<ParameterData> Function(Map<String, dynamic>) none() =>
      (data) async => ParameterData();
}

final parametersBuilderMap =
    <String, Future<ParameterData> Function(Map<String, dynamic>)>{
  'InitialPage': ParameterData.none(),
  'SignUpPage': ParameterData.none(),
  'LoginPage': ParameterData.none(),
  'ForgotPasswordPage': ParameterData.none(),
  'ProfilePage': (data) async => ParameterData(
        allParams: {
          'isOpenedByOwner': getParameter<bool>(data, 'isOpenedByOwner'),
          'isOpenedByFriend': getParameter<bool>(data, 'isOpenedByFriend'),
          'profileDoc': await getDocumentParameter<UsersRecord>(
              data, 'profileDoc', UsersRecord.fromSnapshot),
        },
      ),
  'MapPage': ParameterData.none(),
  'SplashPage': ParameterData.none(),
  'VenueSpecificPage': (data) async => ParameterData(
        allParams: {
          'place': getParameter<DocumentReference>(data, 'place'),
          'isNew': getParameter<bool>(data, 'isNew'),
        },
      ),
  'tiktokStatusLikeMediaDisplay': (data) async => ParameterData(
        allParams: {
          'checkin': await getDocumentParameter<CheckInsRecord>(
              data, 'checkin', CheckInsRecord.fromSnapshot),
          'isOpenedByTheOwner': getParameter<bool>(data, 'isOpenedByTheOwner'),
        },
      ),
  'privateChatPage': (data) async => ParameterData(
        allParams: {
          'chatMate': await getDocumentParameter<FriendRecord>(
              data, 'chatMate', FriendRecord.fromSnapshot),
        },
      ),
  'publicChatPage': (data) async => ParameterData(
        allParams: {
          'place': await getDocumentParameter<PlacesRecord>(
              data, 'place', PlacesRecord.fromSnapshot),
        },
      ),
  'chatListPage': ParameterData.none(),
  'NotificationPage': ParameterData.none(),
  'MapPageCopy': ParameterData.none(),
  'CommonCheckInPage': (data) async => ParameterData(
        allParams: {
          'isOpenedByOwner': getParameter<bool>(data, 'isOpenedByOwner'),
          'isOpenedByFriend': getParameter<bool>(data, 'isOpenedByFriend'),
          'profileDoc': await getDocumentParameter<UsersRecord>(
              data, 'profileDoc', UsersRecord.fromSnapshot),
        },
      ),
  'SplashPageCopy': ParameterData.none(),
  'ListOfAllCheckIns': (data) async => ParameterData(
        allParams: {
          'place': await getDocumentParameter<PlacesRecord>(
              data, 'place', PlacesRecord.fromSnapshot),
        },
      ),
};

Map<String, dynamic> getInitialParameterData(Map<String, dynamic> data) {
  try {
    final parameterDataStr = data['parameterData'];
    if (parameterDataStr == null ||
        parameterDataStr is! String ||
        parameterDataStr.isEmpty) {
      return {};
    }
    return jsonDecode(parameterDataStr) as Map<String, dynamic>;
  } catch (e) {
    print('Error parsing parameter data: $e');
    return {};
  }
}

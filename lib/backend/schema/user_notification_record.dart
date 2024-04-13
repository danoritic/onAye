import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UserNotificationRecord extends FirestoreRecord {
  UserNotificationRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "isPostRenewal" field.
  bool? _isPostRenewal;
  bool get isPostRenewal => _isPostRenewal ?? false;
  bool hasIsPostRenewal() => _isPostRenewal != null;

  // "message" field.
  String? _message;
  String get message => _message ?? '';
  bool hasMessage() => _message != null;

  // "userThatSentMessage" field.
  DocumentReference? _userThatSentMessage;
  DocumentReference? get userThatSentMessage => _userThatSentMessage;
  bool hasUserThatSentMessage() => _userThatSentMessage != null;

  // "timeOfPosting" field.
  DateTime? _timeOfPosting;
  DateTime? get timeOfPosting => _timeOfPosting;
  bool hasTimeOfPosting() => _timeOfPosting != null;

  // "isPublicChat" field.
  bool? _isPublicChat;
  bool get isPublicChat => _isPublicChat ?? false;
  bool hasIsPublicChat() => _isPublicChat != null;

  // "isPrivateChat" field.
  bool? _isPrivateChat;
  bool get isPrivateChat => _isPrivateChat ?? false;
  bool hasIsPrivateChat() => _isPrivateChat != null;

  // "chatMate" field.
  DocumentReference? _chatMate;
  DocumentReference? get chatMate => _chatMate;
  bool hasChatMate() => _chatMate != null;

  // "place" field.
  DocumentReference? _place;
  DocumentReference? get place => _place;
  bool hasPlace() => _place != null;

  // "checkIn" field.
  DocumentReference? _checkIn;
  DocumentReference? get checkIn => _checkIn;
  bool hasCheckIn() => _checkIn != null;

  // "isReaction" field.
  bool? _isReaction;
  bool get isReaction => _isReaction ?? false;
  bool hasIsReaction() => _isReaction != null;

  // "isViewed" field.
  bool? _isViewed;
  bool get isViewed => _isViewed ?? false;
  bool hasIsViewed() => _isViewed != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _isPostRenewal = snapshotData['isPostRenewal'] as bool?;
    _message = snapshotData['message'] as String?;
    _userThatSentMessage =
        snapshotData['userThatSentMessage'] as DocumentReference?;
    _timeOfPosting = snapshotData['timeOfPosting'] as DateTime?;
    _isPublicChat = snapshotData['isPublicChat'] as bool?;
    _isPrivateChat = snapshotData['isPrivateChat'] as bool?;
    _chatMate = snapshotData['chatMate'] as DocumentReference?;
    _place = snapshotData['place'] as DocumentReference?;
    _checkIn = snapshotData['checkIn'] as DocumentReference?;
    _isReaction = snapshotData['isReaction'] as bool?;
    _isViewed = snapshotData['isViewed'] as bool?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('UserNotification')
          : FirebaseFirestore.instance.collectionGroup('UserNotification');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('UserNotification').doc(id);

  static Stream<UserNotificationRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UserNotificationRecord.fromSnapshot(s));

  static Future<UserNotificationRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => UserNotificationRecord.fromSnapshot(s));

  static UserNotificationRecord fromSnapshot(DocumentSnapshot snapshot) =>
      UserNotificationRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UserNotificationRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UserNotificationRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UserNotificationRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UserNotificationRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUserNotificationRecordData({
  bool? isPostRenewal,
  String? message,
  DocumentReference? userThatSentMessage,
  DateTime? timeOfPosting,
  bool? isPublicChat,
  bool? isPrivateChat,
  DocumentReference? chatMate,
  DocumentReference? place,
  DocumentReference? checkIn,
  bool? isReaction,
  bool? isViewed,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'isPostRenewal': isPostRenewal,
      'message': message,
      'userThatSentMessage': userThatSentMessage,
      'timeOfPosting': timeOfPosting,
      'isPublicChat': isPublicChat,
      'isPrivateChat': isPrivateChat,
      'chatMate': chatMate,
      'place': place,
      'checkIn': checkIn,
      'isReaction': isReaction,
      'isViewed': isViewed,
    }.withoutNulls,
  );

  return firestoreData;
}

class UserNotificationRecordDocumentEquality
    implements Equality<UserNotificationRecord> {
  const UserNotificationRecordDocumentEquality();

  @override
  bool equals(UserNotificationRecord? e1, UserNotificationRecord? e2) {
    return e1?.isPostRenewal == e2?.isPostRenewal &&
        e1?.message == e2?.message &&
        e1?.userThatSentMessage == e2?.userThatSentMessage &&
        e1?.timeOfPosting == e2?.timeOfPosting &&
        e1?.isPublicChat == e2?.isPublicChat &&
        e1?.isPrivateChat == e2?.isPrivateChat &&
        e1?.chatMate == e2?.chatMate &&
        e1?.place == e2?.place &&
        e1?.checkIn == e2?.checkIn &&
        e1?.isReaction == e2?.isReaction &&
        e1?.isViewed == e2?.isViewed;
  }

  @override
  int hash(UserNotificationRecord? e) => const ListEquality().hash([
        e?.isPostRenewal,
        e?.message,
        e?.userThatSentMessage,
        e?.timeOfPosting,
        e?.isPublicChat,
        e?.isPrivateChat,
        e?.chatMate,
        e?.place,
        e?.checkIn,
        e?.isReaction,
        e?.isViewed
      ]);

  @override
  bool isValidKey(Object? o) => o is UserNotificationRecord;
}

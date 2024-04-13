import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class FriendRecord extends FirestoreRecord {
  FriendRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "friendUserRef" field.
  DocumentReference? _friendUserRef;
  DocumentReference? get friendUserRef => _friendUserRef;
  bool hasFriendUserRef() => _friendUserRef != null;

  // "lastMessage" field.
  DocumentReference? _lastMessage;
  DocumentReference? get lastMessage => _lastMessage;
  bool hasLastMessage() => _lastMessage != null;

  // "noOfUnreadMessages" field.
  int? _noOfUnreadMessages;
  int get noOfUnreadMessages => _noOfUnreadMessages ?? 0;
  bool hasNoOfUnreadMessages() => _noOfUnreadMessages != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _friendUserRef = snapshotData['friendUserRef'] as DocumentReference?;
    _lastMessage = snapshotData['lastMessage'] as DocumentReference?;
    _noOfUnreadMessages = castToType<int>(snapshotData['noOfUnreadMessages']);
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('friend')
          : FirebaseFirestore.instance.collectionGroup('friend');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('friend').doc(id);

  static Stream<FriendRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => FriendRecord.fromSnapshot(s));

  static Future<FriendRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => FriendRecord.fromSnapshot(s));

  static FriendRecord fromSnapshot(DocumentSnapshot snapshot) => FriendRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static FriendRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      FriendRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'FriendRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is FriendRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createFriendRecordData({
  DocumentReference? friendUserRef,
  DocumentReference? lastMessage,
  int? noOfUnreadMessages,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'friendUserRef': friendUserRef,
      'lastMessage': lastMessage,
      'noOfUnreadMessages': noOfUnreadMessages,
    }.withoutNulls,
  );

  return firestoreData;
}

class FriendRecordDocumentEquality implements Equality<FriendRecord> {
  const FriendRecordDocumentEquality();

  @override
  bool equals(FriendRecord? e1, FriendRecord? e2) {
    return e1?.friendUserRef == e2?.friendUserRef &&
        e1?.lastMessage == e2?.lastMessage &&
        e1?.noOfUnreadMessages == e2?.noOfUnreadMessages;
  }

  @override
  int hash(FriendRecord? e) => const ListEquality()
      .hash([e?.friendUserRef, e?.lastMessage, e?.noOfUnreadMessages]);

  @override
  bool isValidKey(Object? o) => o is FriendRecord;
}

import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UserPotentialChatMateRecord extends FirestoreRecord {
  UserPotentialChatMateRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "checkIn" field.
  DocumentReference? _checkIn;
  DocumentReference? get checkIn => _checkIn;
  bool hasCheckIn() => _checkIn != null;

  // "userThatReacted" field.
  DocumentReference? _userThatReacted;
  DocumentReference? get userThatReacted => _userThatReacted;
  bool hasUserThatReacted() => _userThatReacted != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _checkIn = snapshotData['checkIn'] as DocumentReference?;
    _userThatReacted = snapshotData['userThatReacted'] as DocumentReference?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('userPotentialChatMate')
          : FirebaseFirestore.instance.collectionGroup('userPotentialChatMate');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('userPotentialChatMate').doc(id);

  static Stream<UserPotentialChatMateRecord> getDocument(
          DocumentReference ref) =>
      ref.snapshots().map((s) => UserPotentialChatMateRecord.fromSnapshot(s));

  static Future<UserPotentialChatMateRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => UserPotentialChatMateRecord.fromSnapshot(s));

  static UserPotentialChatMateRecord fromSnapshot(DocumentSnapshot snapshot) =>
      UserPotentialChatMateRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UserPotentialChatMateRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UserPotentialChatMateRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UserPotentialChatMateRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UserPotentialChatMateRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUserPotentialChatMateRecordData({
  DocumentReference? checkIn,
  DocumentReference? userThatReacted,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'checkIn': checkIn,
      'userThatReacted': userThatReacted,
    }.withoutNulls,
  );

  return firestoreData;
}

class UserPotentialChatMateRecordDocumentEquality
    implements Equality<UserPotentialChatMateRecord> {
  const UserPotentialChatMateRecordDocumentEquality();

  @override
  bool equals(
      UserPotentialChatMateRecord? e1, UserPotentialChatMateRecord? e2) {
    return e1?.checkIn == e2?.checkIn &&
        e1?.userThatReacted == e2?.userThatReacted;
  }

  @override
  int hash(UserPotentialChatMateRecord? e) =>
      const ListEquality().hash([e?.checkIn, e?.userThatReacted]);

  @override
  bool isValidKey(Object? o) => o is UserPotentialChatMateRecord;
}

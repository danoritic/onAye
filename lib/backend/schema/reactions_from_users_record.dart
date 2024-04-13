import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ReactionsFromUsersRecord extends FirestoreRecord {
  ReactionsFromUsersRecord._(
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

  void _initializeFields() {
    _checkIn = snapshotData['checkIn'] as DocumentReference?;
    _userThatReacted = snapshotData['userThatReacted'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('reactionsFromUsers');

  static Stream<ReactionsFromUsersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ReactionsFromUsersRecord.fromSnapshot(s));

  static Future<ReactionsFromUsersRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => ReactionsFromUsersRecord.fromSnapshot(s));

  static ReactionsFromUsersRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ReactionsFromUsersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ReactionsFromUsersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ReactionsFromUsersRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ReactionsFromUsersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ReactionsFromUsersRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createReactionsFromUsersRecordData({
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

class ReactionsFromUsersRecordDocumentEquality
    implements Equality<ReactionsFromUsersRecord> {
  const ReactionsFromUsersRecordDocumentEquality();

  @override
  bool equals(ReactionsFromUsersRecord? e1, ReactionsFromUsersRecord? e2) {
    return e1?.checkIn == e2?.checkIn &&
        e1?.userThatReacted == e2?.userThatReacted;
  }

  @override
  int hash(ReactionsFromUsersRecord? e) =>
      const ListEquality().hash([e?.checkIn, e?.userThatReacted]);

  @override
  bool isValidKey(Object? o) => o is ReactionsFromUsersRecord;
}

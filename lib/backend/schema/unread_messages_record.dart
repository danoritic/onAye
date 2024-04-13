import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UnreadMessagesRecord extends FirestoreRecord {
  UnreadMessagesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "isPrivate" field.
  bool? _isPrivate;
  bool get isPrivate => _isPrivate ?? false;
  bool hasIsPrivate() => _isPrivate != null;

  // "privateChatRealDocRef" field.
  DocumentReference? _privateChatRealDocRef;
  DocumentReference? get privateChatRealDocRef => _privateChatRealDocRef;
  bool hasPrivateChatRealDocRef() => _privateChatRealDocRef != null;

  // "placeChatRealDocRef" field.
  DocumentReference? _placeChatRealDocRef;
  DocumentReference? get placeChatRealDocRef => _placeChatRealDocRef;
  bool hasPlaceChatRealDocRef() => _placeChatRealDocRef != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _isPrivate = snapshotData['isPrivate'] as bool?;
    _privateChatRealDocRef =
        snapshotData['privateChatRealDocRef'] as DocumentReference?;
    _placeChatRealDocRef =
        snapshotData['placeChatRealDocRef'] as DocumentReference?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('unreadMessages')
          : FirebaseFirestore.instance.collectionGroup('unreadMessages');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('unreadMessages').doc(id);

  static Stream<UnreadMessagesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UnreadMessagesRecord.fromSnapshot(s));

  static Future<UnreadMessagesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UnreadMessagesRecord.fromSnapshot(s));

  static UnreadMessagesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      UnreadMessagesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UnreadMessagesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UnreadMessagesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UnreadMessagesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UnreadMessagesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUnreadMessagesRecordData({
  bool? isPrivate,
  DocumentReference? privateChatRealDocRef,
  DocumentReference? placeChatRealDocRef,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'isPrivate': isPrivate,
      'privateChatRealDocRef': privateChatRealDocRef,
      'placeChatRealDocRef': placeChatRealDocRef,
    }.withoutNulls,
  );

  return firestoreData;
}

class UnreadMessagesRecordDocumentEquality
    implements Equality<UnreadMessagesRecord> {
  const UnreadMessagesRecordDocumentEquality();

  @override
  bool equals(UnreadMessagesRecord? e1, UnreadMessagesRecord? e2) {
    return e1?.isPrivate == e2?.isPrivate &&
        e1?.privateChatRealDocRef == e2?.privateChatRealDocRef &&
        e1?.placeChatRealDocRef == e2?.placeChatRealDocRef;
  }

  @override
  int hash(UnreadMessagesRecord? e) => const ListEquality()
      .hash([e?.isPrivate, e?.privateChatRealDocRef, e?.placeChatRealDocRef]);

  @override
  bool isValidKey(Object? o) => o is UnreadMessagesRecord;
}

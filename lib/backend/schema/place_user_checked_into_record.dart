import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PlaceUserCheckedIntoRecord extends FirestoreRecord {
  PlaceUserCheckedIntoRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "placeRef" field.
  DocumentReference? _placeRef;
  DocumentReference? get placeRef => _placeRef;
  bool hasPlaceRef() => _placeRef != null;

  // "lastMessage" field.
  DocumentReference? _lastMessage;
  DocumentReference? get lastMessage => _lastMessage;
  bool hasLastMessage() => _lastMessage != null;

  // "noOfUnreadMessage" field.
  int? _noOfUnreadMessage;
  int get noOfUnreadMessage => _noOfUnreadMessage ?? 0;
  bool hasNoOfUnreadMessage() => _noOfUnreadMessage != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _placeRef = snapshotData['placeRef'] as DocumentReference?;
    _lastMessage = snapshotData['lastMessage'] as DocumentReference?;
    _noOfUnreadMessage = castToType<int>(snapshotData['noOfUnreadMessage']);
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('placeUserCheckedInto')
          : FirebaseFirestore.instance.collectionGroup('placeUserCheckedInto');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('placeUserCheckedInto').doc(id);

  static Stream<PlaceUserCheckedIntoRecord> getDocument(
          DocumentReference ref) =>
      ref.snapshots().map((s) => PlaceUserCheckedIntoRecord.fromSnapshot(s));

  static Future<PlaceUserCheckedIntoRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => PlaceUserCheckedIntoRecord.fromSnapshot(s));

  static PlaceUserCheckedIntoRecord fromSnapshot(DocumentSnapshot snapshot) =>
      PlaceUserCheckedIntoRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static PlaceUserCheckedIntoRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      PlaceUserCheckedIntoRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'PlaceUserCheckedIntoRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is PlaceUserCheckedIntoRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createPlaceUserCheckedIntoRecordData({
  DocumentReference? placeRef,
  DocumentReference? lastMessage,
  int? noOfUnreadMessage,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'placeRef': placeRef,
      'lastMessage': lastMessage,
      'noOfUnreadMessage': noOfUnreadMessage,
    }.withoutNulls,
  );

  return firestoreData;
}

class PlaceUserCheckedIntoRecordDocumentEquality
    implements Equality<PlaceUserCheckedIntoRecord> {
  const PlaceUserCheckedIntoRecordDocumentEquality();

  @override
  bool equals(PlaceUserCheckedIntoRecord? e1, PlaceUserCheckedIntoRecord? e2) {
    return e1?.placeRef == e2?.placeRef &&
        e1?.lastMessage == e2?.lastMessage &&
        e1?.noOfUnreadMessage == e2?.noOfUnreadMessage;
  }

  @override
  int hash(PlaceUserCheckedIntoRecord? e) => const ListEquality()
      .hash([e?.placeRef, e?.lastMessage, e?.noOfUnreadMessage]);

  @override
  bool isValidKey(Object? o) => o is PlaceUserCheckedIntoRecord;
}

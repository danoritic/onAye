import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CheckinRadiusRecord extends FirestoreRecord {
  CheckinRadiusRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "radius" field.
  double? _radius;
  double get radius => _radius ?? 0.0;
  bool hasRadius() => _radius != null;

  void _initializeFields() {
    _radius = castToType<double>(snapshotData['radius']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('checkinRadius');

  static Stream<CheckinRadiusRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => CheckinRadiusRecord.fromSnapshot(s));

  static Future<CheckinRadiusRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => CheckinRadiusRecord.fromSnapshot(s));

  static CheckinRadiusRecord fromSnapshot(DocumentSnapshot snapshot) =>
      CheckinRadiusRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static CheckinRadiusRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      CheckinRadiusRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'CheckinRadiusRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is CheckinRadiusRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createCheckinRadiusRecordData({
  double? radius,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'radius': radius,
    }.withoutNulls,
  );

  return firestoreData;
}

class CheckinRadiusRecordDocumentEquality
    implements Equality<CheckinRadiusRecord> {
  const CheckinRadiusRecordDocumentEquality();

  @override
  bool equals(CheckinRadiusRecord? e1, CheckinRadiusRecord? e2) {
    return e1?.radius == e2?.radius;
  }

  @override
  int hash(CheckinRadiusRecord? e) => const ListEquality().hash([e?.radius]);

  @override
  bool isValidKey(Object? o) => o is CheckinRadiusRecord;
}

import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CheckInsRecord extends FirestoreRecord {
  CheckInsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "time" field.
  DateTime? _time;
  DateTime? get time => _time;
  bool hasTime() => _time != null;

  // "place" field.
  DocumentReference? _place;
  DocumentReference? get place => _place;
  bool hasPlace() => _place != null;

  // "owner" field.
  DocumentReference? _owner;
  DocumentReference? get owner => _owner;
  bool hasOwner() => _owner != null;

  // "media" field.
  MediaPathStruct? _media;
  MediaPathStruct get media => _media ?? MediaPathStruct();
  bool hasMedia() => _media != null;

  // "noOfReactants" field.
  int? _noOfReactants;
  int get noOfReactants => _noOfReactants ?? 0;
  bool hasNoOfReactants() => _noOfReactants != null;

  // "Reactants" field.
  List<DocumentReference>? _reactants;
  List<DocumentReference> get reactants => _reactants ?? const [];
  bool hasReactants() => _reactants != null;

  // "hasExpired" field.
  bool? _hasExpired;
  bool get hasExpired => _hasExpired ?? false;
  bool hasHasExpired() => _hasExpired != null;

  // "expirationDate" field.
  DateTime? _expirationDate;
  DateTime? get expirationDate => _expirationDate;
  bool hasExpirationDate() => _expirationDate != null;

  // "canExpire" field.
  bool? _canExpire;
  bool get canExpire => _canExpire ?? false;
  bool hasCanExpire() => _canExpire != null;

  // "dateAdded" field.
  DateTime? _dateAdded;
  DateTime? get dateAdded => _dateAdded;
  bool hasDateAdded() => _dateAdded != null;

  // "caption" field.
  String? _caption;
  String get caption => _caption ?? '';
  bool hasCaption() => _caption != null;

  // "nameOfOwner" field.
  String? _nameOfOwner;
  String get nameOfOwner => _nameOfOwner ?? '';
  bool hasNameOfOwner() => _nameOfOwner != null;

  void _initializeFields() {
    _time = snapshotData['time'] as DateTime?;
    _place = snapshotData['place'] as DocumentReference?;
    _owner = snapshotData['owner'] as DocumentReference?;
    _media = MediaPathStruct.maybeFromMap(snapshotData['media']);
    _noOfReactants = castToType<int>(snapshotData['noOfReactants']);
    _reactants = getDataList(snapshotData['Reactants']);
    _hasExpired = snapshotData['hasExpired'] as bool?;
    _expirationDate = snapshotData['expirationDate'] as DateTime?;
    _canExpire = snapshotData['canExpire'] as bool?;
    _dateAdded = snapshotData['dateAdded'] as DateTime?;
    _caption = snapshotData['caption'] as String?;
    _nameOfOwner = snapshotData['nameOfOwner'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('checkIns');

  static Stream<CheckInsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => CheckInsRecord.fromSnapshot(s));

  static Future<CheckInsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => CheckInsRecord.fromSnapshot(s));

  static CheckInsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      CheckInsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static CheckInsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      CheckInsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'CheckInsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is CheckInsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createCheckInsRecordData({
  DateTime? time,
  DocumentReference? place,
  DocumentReference? owner,
  MediaPathStruct? media,
  int? noOfReactants,
  bool? hasExpired,
  DateTime? expirationDate,
  bool? canExpire,
  DateTime? dateAdded,
  String? caption,
  String? nameOfOwner,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'time': time,
      'place': place,
      'owner': owner,
      'media': MediaPathStruct().toMap(),
      'noOfReactants': noOfReactants,
      'hasExpired': hasExpired,
      'expirationDate': expirationDate,
      'canExpire': canExpire,
      'dateAdded': dateAdded,
      'caption': caption,
      'nameOfOwner': nameOfOwner,
    }.withoutNulls,
  );

  // Handle nested data for "media" field.
  addMediaPathStructData(firestoreData, media, 'media');

  return firestoreData;
}

class CheckInsRecordDocumentEquality implements Equality<CheckInsRecord> {
  const CheckInsRecordDocumentEquality();

  @override
  bool equals(CheckInsRecord? e1, CheckInsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.time == e2?.time &&
        e1?.place == e2?.place &&
        e1?.owner == e2?.owner &&
        e1?.media == e2?.media &&
        e1?.noOfReactants == e2?.noOfReactants &&
        listEquality.equals(e1?.reactants, e2?.reactants) &&
        e1?.hasExpired == e2?.hasExpired &&
        e1?.expirationDate == e2?.expirationDate &&
        e1?.canExpire == e2?.canExpire &&
        e1?.dateAdded == e2?.dateAdded &&
        e1?.caption == e2?.caption &&
        e1?.nameOfOwner == e2?.nameOfOwner;
  }

  @override
  int hash(CheckInsRecord? e) => const ListEquality().hash([
        e?.time,
        e?.place,
        e?.owner,
        e?.media,
        e?.noOfReactants,
        e?.reactants,
        e?.hasExpired,
        e?.expirationDate,
        e?.canExpire,
        e?.dateAdded,
        e?.caption,
        e?.nameOfOwner
      ]);

  @override
  bool isValidKey(Object? o) => o is CheckInsRecord;
}

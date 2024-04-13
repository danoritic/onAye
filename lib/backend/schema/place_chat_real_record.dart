import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PlaceChatRealRecord extends FirestoreRecord {
  PlaceChatRealRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "sender" field.
  DocumentReference? _sender;
  DocumentReference? get sender => _sender;
  bool hasSender() => _sender != null;

  // "message" field.
  String? _message;
  String get message => _message ?? '';
  bool hasMessage() => _message != null;

  // "date" field.
  DateTime? _date;
  DateTime? get date => _date;
  bool hasDate() => _date != null;

  // "participants" field.
  List<DocumentReference>? _participants;
  List<DocumentReference> get participants => _participants ?? const [];
  bool hasParticipants() => _participants != null;

  // "place" field.
  DocumentReference? _place;
  DocumentReference? get place => _place;
  bool hasPlace() => _place != null;

  // "paticipantsThatHasReadTheMessage" field.
  List<DocumentReference>? _paticipantsThatHasReadTheMessage;
  List<DocumentReference> get paticipantsThatHasReadTheMessage =>
      _paticipantsThatHasReadTheMessage ?? const [];
  bool hasPaticipantsThatHasReadTheMessage() =>
      _paticipantsThatHasReadTheMessage != null;

  void _initializeFields() {
    _sender = snapshotData['sender'] as DocumentReference?;
    _message = snapshotData['message'] as String?;
    _date = snapshotData['date'] as DateTime?;
    _participants = getDataList(snapshotData['participants']);
    _place = snapshotData['place'] as DocumentReference?;
    _paticipantsThatHasReadTheMessage =
        getDataList(snapshotData['paticipantsThatHasReadTheMessage']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('placeChatReal');

  static Stream<PlaceChatRealRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => PlaceChatRealRecord.fromSnapshot(s));

  static Future<PlaceChatRealRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => PlaceChatRealRecord.fromSnapshot(s));

  static PlaceChatRealRecord fromSnapshot(DocumentSnapshot snapshot) =>
      PlaceChatRealRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static PlaceChatRealRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      PlaceChatRealRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'PlaceChatRealRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is PlaceChatRealRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createPlaceChatRealRecordData({
  DocumentReference? sender,
  String? message,
  DateTime? date,
  DocumentReference? place,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'sender': sender,
      'message': message,
      'date': date,
      'place': place,
    }.withoutNulls,
  );

  return firestoreData;
}

class PlaceChatRealRecordDocumentEquality
    implements Equality<PlaceChatRealRecord> {
  const PlaceChatRealRecordDocumentEquality();

  @override
  bool equals(PlaceChatRealRecord? e1, PlaceChatRealRecord? e2) {
    const listEquality = ListEquality();
    return e1?.sender == e2?.sender &&
        e1?.message == e2?.message &&
        e1?.date == e2?.date &&
        listEquality.equals(e1?.participants, e2?.participants) &&
        e1?.place == e2?.place &&
        listEquality.equals(e1?.paticipantsThatHasReadTheMessage,
            e2?.paticipantsThatHasReadTheMessage);
  }

  @override
  int hash(PlaceChatRealRecord? e) => const ListEquality().hash([
        e?.sender,
        e?.message,
        e?.date,
        e?.participants,
        e?.place,
        e?.paticipantsThatHasReadTheMessage
      ]);

  @override
  bool isValidKey(Object? o) => o is PlaceChatRealRecord;
}

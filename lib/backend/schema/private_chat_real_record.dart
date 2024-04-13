import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PrivateChatRealRecord extends FirestoreRecord {
  PrivateChatRealRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "sender" field.
  DocumentReference? _sender;
  DocumentReference? get sender => _sender;
  bool hasSender() => _sender != null;

  // "reciever" field.
  DocumentReference? _reciever;
  DocumentReference? get reciever => _reciever;
  bool hasReciever() => _reciever != null;

  // "message" field.
  String? _message;
  String get message => _message ?? '';
  bool hasMessage() => _message != null;

  // "date" field.
  DateTime? _date;
  DateTime? get date => _date;
  bool hasDate() => _date != null;

  // "isRecievedAndRead" field.
  bool? _isRecievedAndRead;
  bool get isRecievedAndRead => _isRecievedAndRead ?? false;
  bool hasIsRecievedAndRead() => _isRecievedAndRead != null;

  void _initializeFields() {
    _sender = snapshotData['sender'] as DocumentReference?;
    _reciever = snapshotData['reciever'] as DocumentReference?;
    _message = snapshotData['message'] as String?;
    _date = snapshotData['date'] as DateTime?;
    _isRecievedAndRead = snapshotData['isRecievedAndRead'] as bool?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('privateChatReal');

  static Stream<PrivateChatRealRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => PrivateChatRealRecord.fromSnapshot(s));

  static Future<PrivateChatRealRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => PrivateChatRealRecord.fromSnapshot(s));

  static PrivateChatRealRecord fromSnapshot(DocumentSnapshot snapshot) =>
      PrivateChatRealRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static PrivateChatRealRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      PrivateChatRealRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'PrivateChatRealRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is PrivateChatRealRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createPrivateChatRealRecordData({
  DocumentReference? sender,
  DocumentReference? reciever,
  String? message,
  DateTime? date,
  bool? isRecievedAndRead,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'sender': sender,
      'reciever': reciever,
      'message': message,
      'date': date,
      'isRecievedAndRead': isRecievedAndRead,
    }.withoutNulls,
  );

  return firestoreData;
}

class PrivateChatRealRecordDocumentEquality
    implements Equality<PrivateChatRealRecord> {
  const PrivateChatRealRecordDocumentEquality();

  @override
  bool equals(PrivateChatRealRecord? e1, PrivateChatRealRecord? e2) {
    return e1?.sender == e2?.sender &&
        e1?.reciever == e2?.reciever &&
        e1?.message == e2?.message &&
        e1?.date == e2?.date &&
        e1?.isRecievedAndRead == e2?.isRecievedAndRead;
  }

  @override
  int hash(PrivateChatRealRecord? e) => const ListEquality().hash(
      [e?.sender, e?.reciever, e?.message, e?.date, e?.isRecievedAndRead]);

  @override
  bool isValidKey(Object? o) => o is PrivateChatRealRecord;
}

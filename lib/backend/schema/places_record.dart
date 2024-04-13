import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PlacesRecord extends FirestoreRecord {
  PlacesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "modified_at" field.
  DateTime? _modifiedAt;
  DateTime? get modifiedAt => _modifiedAt;
  bool hasModifiedAt() => _modifiedAt != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "thumbnail_image" field.
  String? _thumbnailImage;
  String get thumbnailImage => _thumbnailImage ?? '';
  bool hasThumbnailImage() => _thumbnailImage != null;

  // "main_image" field.
  String? _mainImage;
  String get mainImage => _mainImage ?? '';
  bool hasMainImage() => _mainImage != null;

  // "rating" field.
  int? _rating;
  int get rating => _rating ?? 0;
  bool hasRating() => _rating != null;

  // "number_of_checkings" field.
  int? _numberOfCheckings;
  int get numberOfCheckings => _numberOfCheckings ?? 0;
  bool hasNumberOfCheckings() => _numberOfCheckings != null;

  // "bussiness_type" field.
  String? _bussinessType;
  String get bussinessType => _bussinessType ?? '';
  bool hasBussinessType() => _bussinessType != null;

  // "coord" field.
  LatLng? _coord;
  LatLng? get coord => _coord;
  bool hasCoord() => _coord != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "addressString" field.
  String? _addressString;
  String get addressString => _addressString ?? '';
  bool hasAddressString() => _addressString != null;

  // "userThatAreCheckedIn" field.
  List<DocumentReference>? _userThatAreCheckedIn;
  List<DocumentReference> get userThatAreCheckedIn =>
      _userThatAreCheckedIn ?? const [];
  bool hasUserThatAreCheckedIn() => _userThatAreCheckedIn != null;

  // "usersThatAreChatting" field.
  List<DocumentReference>? _usersThatAreChatting;
  List<DocumentReference> get usersThatAreChatting =>
      _usersThatAreChatting ?? const [];
  bool hasUsersThatAreChatting() => _usersThatAreChatting != null;

  // "noOfCheckings" field.
  int? _noOfCheckings;
  int get noOfCheckings => _noOfCheckings ?? 0;
  bool hasNoOfCheckings() => _noOfCheckings != null;

  // "lastMessage" field.
  DocumentReference? _lastMessage;
  DocumentReference? get lastMessage => _lastMessage;
  bool hasLastMessage() => _lastMessage != null;

  void _initializeFields() {
    _createdAt = snapshotData['created_at'] as DateTime?;
    _modifiedAt = snapshotData['modified_at'] as DateTime?;
    _name = snapshotData['name'] as String?;
    _thumbnailImage = snapshotData['thumbnail_image'] as String?;
    _mainImage = snapshotData['main_image'] as String?;
    _rating = castToType<int>(snapshotData['rating']);
    _numberOfCheckings = castToType<int>(snapshotData['number_of_checkings']);
    _bussinessType = snapshotData['bussiness_type'] as String?;
    _coord = snapshotData['coord'] as LatLng?;
    _description = snapshotData['description'] as String?;
    _addressString = snapshotData['addressString'] as String?;
    _userThatAreCheckedIn = getDataList(snapshotData['userThatAreCheckedIn']);
    _usersThatAreChatting = getDataList(snapshotData['usersThatAreChatting']);
    _noOfCheckings = castToType<int>(snapshotData['noOfCheckings']);
    _lastMessage = snapshotData['lastMessage'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('places');

  static Stream<PlacesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => PlacesRecord.fromSnapshot(s));

  static Future<PlacesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => PlacesRecord.fromSnapshot(s));

  static PlacesRecord fromSnapshot(DocumentSnapshot snapshot) => PlacesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static PlacesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      PlacesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'PlacesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is PlacesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createPlacesRecordData({
  DateTime? createdAt,
  DateTime? modifiedAt,
  String? name,
  String? thumbnailImage,
  String? mainImage,
  int? rating,
  int? numberOfCheckings,
  String? bussinessType,
  LatLng? coord,
  String? description,
  String? addressString,
  int? noOfCheckings,
  DocumentReference? lastMessage,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'created_at': createdAt,
      'modified_at': modifiedAt,
      'name': name,
      'thumbnail_image': thumbnailImage,
      'main_image': mainImage,
      'rating': rating,
      'number_of_checkings': numberOfCheckings,
      'bussiness_type': bussinessType,
      'coord': coord,
      'description': description,
      'addressString': addressString,
      'noOfCheckings': noOfCheckings,
      'lastMessage': lastMessage,
    }.withoutNulls,
  );

  return firestoreData;
}

class PlacesRecordDocumentEquality implements Equality<PlacesRecord> {
  const PlacesRecordDocumentEquality();

  @override
  bool equals(PlacesRecord? e1, PlacesRecord? e2) {
    const listEquality = ListEquality();
    return e1?.createdAt == e2?.createdAt &&
        e1?.modifiedAt == e2?.modifiedAt &&
        e1?.name == e2?.name &&
        e1?.thumbnailImage == e2?.thumbnailImage &&
        e1?.mainImage == e2?.mainImage &&
        e1?.rating == e2?.rating &&
        e1?.numberOfCheckings == e2?.numberOfCheckings &&
        e1?.bussinessType == e2?.bussinessType &&
        e1?.coord == e2?.coord &&
        e1?.description == e2?.description &&
        e1?.addressString == e2?.addressString &&
        listEquality.equals(
            e1?.userThatAreCheckedIn, e2?.userThatAreCheckedIn) &&
        listEquality.equals(
            e1?.usersThatAreChatting, e2?.usersThatAreChatting) &&
        e1?.noOfCheckings == e2?.noOfCheckings &&
        e1?.lastMessage == e2?.lastMessage;
  }

  @override
  int hash(PlacesRecord? e) => const ListEquality().hash([
        e?.createdAt,
        e?.modifiedAt,
        e?.name,
        e?.thumbnailImage,
        e?.mainImage,
        e?.rating,
        e?.numberOfCheckings,
        e?.bussinessType,
        e?.coord,
        e?.description,
        e?.addressString,
        e?.userThatAreCheckedIn,
        e?.usersThatAreChatting,
        e?.noOfCheckings,
        e?.lastMessage
      ]);

  @override
  bool isValidKey(Object? o) => o is PlacesRecord;
}

// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MediaPathStruct extends FFFirebaseStruct {
  MediaPathStruct({
    String? photoPath,
    String? videoPath,
    bool? isPhoto,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _photoPath = photoPath,
        _videoPath = videoPath,
        _isPhoto = isPhoto,
        super(firestoreUtilData);

  // "photoPath" field.
  String? _photoPath;
  String get photoPath => _photoPath ?? '';
  set photoPath(String? val) => _photoPath = val;
  bool hasPhotoPath() => _photoPath != null;

  // "videoPath" field.
  String? _videoPath;
  String get videoPath => _videoPath ?? '';
  set videoPath(String? val) => _videoPath = val;
  bool hasVideoPath() => _videoPath != null;

  // "isPhoto" field.
  bool? _isPhoto;
  bool get isPhoto => _isPhoto ?? false;
  set isPhoto(bool? val) => _isPhoto = val;
  bool hasIsPhoto() => _isPhoto != null;

  static MediaPathStruct fromMap(Map<String, dynamic> data) => MediaPathStruct(
        photoPath: data['photoPath'] as String?,
        videoPath: data['videoPath'] as String?,
        isPhoto: data['isPhoto'] as bool?,
      );

  static MediaPathStruct? maybeFromMap(dynamic data) => data is Map
      ? MediaPathStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'photoPath': _photoPath,
        'videoPath': _videoPath,
        'isPhoto': _isPhoto,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'photoPath': serializeParam(
          _photoPath,
          ParamType.String,
        ),
        'videoPath': serializeParam(
          _videoPath,
          ParamType.String,
        ),
        'isPhoto': serializeParam(
          _isPhoto,
          ParamType.bool,
        ),
      }.withoutNulls;

  static MediaPathStruct fromSerializableMap(Map<String, dynamic> data) =>
      MediaPathStruct(
        photoPath: deserializeParam(
          data['photoPath'],
          ParamType.String,
          false,
        ),
        videoPath: deserializeParam(
          data['videoPath'],
          ParamType.String,
          false,
        ),
        isPhoto: deserializeParam(
          data['isPhoto'],
          ParamType.bool,
          false,
        ),
      );

  @override
  String toString() => 'MediaPathStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is MediaPathStruct &&
        photoPath == other.photoPath &&
        videoPath == other.videoPath &&
        isPhoto == other.isPhoto;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([photoPath, videoPath, isPhoto]);
}

MediaPathStruct createMediaPathStruct({
  String? photoPath,
  String? videoPath,
  bool? isPhoto,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    MediaPathStruct(
      photoPath: photoPath,
      videoPath: videoPath,
      isPhoto: isPhoto,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

MediaPathStruct? updateMediaPathStruct(
  MediaPathStruct? mediaPath, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    mediaPath
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addMediaPathStructData(
  Map<String, dynamic> firestoreData,
  MediaPathStruct? mediaPath,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (mediaPath == null) {
    return;
  }
  if (mediaPath.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && mediaPath.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final mediaPathData = getMediaPathFirestoreData(mediaPath, forFieldValue);
  final nestedData = mediaPathData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = mediaPath.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getMediaPathFirestoreData(
  MediaPathStruct? mediaPath, [
  bool forFieldValue = false,
]) {
  if (mediaPath == null) {
    return {};
  }
  final firestoreData = mapToFirestore(mediaPath.toMap());

  // Add any Firestore field values
  mediaPath.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getMediaPathListFirestoreData(
  List<MediaPathStruct>? mediaPaths,
) =>
    mediaPaths?.map((e) => getMediaPathFirestoreData(e, true)).toList() ?? [];

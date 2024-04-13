// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PlacesStruct extends FFFirebaseStruct {
  PlacesStruct({
    String? name,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _name = name,
        super(firestoreUtilData);

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;
  bool hasName() => _name != null;

  static PlacesStruct fromMap(Map<String, dynamic> data) => PlacesStruct(
        name: data['name'] as String?,
      );

  static PlacesStruct? maybeFromMap(dynamic data) =>
      data is Map ? PlacesStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'name': _name,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
      }.withoutNulls;

  static PlacesStruct fromSerializableMap(Map<String, dynamic> data) =>
      PlacesStruct(
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'PlacesStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is PlacesStruct && name == other.name;
  }

  @override
  int get hashCode => const ListEquality().hash([name]);
}

PlacesStruct createPlacesStruct({
  String? name,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    PlacesStruct(
      name: name,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

PlacesStruct? updatePlacesStruct(
  PlacesStruct? places, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    places
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addPlacesStructData(
  Map<String, dynamic> firestoreData,
  PlacesStruct? places,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (places == null) {
    return;
  }
  if (places.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && places.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final placesData = getPlacesFirestoreData(places, forFieldValue);
  final nestedData = placesData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = places.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getPlacesFirestoreData(
  PlacesStruct? places, [
  bool forFieldValue = false,
]) {
  if (places == null) {
    return {};
  }
  final firestoreData = mapToFirestore(places.toMap());

  // Add any Firestore field values
  places.firestoreUtilData.fieldValues.forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getPlacesListFirestoreData(
  List<PlacesStruct>? placess,
) =>
    placess?.map((e) => getPlacesFirestoreData(e, true)).toList() ?? [];

import 'dart:convert';

import 'package:dio/dio.dart';

class JsonUtils {
  static Map<String, dynamic> getMap(dynamic data) {
    try {
      if (data != null) {
        if (data is ResponseBody) return {'value': data.statusMessage};
        if (data is Map) return data as Map<String, dynamic>;
        final decoded = jsonDecode(data.toString());
        if (decoded is Map) return decoded as Map<String, dynamic>;
        return {'value': decoded};
      }
    } catch (e) {
      print('JsonUtils: ${e.toString()}');
    }
    return {};
  }

  static List<Map<String, dynamic>> getMapList(dynamic data) {
    final List<Map<String, dynamic>> mapList = [];
    if (data == null) return mapList;

    try {
      if (data is! List) {
        data = jsonDecode(data.toString())["results"] as List<dynamic>;
      }
      data.forEach((data) {
        final element = getMap(data);
        mapList.add(element);
      });
    } catch (e) {
      print('JsonUtils: ${e.toString()}');
    }

    return mapList;
  }

  static Map<String, dynamic> parseJsonFromFirebase(dynamic data) {
    final Map<String, dynamic> map = {};
    if (data == null || data.isEmpty) {
      return map;
    } else {
      try {
        List<dynamic> documents = [];

        if (getMap(data).containsKey('documents')) {
          documents = getMap(data)['documents'];
          List<Map<String, dynamic>> jsonParsed = [];
          for (var document in documents) {
            final json = extractMapData(mapData: document);
            if (json != null) {
              jsonParsed.add(json);
            }
          }
          map.addAll({'results': jsonParsed});
        } else {
          final json = extractMapData(mapData: getMap(data));
          if (json != null) {
            map.addAll(json);
          }
        }
      } catch (e) {
        print('parseJsonFromFirebase error: ${e.toString()}');
      }
      return map;
    }
  }

  static Map<String, dynamic>? extractMapData({required Map mapData}) {
    if (mapData['fields'] != null) {
      final fields = mapData['fields'] as Map;

      final parsedMap = <String, dynamic>{};

      for (var entry in fields.entries) {
        final parsedEntryValue = parseToJson(entry.value);
        parsedMap[entry.key] = parsedEntryValue;
      }

      return parsedMap;
    } else {
      return null;
    }
  }

  static dynamic parseToJson(Map values) {
    for (var entry in values.entries) {
      final key = entry.key;
      if (key == 'integerValue') {
        return entry.value is int ? entry.value : int.parse(entry.value);
      } else if (key == 'stringValue' ||
          key == 'doubleValue' ||
          key == 'timestampValue' ||
          key == 'booleanValue' ||
          key == 'geoPointValue' ||
          key == 'referenceValue') {
        return entry.value;
      } else if (key == 'arrayValue') {
        return extractArrayData(entry.value);
      } else if (key == 'mapValue') {
        return extractMapData(mapData: entry.value);
      } else if (key == 'nullValue') {
        return null;
      } else {
        throw Exception(
            'Cannot convert this value to a json readable format. That sound like this value type $key is not supported by firestore.\nReceived data is $values');
      }
    }
  }

  static List<dynamic> extractArrayData(Map arrayData) {
    if (arrayData['values'] != null) {
      final values = arrayData['values'] as List;

      final parsedArray = <dynamic>[];

      for (var value in values) {
        final parsedValue = parseToJson(value);

        parsedArray.add(parsedValue);
      }

      return parsedArray;
    } else {
      return [];
    }
  }
}

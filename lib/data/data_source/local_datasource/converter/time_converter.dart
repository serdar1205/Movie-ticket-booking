import 'package:floor/floor.dart';
import 'dart:convert';

class DateTimeConverter extends TypeConverter<DateTime?, String?> {
  @override
  DateTime? decode(String? databaseValue) {
    if (databaseValue == null) {
      return null;
    }
    return DateTime.parse(databaseValue);
  }

  @override
  String? encode(DateTime? value) {
    if (value == null) {
      return null;
    }
    return value.toIso8601String();
  }
}

import 'package:floor/floor.dart';

@Entity(tableName: 'films', primaryKeys: ['id'])

class FilmModel {
  String? id;
  String? title;
  String? image;
  String? description;
  int? count;
  String? startTime;
  String? startHour;

  FilmModel({
    required this.id,
    required this.title,
    required this.image,
    required this.description,
    required this.count,
    required this.startTime,
    required this.startHour,
  });

  //
  // String? get formattedDate {
  //   return startTime != null ? DateFormat('dd.MM.yyyy').format(startTime!) : 'Sene saylan';
  // }
  @override
  String toString() {
    return 'FilmModel{id: $id, title: $title, image: $image, description: $description, count: $count, startDate: $startTime, hour: $startHour}';
  }
}

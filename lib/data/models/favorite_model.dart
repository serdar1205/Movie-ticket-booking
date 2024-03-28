import 'package:floor/floor.dart';

@Entity(tableName: 'favorites', primaryKeys: ['id'])

class FavoriteModel{
  String? id;
  String? title;
  String? image;
  String? description;
  int? count;
  String? startTime;
  String? startHour;

  FavoriteModel({
    required this.id,
    required this.title,
    required this.image,
    required this.description,
    required this.count,
    required this.startTime,
    required this.startHour,
  });


  @override
  String toString() {
    return 'FavoriteModel{id: $id, title: $title, image: $image, description: $description, count: $count, startDate: $startTime, hour: $startHour}';
  }
}

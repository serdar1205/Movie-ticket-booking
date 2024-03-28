

class MainModel {
  String? id;
  String? title;
  String? image;
  String? description;
  int? count;
  String? startDate;
  String? startHour;

  MainModel({
    required this.id,
    required this.title,
    required this.image,
    required this.description,
    required this.count,
    required this.startDate,
    required this.startHour,
  });

  @override
  String toString() {
    return 'FilmModel{id: $id, title: $title, image: $image, description: $description, count: $count, startDate: $startDate, hour: $startHour}';
  }
}

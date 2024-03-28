import 'package:floor/floor.dart';

@Entity(tableName: 'ordered_tickets', primaryKeys: ['id'])

class TicketOrderModel {
  String id;

  String filmTitle;
  String name;
  String phoneNumber;
  int ticketCount;

  TicketOrderModel({
    required this.id,
   required this.filmTitle,
    required this.name,
    required this.phoneNumber,
    required this.ticketCount,
  });

  @override
  String toString() {
    return 'TicketOrderModel{id: $id, filmTitle: $filmTitle, name: $name, phoneNumber: $phoneNumber, ticketCount: $ticketCount}';
  }
}

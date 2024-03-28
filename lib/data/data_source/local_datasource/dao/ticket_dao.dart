import 'package:floor/floor.dart';

import '../../../models/ticket_order_model.dart';

@dao
abstract class TicketDao{
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertTicket(TicketOrderModel ticketOrderModel);
  @Query('SELECT * FROM ordered_tickets')
  Future<List<TicketOrderModel>> getAllTickets();

  @Query('DELETE FROM ordered_tickets')
  Future<void> deleteAllTickets();
}
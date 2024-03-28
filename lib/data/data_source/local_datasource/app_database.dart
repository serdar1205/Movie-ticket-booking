import 'dart:async';
import 'package:floor/floor.dart';
import 'package:movies/data/models/film_model.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import '../../models/favorite_model.dart';
import '../../models/ticket_order_model.dart';
import 'converter/time_converter.dart';
import 'dao/favorite_dao.dart';
import 'dao/film_dao.dart';
import 'dao/ticket_dao.dart';

part 'app_database.g.dart';

@TypeConverters([DateTimeConverter])
@Database(version: 1, entities: [FilmModel,TicketOrderModel,FavoriteModel])
abstract class AppDatabase extends FloorDatabase {
  FilmDao get filmDao;
  TicketDao get ticketDao;
  FavoriteDao get favoriteDao;
}

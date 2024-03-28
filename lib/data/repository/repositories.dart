import 'package:movies/core/error/failure.dart';
import 'package:movies/data/models/film_model.dart';
import 'package:movies/data/models/ticket_order_model.dart';
import '../data_source/local_datasource/app_database.dart';
import '../models/favorite_model.dart';

class FilmRepository {
  AppDatabase appDatabase;

  FilmRepository({required this.appDatabase});

  Future<void> insertFilm(FilmModel mainModel) {
    try {
      return appDatabase.filmDao.insertFilm(mainModel);
    } catch (e) {
      throw DatabaseException(message: 'Failed insertFilm in film table: $e');
    }
  }

  Future<List<FilmModel>> getAllFilms() {
    try {
      return appDatabase.filmDao.getAllFilms();
    } catch (e) {
      throw DatabaseException(message: 'Failed getAllFilms in film table: $e');
    }
  }

  Future<FilmModel?> getById(String title) {
    try {
      return appDatabase.filmDao.getById(title);
    } catch (e) {
      throw DatabaseException(message: 'Failed getById in film table: $e');
    }
  }

  Future<void> updateFilmData(FilmModel mainModel) {
    try {
      return appDatabase.filmDao.updateFilmData(
        mainModel.id!,
        mainModel.title!,
        mainModel.image!,
        mainModel.description!,
        mainModel.count!,
        mainModel.startTime!,
        mainModel.startHour!,
      );
    } catch (e) {
      throw DatabaseException(message: 'Failed updateFilmData in film table: $e');
    }
  }

  Future<void> updateTotalTickets(String filmId, int orderedTicketsCount) {
    try {
      return appDatabase.filmDao
          .updateTotalTickets(filmId, orderedTicketsCount);
    } catch (e) {
      throw DatabaseException(message: 'Failed updateTotalTickets in film table: $e');
    }
  }

  Future<void> deleteFilm(FilmModel mainModel) {
    try {
      return appDatabase.filmDao.deleteFilm(mainModel.title!);
    } catch (e) {
      throw DatabaseException(message: 'Failed deleteFilm in film table: $e');
    }
  }

  ///ticket
  Future<void> insertTicketOrder(TicketOrderModel ticketOrderModel) {
    try {
      return appDatabase.ticketDao.insertTicket(ticketOrderModel);
    } catch (e) {
      throw DatabaseException(message: 'Failed insertTicketOrder in order_ticket table: $e');
    }
  }

  Future<List<TicketOrderModel>> getAllTickets() {
    try {
      return appDatabase.ticketDao.getAllTickets();
    } catch (e) {
      throw DatabaseException(message: 'Failed getAllTickets in order_ticket table: $e');
    }
  }

  Future<void> deleteAllTickets() {
    try {
      return appDatabase.ticketDao.deleteAllTickets();
    } catch (e) {
      throw DatabaseException(message: 'Failed deleteAllTickets in order_ticket table: $e');
    }
  }

  ///like
  Future<void> addToFavorites(FavoriteModel favoriteModel) {
    try {
      return appDatabase.favoriteDao.addToFavorites(favoriteModel);
    } catch (e) {
      throw DatabaseException(message: 'Failed addToFavorites in favorites table: $e');
    }
  }

  Future<FavoriteModel?> getFavoriteById(String id) {
    try {
      return appDatabase.favoriteDao.getById(id);
    } catch (e) {
      throw DatabaseException(message: 'Failed getFavoriteById in favorites table: $e');
    }
  }

  Future<List<FavoriteModel>> getAllFavorites() {
    try {
      return appDatabase.favoriteDao.getAllFavorites();
    } catch (e) {
      throw DatabaseException(message: 'Failed getAllFavorites in favorites table: $e');
    }
  }

  Future<void> removeFromFavorites(String id) {
    try {
      return appDatabase.favoriteDao.removeFromFavorites(id);
    } catch (e) {
      throw DatabaseException(message: 'Failed removeFromFavorites in favorites table: $e');
    }
  }

  Future<void> updateFavoriteTotalTickets(
      String filmId, int orderedTicketsCount) {
    try {
      return appDatabase.favoriteDao
          .updateTotalTickets(filmId, orderedTicketsCount);
    } catch (e) {
      throw DatabaseException(message: 'Failed updateFavoriteTotalTickets in favorites table: $e');
    }
  }
}

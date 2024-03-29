import 'package:flutter/material.dart';
import 'package:movies/data/models/favorite_model.dart';
import '../../core/error/failure.dart';
import '../../data/models/ticket_order_model.dart';
import '../../data/repository/repositories.dart';
import '../../di.dart';

class AppController with ChangeNotifier {
  AppController._internal();
  static final AppController instance =
  AppController._internal();

  factory AppController() => instance;

  FilmRepository repository = locator<FilmRepository>();
  List<TicketOrderModel> orderedTickets = [];
  List<FavoriteModel> favorites = [];
  FavoriteModel? favoriteModel;

  Future<void> addTicketToDb(TicketOrderModel model) async {
    try {
      await repository.insertTicketOrder(model);
      getAllTickets();
    } catch (e) {
      DatabaseFailure(message: 'Error adding ticket in controller: $e');
    }
  }

  Future<void> getAllTickets() async {
    try {
      orderedTickets = await locator<FilmRepository>().getAllTickets();
      notifyListeners();
    } catch (e) {
      DatabaseFailure(message: 'Error fetching ticket in controller: $e');
    }
  }

  Future<void> updateTotalTickets(
      String filmId, int orderedTicketsCount) async {
    try {
      await repository.updateTotalTickets(filmId, orderedTicketsCount);
    } catch (e) {
    DatabaseException(message: 'Error update total ticket in controller: $e');
    }
  }

  Future<void> getAllFavorites() async {
    try {
      favorites = await repository.getAllFavorites();
      notifyListeners();
    } catch (e) {
      DatabaseFailure(message: 'Error fetching favorites in controller: $e');
    }
  }

  Future<void> deleteAllTickets() async {
    try {
      return await repository
          .deleteAllTickets()
          .then((value) {
            favorites.clear();
            getAllTickets();
          });

    } catch (e) {
      DatabaseFailure(message: 'Error delete tickets in controller: $e');
    }
  }

  Future<void> addToFavorites(FavoriteModel favoriteModel) {
    try {
      return repository.addToFavorites(favoriteModel);
    } catch (e) {
      throw DatabaseFailure(message: 'Error adding favorite in controller: $e');
    }
  }

  Future<void> removeFromFavorites(String id) {
    try {
      return repository
          .removeFromFavorites(id)
          .then((value) => getAllFavorites());
    } catch (e) {
      throw DatabaseFailure(
          message: 'Error remove from favorites in controller: $e');
    }
  }

  Future<void> updateFavoriteTotalTickets(
    String filmId,
    int orderedTicketsCount,
  ) async {
    try {
      await repository.updateFavoriteTotalTickets(
        filmId,
        orderedTicketsCount,
      );
    } catch (e) {
      DatabaseFailure(
          message: 'Error update favorite total tickets in controller: $e');
    }
  }

  Future<bool> isFavorite(String id) async {
    try {
      final favorite = await repository.getFavoriteById(id);
      return favorite != null;
    } catch (e) {
      throw DatabaseFailure(
          message: 'Error checking is favorited in controller: $e');
    }
  }
}

import 'package:flutter/material.dart';
import 'package:movies/data/models/favorite_model.dart';

import '../../data/models/ticket_order_model.dart';
import '../../data/repository/repositories.dart';
import '../../di.dart';

class AppController with ChangeNotifier {
  List<TicketOrderModel> orderedTickets = [];
  List<FavoriteModel> favorites = [];
  FavoriteModel? favoriteModel;

  Future<void> addTicketToDb(TicketOrderModel model) async {
    try {
      await locator<FilmRepository>().insertTicketOrder(model);
      getAllTickets();
    } catch (e) {
      print('Error adding ticket: $e');
    }
  }

  Future<void> getAllTickets() async {
    try {
      orderedTickets = await locator<FilmRepository>().getAllTickets();
      notifyListeners();
    } catch (e) {
      print('Error fetching tickets: $e');
    }
  }

  Future<void> updateTotalTickets(
      String filmId, int orderedTicketsCount) async {
    await locator<FilmRepository>()
        .updateTotalTickets(filmId, orderedTicketsCount);
  }

  Future<void> getAllFavorites() async {
    try {
      print("get");
      favorites = await locator<FilmRepository>().getAllFavorites();
      print(favorites.length);
      notifyListeners();
    } catch (e) {
      print('Error fetching tickets: $e');
    }
  }

  Future<void> deleteAllTickets() async {
    return await locator<FilmRepository>()
        .deleteAllTickets()
        .then((value) => favorites.clear());
  }

  Future<void> addToFavorites(FavoriteModel favoriteModel) {
    return locator<FilmRepository>().addToFavorites(favoriteModel);
  }

  Future<void> removeFromFavorites(String id) {
    return locator<FilmRepository>()
        .removeFromFavorites(id)
        .then((value) => getAllFavorites());
  }

  Future<void> updateFavoriteTotalTickets(
    String filmId,
    int orderedTicketsCount,
  ) async {
    await locator<FilmRepository>().updateFavoriteTotalTickets(
      filmId,
      orderedTicketsCount,
    );
  }

  Future<bool> isFavorite(String id) async {
    final favorite = await locator<FilmRepository>().getFavoriteById(id);
    return favorite != null;
  }
}

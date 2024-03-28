import 'package:floor/floor.dart';
import 'package:movies/data/models/favorite_model.dart';

@dao
abstract class FavoriteDao {
  @Insert(onConflict: OnConflictStrategy.ignore)
  Future<void> addToFavorites(FavoriteModel favoriteModel);

  @Query('SELECT * FROM favorites')
  Future<List<FavoriteModel>> getAllFavorites();

  @Query('SELECT * FROM favorites WHERE id=:id LIMIT 1')
  Future<FavoriteModel?> getById(String id);

  @Query('DELETE FROM favorites WHERE id = :id')
  Future<void> removeFromFavorites(String id);

  @Query('UPDATE favorites SET count = count - :orderedTicketsCount WHERE id = :filmId')
  Future<void> updateTotalTickets(String filmId, int orderedTicketsCount);
}

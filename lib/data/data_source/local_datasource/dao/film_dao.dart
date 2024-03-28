import 'package:floor/floor.dart';
import 'package:movies/data/models/film_model.dart';
import 'package:movies/data/models/ticket_order_model.dart';

@dao
abstract class FilmDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertFilm(FilmModel filmModel);

  @Query('SELECT * FROM films')
  Future<List<FilmModel>> getAllFilms();

  @Query('SELECT * FROM films WHERE title=:title LIMIT 1')
  Future<FilmModel?> getById(String title);

  // @update
  // Future<void> updateFilmData(FilmModel filmModel);

  @Query(
      "UPDATE films SET title=:title, image=:image, description=:description,count=:count, startTime=:startTime, startHour=:startHour WHERE id=:id")
  Future<void> updateFilmData(
    String id,
    String title,
    String image,
    String description,
    int count,
    String startTime,
    String startHour,
  );

//UPDATE films SET title="Hello", image=image, description="Desc",count=10, startTime="" WHERE id="6e153784-c735-4096-987a-c9b5ccd515a7";
  @Query("DELETE FROM films WHERE title=:title")
  Future<void> deleteFilm(String title);

  @Query('UPDATE films SET count = count - :orderedTicketsCount WHERE id = :filmId')
  Future<void> updateTotalTickets(String filmId, int orderedTicketsCount);
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  FilmDao? _filmDaoInstance;

  TicketDao? _ticketDaoInstance;

  FavoriteDao? _favoriteDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `films` (`id` TEXT, `title` TEXT, `image` TEXT, `description` TEXT, `count` INTEGER, `startTime` TEXT, `startHour` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ordered_tickets` (`id` TEXT NOT NULL, `filmTitle` TEXT NOT NULL, `name` TEXT NOT NULL, `phoneNumber` TEXT NOT NULL, `ticketCount` INTEGER NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `favorites` (`id` TEXT, `title` TEXT, `image` TEXT, `description` TEXT, `count` INTEGER, `startTime` TEXT, `startHour` TEXT, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  FilmDao get filmDao {
    return _filmDaoInstance ??= _$FilmDao(database, changeListener);
  }

  @override
  TicketDao get ticketDao {
    return _ticketDaoInstance ??= _$TicketDao(database, changeListener);
  }

  @override
  FavoriteDao get favoriteDao {
    return _favoriteDaoInstance ??= _$FavoriteDao(database, changeListener);
  }
}

class _$FilmDao extends FilmDao {
  _$FilmDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _filmModelInsertionAdapter = InsertionAdapter(
            database,
            'films',
            (FilmModel item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'image': item.image,
                  'description': item.description,
                  'count': item.count,
                  'startTime': item.startTime,
                  'startHour': item.startHour
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<FilmModel> _filmModelInsertionAdapter;

  @override
  Future<List<FilmModel>> getAllFilms() async {
    return _queryAdapter.queryList('SELECT * FROM films',
        mapper: (Map<String, Object?> row) => FilmModel(
            id: row['id'] as String?,
            title: row['title'] as String?,
            image: row['image'] as String?,
            description: row['description'] as String?,
            count: row['count'] as int?,
            startTime: row['startTime'] as String?,
            startHour: row['startHour'] as String?));
  }

  @override
  Future<FilmModel?> getById(String title) async {
    return _queryAdapter.query('SELECT * FROM films WHERE title=?1 LIMIT 1',
        mapper: (Map<String, Object?> row) => FilmModel(
            id: row['id'] as String?,
            title: row['title'] as String?,
            image: row['image'] as String?,
            description: row['description'] as String?,
            count: row['count'] as int?,
            startTime: row['startTime'] as String?,
            startHour: row['startHour'] as String?),
        arguments: [title]);
  }

  @override
  Future<void> updateFilmData(
    String id,
    String title,
    String image,
    String description,
    int count,
    String startTime,
    String startHour,
  ) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE films SET title=?2, image=?3, description=?4,count=?5, startTime=?6, startHour=?7 WHERE id=?1',
        arguments: [
          id,
          title,
          image,
          description,
          count,
          startTime,
          startHour
        ]);
  }

  @override
  Future<void> deleteFilm(String title) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM films WHERE title=?1', arguments: [title]);
  }

  @override
  Future<void> updateTotalTickets(
    String filmId,
    int orderedTicketsCount,
  ) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE films SET count = count - ?2 WHERE id = ?1',
        arguments: [filmId, orderedTicketsCount]);
  }

  @override
  Future<void> insertFilm(FilmModel filmModel) async {
    await _filmModelInsertionAdapter.insert(
        filmModel, OnConflictStrategy.replace);
  }
}

class _$TicketDao extends TicketDao {
  _$TicketDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _ticketOrderModelInsertionAdapter = InsertionAdapter(
            database,
            'ordered_tickets',
            (TicketOrderModel item) => <String, Object?>{
                  'id': item.id,
                  'filmTitle': item.filmTitle,
                  'name': item.name,
                  'phoneNumber': item.phoneNumber,
                  'ticketCount': item.ticketCount
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<TicketOrderModel> _ticketOrderModelInsertionAdapter;

  @override
  Future<List<TicketOrderModel>> getAllTickets() async {
    return _queryAdapter.queryList('SELECT * FROM ordered_tickets',
        mapper: (Map<String, Object?> row) => TicketOrderModel(
            id: row['id'] as String,
            filmTitle: row['filmTitle'] as String,
            name: row['name'] as String,
            phoneNumber: row['phoneNumber'] as String,
            ticketCount: row['ticketCount'] as int));
  }

  @override
  Future<void> deleteAllTickets() async {
    await _queryAdapter.queryNoReturn('DELETE FROM ordered_tickets');
  }

  @override
  Future<void> insertTicket(TicketOrderModel ticketOrderModel) async {
    await _ticketOrderModelInsertionAdapter.insert(
        ticketOrderModel, OnConflictStrategy.replace);
  }
}

class _$FavoriteDao extends FavoriteDao {
  _$FavoriteDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _favoriteModelInsertionAdapter = InsertionAdapter(
            database,
            'favorites',
            (FavoriteModel item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'image': item.image,
                  'description': item.description,
                  'count': item.count,
                  'startTime': item.startTime,
                  'startHour': item.startHour
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<FavoriteModel> _favoriteModelInsertionAdapter;

  @override
  Future<List<FavoriteModel>> getAllFavorites() async {
    return _queryAdapter.queryList('SELECT * FROM favorites',
        mapper: (Map<String, Object?> row) => FavoriteModel(
            id: row['id'] as String?,
            title: row['title'] as String?,
            image: row['image'] as String?,
            description: row['description'] as String?,
            count: row['count'] as int?,
            startTime: row['startTime'] as String?,
            startHour: row['startHour'] as String?));
  }

  @override
  Future<FavoriteModel?> getById(String id) async {
    return _queryAdapter.query('SELECT * FROM favorites WHERE id=?1 LIMIT 1',
        mapper: (Map<String, Object?> row) => FavoriteModel(
            id: row['id'] as String?,
            title: row['title'] as String?,
            image: row['image'] as String?,
            description: row['description'] as String?,
            count: row['count'] as int?,
            startTime: row['startTime'] as String?,
            startHour: row['startHour'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> removeFromFavorites(String id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM favorites WHERE id = ?1', arguments: [id]);
  }

  @override
  Future<void> updateTotalTickets(
    String filmId,
    int orderedTicketsCount,
  ) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE favorites SET count = count - ?2 WHERE id = ?1',
        arguments: [filmId, orderedTicketsCount]);
  }

  @override
  Future<void> addToFavorites(FavoriteModel favoriteModel) async {
    await _favoriteModelInsertionAdapter.insert(
        favoriteModel, OnConflictStrategy.ignore);
  }
}

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();

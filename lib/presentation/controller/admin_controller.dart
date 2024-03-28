import 'dart:io';
import 'package:flutter/material.dart';
import 'package:movies/core/error/failure.dart';
import 'package:movies/data/models/film_model.dart';
import 'package:movies/data/repository/repositories.dart';
import 'package:movies/di.dart';
import '../../core/utilities/global_data.dart';

class AdminController with ChangeNotifier {
  FilmRepository repository = locator<FilmRepository>();
  AdminController() {
    getAllFilms();
  }

  List<FilmModel> films = [];

  File? pickedImage;
  FilmModel? filmModel;
  String? filmTitle;
  String? filmDescription;
  int? biletSany;
  String? selectedDate;
  String? hour;

  setTitle(String title) {
    filmTitle = title;
    notifyListeners();
  }

  setHour(String startingHour) {
    hour = startingHour;
    notifyListeners();
  }

  setDescription(String description) {
    filmDescription = description;
    notifyListeners();
  }

  setCount(int count) {
    biletSany = count;
    notifyListeners();
  }

  setImage(File image) {
    pickedImage = image;
    notifyListeners();
  }

  clearImage() {
    pickedImage = null;
    notifyListeners();
  }

  Future<void> getAllFilms() async {
    try {
      films = await repository.getAllFilms();
      notifyListeners();
    } catch (e) {
      DatabaseFailure(message: 'Error fetching films in controller: $e');
    }
  }

  addFilm() {
    filmModel = FilmModel(
        id: uuid.v4(),
        title: filmTitle,
        image: pickedImage!.path,
        description: filmDescription,
        count: biletSany,
        startTime: selectedDate,
        startHour: hour);
    notifyListeners();
    addFilmToDb(filmModel!);
  }

  Future<void> addFilmToDb(FilmModel model) async {
    try {
      await repository.insertFilm(model);
      await getAllFilms();
    } catch (e) {
      DatabaseFailure(message: 'Error adding film in controller: $e');
    }
  }

  Future<void> removeFilm(FilmModel model) async {
    try {
      await repository.deleteFilm(model);
      films.remove(model);
      notifyListeners();
    } catch (e) {
      DatabaseFailure(message: 'Error removing film in controller: $e');
    }
  }

  Future<void> updateFilm(FilmModel model) async {
    try {
      await repository.updateFilmData(model);
      notifyListeners();
    } catch (e) {
      DatabaseFailure(message: 'Error update film in controller: $e');
    }
  }

  Future<FilmModel?> getById(String title) {
    try {
      return repository.getById(title);
    } catch (e) {
      throw DatabaseFailure(message: 'Error get film by id in controller: $e');
    }
  }
}

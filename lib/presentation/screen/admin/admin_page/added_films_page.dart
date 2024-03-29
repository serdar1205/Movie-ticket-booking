import 'package:flutter/material.dart';
import 'package:movies/core/constants/sizes/app_text_size.dart';
import 'package:movies/di.dart';
import '../../../controller/admin_controller.dart';
import '../../../widgets/cards/added_films_card.dart';
import '../../../widgets/models/main_card_model.dart';
import '../edit_page/edit_page.dart';

class AddedFilmsPage extends StatefulWidget {
  const AddedFilmsPage({super.key});

  @override
  State<AddedFilmsPage> createState() => _AddedFilmsPageState();
}

class _AddedFilmsPageState extends State<AddedFilmsPage> {
  var controller = locator<AdminController>();

  @override
  void initState() {
    super.initState();
    controller.getAllFilms();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, child) {
        if (controller.films.isEmpty) {
          return Center(
            child: BigText(
              'Kino gosulmadyk',
              context: context,
            ),
          );
        }
        return ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: controller.films.length,
          itemBuilder: (BuildContext context, int index) {
            var data = controller.films[index];
            return Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                child: AddedFilmsCard(
                  model: MainModel(
                    id: data.id,
                    title: data.title,
                    image: data.image,
                    description: data.description,
                    count: data.count,
                    startDate: data.startTime,
                    startHour: data.startHour,
                  ),
                  onRemove: () {
                    controller.removeFilm(controller.films[index]);
                  },
                  onEdit: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EditFilmPage(
                              film: controller.films[index],
                              onChange: () {
                                controller.getAllFilms();
                              },
                            )));
                  },
                  onChange: () {
                    controller.getAllFilms();
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}

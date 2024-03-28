import 'package:flutter/material.dart';
import 'package:movies/di.dart';
import 'package:movies/presentation/controller/admin_controller.dart';
import 'package:movies/presentation/controller/app_contoller.dart';
import 'package:movies/presentation/widgets/models/main_card_model.dart';

import '../../../core/constants/sizes/app_text_size.dart';
import '../../widgets/cards/main_card_widget.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  var controller = locator<AppController>();

  @override
  void initState() {
    super.initState();
    controller.getAllFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: controller,
        builder: (context, child) {
          if (controller.favorites.isEmpty) {
            return Center(
              child: BigText(
                'Halanlarym bos',
                context: context,
              ),
            );
          }
          return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: controller.favorites.length,
            // physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              var data = controller.favorites[index];
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                  child: MainCard(
                    onChange: () {
                      controller.getAllFavorites();
                    },
                    model: MainModel(
                        id: data.id,
                        title: data.title,
                        image: data.image,
                        description: data.description,
                        count: data.count,
                        startDate: data.startTime,
                        startHour: data.startHour,
                    ),

                  ),
                ),
              );
            },
          );
        });
  }

}

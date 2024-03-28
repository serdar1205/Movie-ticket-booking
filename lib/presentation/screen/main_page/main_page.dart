import 'package:flutter/material.dart';

import '../../../core/constants/sizes/app_text_size.dart';
import '../../../di.dart';
import '../../controller/admin_controller.dart';
import '../../widgets/cards/main_card_widget.dart';
import '../../widgets/models/main_card_model.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

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
        builder: (context,child){
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
        itemCount:  controller.films.length,
        itemBuilder: (BuildContext context, int index) {
          var data = controller.films[index];
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 5),
            child: Padding(
              padding:  const EdgeInsets.symmetric(
                  horizontal: 5.0, vertical: 5.0),
              child: MainCard(
                onChange: () {
                  controller.getAllFilms();
                },
                model: MainModel(
                  id: data.id,
                  title: data.title,
                  image: data.image,
                  description: data.description,
                  count: data.count,
                  startDate: data.startTime,
                  startHour: data.startHour,
              ),),
            ),
          );
        },
      );
    });
  }

}

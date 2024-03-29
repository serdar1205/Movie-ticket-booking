import 'package:flutter/material.dart';
import 'package:movies/presentation/controller/app_contoller.dart';

import '../../../core/constants/sizes/app_text_size.dart';
import '../../../di.dart';
import '../../widgets/cards/history_card.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key,});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  var controller = locator<AppController>();

  @override
  void initState() {
    super.initState();
    controller.getAllTickets();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: controller, builder: (context, child) {

      if (controller.orderedTickets.isEmpty) {
        return Center(
          child: BigText(
            'Bilet zakaz edilmedi',
            context: context,
          ),
        );
      }
      return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: controller.orderedTickets.length,
        // physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child:  Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 5.0, vertical: 5.0),
              child: HistoryCard(model: controller.orderedTickets[index],),
            ),
          );
        },
      );
    });
  }
}

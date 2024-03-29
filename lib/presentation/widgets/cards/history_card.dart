import 'package:flutter/material.dart';
import '../../../core/constants/sizes/app_text_size.dart';
import '../../../data/models/ticket_order_model.dart';

class HistoryCard extends StatelessWidget {
  const HistoryCard({super.key, required this.model});

  final TicketOrderModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 4),
      height: 85,
      //width: MediaQuery.of(context).size.width - 25,
      decoration: BoxDecoration(
        //  border: Border.all(color: searchGaranty),
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).cardColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 2 + 40,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                MediumText(
                  '${model.ticketCount} bilet',
                  context: context,
                ),
                const SizedBox(height: 10),
                SizedBox(
                  //height: 25,
                  child: MediumText(
                    model.filmTitle,
                    context: context,
                    maxLine: 1,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              MediumText(
                model.name,
                context: context,
              ),
              const SizedBox(height: 10),
              MediumText(
                model.phoneNumber,
                context: context,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../core/constants/sizes/app_text_size.dart';
import '../k_textfield.dart';

class TicketOrderDialogWidget extends StatelessWidget {
  final TextEditingController nameCtrl;
  final TextEditingController phoneNumberCtrl;
  final TextEditingController ticketCtrl;
  final GlobalKey<FormState> formKey;
  final void Function() getTicket;

  const TicketOrderDialogWidget({
    Key? key,
    required this.nameCtrl,
    required this.phoneNumberCtrl,
    required this.ticketCtrl,
    required this.formKey,
    required this.getTicket,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return       AlertDialog(
      backgroundColor: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      //backgroundColor: AppColors.cardColor3,
      elevation: 8,
      title: MediumText(
        'Maglumat girizin',
        context: context,
      ),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            KTextField(
              controller: nameCtrl,
              isSubmitted: false,
              keyboardType: TextInputType.name,
              labelText: 'Adynyzy, familiyanyzy girizin',
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'Doldurmaly';
                } else if (val.length < 3) {
                  return '3 den kop bolmaly';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            PhoneNumField(
              phoneCtrl: phoneNumberCtrl,
              isSubmitted: false,
              label: 'Telefon nomerinizi girizin',
            ),
            const SizedBox(height: 10),
            KTextField(
              controller: ticketCtrl,
              isSubmitted: false,
              keyboardType: TextInputType.number,
              labelText: 'Bilet sanyny girizin',
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'Doldurmaly';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: MediumText(
                'Yza',
                context: context,
              ),
            ),
            TextButton(
              onPressed: getTicket,
              child: MediumText(
                'Ugratmak',
                context: context,
              ),
            ),
          ],
        )
      ],
    );
  }
}

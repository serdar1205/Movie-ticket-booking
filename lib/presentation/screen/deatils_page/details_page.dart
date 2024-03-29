import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movies/data/models/ticket_order_model.dart';
import 'package:movies/presentation/controller/app_contoller.dart';
import 'package:movies/presentation/widgets/buttons/main_button.dart';
import 'package:movies/presentation/widgets/toasts/custom_toast.dart';
import '../../../core/constants/sizes/app_text_size.dart';
import '../../../core/utilities/global_data.dart';
import '../../../di.dart';
import '../../widgets/buttons/back_button.dart';
import '../../widgets/dialogs/order_ticket_dialog.dart';
import '../splash_screen/splash.dart';
import '../../controller/admin_controller.dart';
import '../../widgets/models/main_card_model.dart';
import '../../widgets/pictures/pictures.dart';

// ignore: must_be_immutable
class DetailsPage extends StatefulWidget {
  final Function() onChange;

  DetailsPage({
    super.key,
    required this.model,
    required this.onChange,
  });

  MainModel model;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController phoneNumberCtrl = TextEditingController();
  TextEditingController ticketCtrl = TextEditingController();
  AdminController adminController = locator<AdminController>();
  AppController appController = locator<AppController>();

  FToast? fToast = FToast();
  bool isLiked = false;

  int count = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      count = widget.model.count ?? 0;
    });

    ///
    appController.isFavorite(widget.model.id!).then((value) {
      setState(() {
        isLiked = value;
      });
    });

    fToast!.init(context);
  }

  @override
  dispose() {
    nameCtrl.dispose();
    phoneNumberCtrl.dispose();
    ticketCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.85,
                child: SingleChildScrollView(
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SliderCardImage(imageUrl: widget.model.image!),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                VeryBigText(widget.model.title!,
                                    context: context),
                                const SizedBox(height: 20),
                                MediumText(widget.model.description!,
                                    context: context),
                                const SizedBox(height: 20),
                                BigText(
                                    'Baslanyan wagty: ${widget.model.startDate}  ${widget.model.startHour}',
                                    context: context),
                                const SizedBox(height: 20),
                                BigText('Bilet sany: $count', context: context),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const BackToButton(),
                    ],
                  ),
                ),
              ),
              isAdmin
                  ? const SizedBox()
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MainButton(
                        onPressed: () {
                          if (widget.model.count == 0) {
                            _showToast("Biletler gutardy");
                          } else {
                            _showDialog();
                          }
                        },
                        buttonTile: 'Biledi almak',
                        width: size.width - 40,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  getTicket() {
    if (formKey.currentState!.validate()) {
      var tickets = int.parse(ticketCtrl.text);
      var ticketOrderModel = TicketOrderModel(
        id: uuid.v4(),
        filmTitle: widget.model.title!,
        name: nameCtrl.text,
        phoneNumber: phoneNumberCtrl.text,
        ticketCount: tickets,
      );
      if (widget.model.count! >= tickets) {
        appController.addTicketToDb(ticketOrderModel);
        appController.updateTotalTickets(widget.model.id!, tickets);
        clearCtrl();
        _showToast("Bilet alyndy");
        if (isLiked) {
          appController.updateFavoriteTotalTickets(widget.model.id!, tickets);
        }
        setState(() {
          count = count - tickets;
        });
        Navigator.of(context).pop();
        widget.onChange();
      } else {
        _showToast('${widget.model.count!} bilet galdy');
      }
    } else {
      _showToast("Bosluklary dolduryn");
    }
  }

  clearCtrl() {
    nameCtrl.clear();
    phoneNumberCtrl.clear();
    ticketCtrl.clear();
  }

  void _showDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => TicketOrderDialogWidget(
              nameCtrl: nameCtrl,
              phoneNumberCtrl: phoneNumberCtrl,
              ticketCtrl: ticketCtrl,
              formKey: formKey,
              getTicket: getTicket,
            ));
  }

  void _showToast(String text) {
    Widget toast = ToastWidget(text: text);
    fToast!.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 2),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movies/data/models/ticket_order_model.dart';
import 'package:movies/presentation/controller/app_contoller.dart';
import 'package:movies/presentation/widgets/buttons/main_button.dart';
import 'package:movies/presentation/widgets/k_textfield.dart';
import 'package:movies/presentation/widgets/toasts/custom_toast.dart';
import '../../../app.dart';
import '../../../core/constants/colors/app_colors.dart';
import '../../../core/constants/sizes/app_text_size.dart';
import '../../../core/utilities/global_data.dart';
import '../../../data/models/film_model.dart';
import '../../../di.dart';
import '../splash_screen/splash.dart';
import '../../controller/admin_controller.dart';
import '../../widgets/models/main_card_model.dart';
import '../../widgets/pictures/pictures.dart';

// ignore: must_be_immutable
class DetailsPage extends StatefulWidget {
  final Function() onChange;
  DetailsPage({
    super.key,
    required this.model, required this.onChange,
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
  AdminController controller = locator<AdminController>();

  FToast? fToast =  FToast();
  bool isLiked = false;

  int count = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      count = widget.model.count??0;
    });
    controller.getById(widget.model.title!).then((filmData) {
      if (filmData != null) {
        print(filmData);
      } else {
        print('Film data not found');
      }
    }).catchError((error) {
      print('Error fetching film data: $error');
    });

    ///
    locator<AppController>().isFavorite(widget.model.id!).then((value) {
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
                                    'Baslanyan wagty: ${widget.model.startDate} : ${widget.model.startHour}',
                                    context: context),
                                const SizedBox(height: 20),
                                BigText('Bilet sany: $count',
                                    context: context),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 12,
                          left: 16,
                          right: 16,
                        ),
                        child: InkWell(
                          onTap: () {
                            //controller.getAllFilms();
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.whiteLikeColor,
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: AppColors.textDarkColor,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              isAdmin
                  ? SizedBox()
                  : Padding(
                      padding: EdgeInsets.all(8.0),
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
                    )
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
        locator<AppController>().addTicketToDb(ticketOrderModel);
        locator<AppController>().updateTotalTickets(widget.model.id!, tickets);
        clearCtrl();
        _showToast("Bilet alyndy");
        if (isLiked) {
          locator<AppController>()
              .updateFavoriteTotalTickets(widget.model.id!, tickets);
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
      builder: (ctx) => AlertDialog(
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
                keyboardType: TextInputType.name,
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
      ),
    );
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

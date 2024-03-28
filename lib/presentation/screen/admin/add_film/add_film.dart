import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movies/di.dart';
import 'package:movies/presentation/widgets/toasts/custom_toast.dart';
import '../../../controller/admin_controller.dart';
import '../../../widgets/buttons/main_button.dart';
import '../../../widgets/k_textfield.dart';

class AddFilmPage extends StatefulWidget {
  const AddFilmPage({super.key});

  @override
  State<AddFilmPage> createState() => _AddFilmPageState();
}

class _AddFilmPageState extends State<AddFilmPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController titleCtrl = TextEditingController();
  TextEditingController descriptionCtrl = TextEditingController();
  TextEditingController countTCtrl = TextEditingController();
  TextEditingController hourCtrl = TextEditingController();
  TextEditingController minCtrl = TextEditingController();
  ImagePicker picker = locator<ImagePicker>();

  FToast? fToast = FToast();

  AdminController controller = locator<AdminController>();

  @override
  void initState() {
    fToast!.init(context);
    super.initState();
  }

  @override
  dispose() {
    titleCtrl.dispose();
    descriptionCtrl.dispose();
    countTCtrl.dispose();
    hourCtrl.dispose();
    minCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
            child: ListenableBuilder(
          listenable: controller,
          builder: (BuildContext context, Widget? child) {
            return Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 20),
                  GestureDetector(
                      onTap: () {
                        _showPicker(context);
                      },
                      child: _getMediaWidget()),
                  const SizedBox(height: 20),
                  KTextField(
                    controller: titleCtrl,
                    isSubmitted: false,
                    labelText: 'Kinonyn ady',
                    keyboardType: TextInputType.text,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Doldurmaly';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  KTextField(
                    controller: descriptionCtrl,
                    isSubmitted: false,
                    keyboardType: TextInputType.text,
                    labelText: 'Beyany',
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Doldurmaly';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: KTextField(
                          controller: countTCtrl,
                          isSubmitted: false,
                          keyboardType: TextInputType.number,
                          labelText: 'Bilet sany',
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return 'Doldurmaly';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              controller.selectedDate ??
                                  'Sene saýlaň',
                            ),
                            IconButton(
                              onPressed: _presentDatePicker,
                              icon: const Icon(
                                Icons.calendar_month,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: KTextField(
                          controller: hourCtrl,
                          isSubmitted: false,
                          keyboardType: TextInputType.number,
                          maxLength: 2,
                          labelText: 'Sagat',
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return 'Doldurmaly';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: KTextField(
                          controller: minCtrl,
                          isSubmitted: false,
                          keyboardType: TextInputType.number,
                          maxLength: 2,
                          labelText: 'Minut',
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return 'Doldurmaly';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  MainButton(
                    onPressed: addFilmData,
                    buttonTile: 'Goşmak',
                    width: size.width - 40,
                  ),
                ],
              ),
            );
          },
        )),
      ),
    );
  }

  //6512585061
  //1
  void _presentDatePicker() async {
    final now = DateTime.now();
    final lastDate = DateTime(now.year + 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: lastDate,
    );
    String? day = pickedDate?.day.toString();
    String? month = pickedDate?.month.toString();
    String? year = pickedDate?.year.toString();
    setState(() {
      controller.selectedDate =
          pickedDate != null ? '$day.$month.$year' : 'Sene saylan';
    });
  }

  addFilmData() {
    if (formKey.currentState!.validate()) {
      controller.setTitle(titleCtrl.text);
      controller.setDescription(descriptionCtrl.text);
      controller.setCount(int.parse(countTCtrl.text));
      var time = '${hourCtrl.text}:${minCtrl.text}';
      controller.setHour(time);
      controller.addFilm();
      clearCtrl();
      _showToast("Added to cart successfully");
    } else {
      _showToast("Bosluklary dolduryn");
    }
  }

  clearCtrl() {
    titleCtrl.clear();
    descriptionCtrl.clear();
    countTCtrl.clear();
    hourCtrl.clear();
    minCtrl.clear();
    controller.clearImage();
  }

  Widget _getMediaWidget() {
    return SizedBox(
      width: 200,
      height: 300,
      child: controller.pickedImage != null
          ? _imagePickedByUser(controller.pickedImage)
          : Container(
              color: Theme.of(context).cardColor,
              width: 200,
              height: 300,
              child: Icon(
                Icons.camera_alt,
                color: Theme.of(context).textTheme.titleMedium!.color,
              ),
            ),
    );
  }

  Widget _imagePickedByUser(File? image) {
    if (image != null && image.path.isNotEmpty) {
      return Image.file(image);
    } else {
      return Container(
        color: Theme.of(context).cardColor,
        width: 200,
        height: 300,
        child: Icon(
          Icons.camera_alt,
          color: Theme.of(context).textTheme.titleMedium!.color,
        ),
      );
    }
  }

  _showPicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Wrap(
              children: [
                ListTile(
                  trailing: const Icon(Icons.arrow_forward),
                  leading: Icon(
                    Icons.camera,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  title: const Text('Galareyadan saylan'),
                  onTap: () {
                    _imageFormGallery();
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  trailing: const Icon(Icons.arrow_forward),
                  leading: Icon(
                    Icons.camera_alt_rounded,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  title: const Text('Kameradan alyn'),
                  onTap: () {
                    _imageFormCamera();
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          );
        });
  }

  _imageFormGallery() async {
    var image = await picker.pickImage(source: ImageSource.gallery);
    controller.setImage(File(image?.path ?? ""));
  }

  _imageFormCamera() async {
    var image = await picker.pickImage(source: ImageSource.camera);
    controller.setImage(File(image?.path ?? ""));
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

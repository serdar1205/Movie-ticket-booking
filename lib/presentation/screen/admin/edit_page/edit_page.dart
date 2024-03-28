import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movies/data/models/film_model.dart';
import 'package:movies/di.dart';
import '../../../../core/utilities/global_data.dart';
import '../../../controller/admin_controller.dart';
import '../../../widgets/buttons/main_button.dart';
import '../../../widgets/k_textfield.dart';

class EditFilmPage extends StatefulWidget {
  EditFilmPage({super.key, required this.film, required this.onChange});

  //final String title;
  FilmModel film;
  final Function() onChange;

  @override
  State<EditFilmPage> createState() => _EditFilmPageState();
}

class _EditFilmPageState extends State<EditFilmPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController titleCtrl = TextEditingController();
  TextEditingController descriptionCtrl = TextEditingController();
  TextEditingController countTCtrl = TextEditingController();

  TextEditingController hourCtrl = TextEditingController();
  TextEditingController minCtrl = TextEditingController();
  ImagePicker picker = locator<ImagePicker>();
  File? pickedImage;

  FToast? fToast;

  AdminController controller = locator<AdminController>();

  @override
  void initState() {
    super.initState();

    controller.getById(widget.film.title!).then((filmData) {
      if (filmData != null) {
        setState(() {
          print(filmData.id);
         // widget.film = filmData;
          titleCtrl.text = filmData.title!;
          descriptionCtrl.text = filmData.description!;
          countTCtrl.text = filmData.count.toString();
          pickedImage = File(filmData.image!);
          hourCtrl.text = filmData.startHour!.substring(0,2);
          minCtrl.text = filmData.startHour!.substring(3,5);
        });
      } else {
        print('Film data not found');
      }
    }).catchError((error) {
      print('Error fetching film data: $error');
    });
    fToast = FToast();
    fToast!.init(context);
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Maglumaty uytgetmek'),
      ),
      body: SingleChildScrollView(
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
                      onChange: (value) {
                        setState(() {
                          widget.film.title = value;
                        });
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
                      onChange: (value) {
                        setState(() {
                          widget.film.description = value ;
                        });
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
                            onChange: (value) {
                              if (value.isNumericOnly ) {
                                setState(() {
                                  widget.film.count = int.parse(value);
                                });
                              }

                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(widget.film.startTime ??  'Senesi'),
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
                            onChange: (value) {
                              setState(() {
                                var minut = widget.film.startHour;
                                widget.film.startHour =  replaceSubstringAtIndex(minut!,0,value);
                                // minut!.replaceFirst(minut[0],minut[2]);
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: KTextField(
                            controller: minCtrl,
                            isSubmitted: false,
                            maxLength: 2,
                            keyboardType: TextInputType.number,
                            labelText: 'Minut',
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Doldurmaly';
                              }
                              return null;
                            },
                            onChange: (value) {
                              setState(() {
                                var minut = widget.film.startHour;
                                widget.film.startHour = replaceSubstringAtIndex(minut!,3,value);
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    MainButton(
                      onPressed: editFilmData,
                      buttonTile: 'Goşmak',
                      width: size.width - 40,
                    ),
                  ],
                ),
              );
            },
          )),
        ),
      ),
    );
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final lastDate = DateTime(now.year + 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: lastDate,
    );
    String? day = pickedDate?.day.toString() ;
    String? month = pickedDate?.month.toString();
    String? year = pickedDate?.year.toString();
    setState(() {
      widget.film.startTime = pickedDate != null ? '$day.$month.$year' : widget.film.startTime;
    });
  }

  editFilmData() {

    controller.updateFilm(widget.film).then((_) {
      print('Film data updated successfully');
      print(widget.film);
      Navigator.of(context).pop();
      widget.onChange();
    }).catchError((error) {
      print('Failed to update film data: $error');
    });
  }

  Widget _getMediaWidget() {
    return SizedBox(
      width: 200,
      height: 300,
      child: pickedImage != null
          ? _imagePickedByUser(pickedImage)
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

  // Widget _getMediaWidget() {
  //   return SizedBox(
  //       width: 200,
  //       height: 300,
  //       child: pickedImage != null
  //           ? _imagePickedByUser(pickedImage)
  //           : _imagePickedByUser(File(film!.image!)));
  // }

  Widget _imagePickedByUser(File? image) {
    if (image != null && image.path.isNotEmpty) {
        widget.film.image = image.path;

      return Image.file(image);
    } else {
      return Image.file(File(widget.film.image!));
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
    setState(() {
      pickedImage = File(image?.path ?? "");
    });
    //controller.setImage(File(image?.path ?? ""));
  }

  _imageFormCamera() async {
    var image = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      pickedImage = File(image?.path ?? "");
    });
    //controller.setImage(File(image?.path ?? ""));
  }

  _showToast(String text) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          // color: addCartToastColor,
          boxShadow: const [
            BoxShadow(
                color: Color.fromRGBO(44, 218, 82, 0.2),
                spreadRadius: 0,
                blurRadius: 3,
                offset: Offset(0, 0))
          ]),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.check_circle_outline,
            // color: bgColor5,
          ),
          const SizedBox(
            width: 15.0,
          ),
          Text(
            text,
          ),
        ],
      ),
    );

    fToast!.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 2),
    );
  }
}

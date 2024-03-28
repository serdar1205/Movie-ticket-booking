import 'package:flutter/material.dart';
import 'package:movies/core/constants/sizes/app_text_size.dart';
import 'package:movies/data/models/favorite_model.dart';
import 'package:movies/di.dart';
import 'package:movies/presentation/controller/app_contoller.dart';
import 'package:movies/presentation/screen/deatils_page/details_page.dart';
import 'package:movies/presentation/widgets/pictures/pictures.dart';

import '../../../core/constants/colors/app_colors.dart';
import '../models/main_card_model.dart';

class MainCard extends StatefulWidget {
  const MainCard({super.key, required this.model, required this.onChange});

  final Function() onChange;
  final MainModel model;

  @override
  State<MainCard> createState() => _MainCardState();
}

class _MainCardState extends State<MainCard> {
  bool isLiked = false;
  final AppController controller = locator<AppController>();

  @override
  void initState() {
    super.initState();
    controller.isFavorite(widget.model.id!).then((value) {
      setState(() {
        isLiked = value;
      });
    });
  }

  toggle() async {
    var isCurrentlyLiked = await controller.isFavorite(widget.model.id!);
    if (isCurrentlyLiked) {
      controller.favorites.remove(widget.model);
      await controller.removeFromFavorites(widget.model.id!);
    } else {
      await controller.addToFavorites(FavoriteModel(
        id: widget.model.id,
        title: widget.model.title,
        image: widget.model.image,
        description: widget.model.description,
        count: widget.model.count,
        startTime: widget.model.startDate,
        startHour: widget.model.startHour,
      ));
    }
    widget.onChange();
    setState(() {
      isLiked = !isLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DetailsPage(
                    model: widget.model,
                    onChange: () {
                      widget.onChange();
                    },
                  )));
        },
        child: Stack(
          children: [
            Container(
              height: 170.0,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  // border: Border.all(color: Theme.of(context).textTheme.bodyMedium!.color!),
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).cardColor),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CardPicture(image: widget.model.image!),
                  const SizedBox(width: 10.0),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        BigText(
                          widget.model.title ?? '',
                          context: context,
                        ),
                        const SizedBox(height: 10),
                        Material(
                          type: MaterialType.transparency,
                          child: SmallText(
                            widget.model.description ?? '',
                            context: context,
                          ),
                        ),
                        const SizedBox(height: 15.0),
                        SmallText(
                          'Baslayan wagty: ${widget.model.startDate} ${widget.model.startHour}',
                          context: context,
                        ),
                        const SizedBox(height: 15.0),
                        SmallText(
                          'Bilet sany: ${widget.model.count}',
                          context: context,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: InkWell(
                onTap: toggle,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomLeft: Radius.circular(12)),
                  child: Container(
                      width: 40,
                      height: 40,
                      color: AppColors.whiteLikeColor,
                      child: Center(
                          child: isLiked
                              ? const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                )
                              : const Icon(
                                  Icons.favorite_border_outlined,
                                  color: Colors.red,
                                ))),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

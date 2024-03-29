import 'package:flutter/material.dart';
import 'package:movies/core/constants/sizes/app_text_size.dart';
import 'package:movies/presentation/screen/deatils_page/details_page.dart';
import 'package:movies/presentation/widgets/models/main_card_model.dart';
import 'package:movies/presentation/widgets/pictures/pictures.dart';
import '../../../core/constants/colors/app_colors.dart';

class AddedFilmsCard extends StatelessWidget {
  const AddedFilmsCard({
    super.key,
    required this.model,
    required this.onRemove,
    required this.onEdit,
    required this.onChange,
  });

  final MainModel model;
  final void Function()? onRemove;
  final void Function()? onEdit;
  final Function() onChange;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme
          .of(context)
          .scaffoldBackgroundColor,
      child: InkWell(
        onTap: () {
          Navigator
              .of(context)
              .push(
              MaterialPageRoute(builder: (context) =>
                  DetailsPage(model: model, onChange: () {},)));
          },
        child: Stack(
          children: [
            Container(
              height: 170.0,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                // border: Border.all(color: Theme.of(context).textTheme.bodyMedium!.color!),
                  borderRadius: BorderRadius.circular(10),
                  color: Theme
                      .of(context)
                      .cardColor),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CardPicture(image: model.image!),
                  const SizedBox(width: 10.0),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        BigText(
                          model.title ?? '',
                          context: context,
                        ),
                        const SizedBox(height: 10),
                        Material(
                          type: MaterialType.transparency,
                          child: SmallText(
                            model.description ?? '',
                            context: context,
                          ),
                        ),
                        const SizedBox(height: 15.0),
                        SmallText(
                          'Başlanýan wagty: ${model.startDate} ${model
                              .startHour}',
                          context: context,
                        ),
                        const SizedBox(height: 15.0),
                        SmallText(
                          'Bilet sany: ${model.count}',
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
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomLeft: Radius.circular(12)),
                child: InkWell(
                  onTap: onRemove,
                  child: Container(
                      width: 40,
                      height: 40,
                      color: AppColors.whiteLikeColor,
                      child: const Center(
                          child: Icon(
                            Icons.delete,
                            color: AppColors.textDarkColor,
                          ))),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomRight: Radius.circular(8)),
                child: InkWell(
                  onTap: onEdit,
                  child: Container(
                      width: 40,
                      height: 40,
                      color: AppColors.whiteLikeColor,
                      child: const Center(
                          child: Icon(
                            Icons.edit,
                            color: AppColors.textDarkColor,
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

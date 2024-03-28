import 'dart:io';
import 'package:flutter/material.dart';



class CardPicture extends StatelessWidget {
  const CardPicture({super.key, required this.image});
final  String image;

  @override
  Widget build(BuildContext context) {
    return  Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      elevation: 4,
       child: ClipRRect(
         borderRadius: BorderRadius.all(Radius.circular(10.0)),
         child: Image.file(
           File(image),
           fit: BoxFit.cover,
           height: 150.0,
           width: 100.0,
           errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
             return Image.asset(
               'assets/images/noPhoto.png',
               fit: BoxFit.cover,
               height: 150.0,
               width: 100.0,
             );
           },
         ),
       ),

      // ClipRRect(
      //   borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      //   child: Image.file(File(image),
      //     placeholder: (context, url) => const SizedBox(
      //       height: 150.0,
      //       width: 100.0,
      //       child: LoadingWidget(
      //         isImage: true,
      //       ),
      //     ),
      //     errorWidget: (context, url, error) => Image.asset(
      //       'assets/images/noPhoto.png',
      //       fit: BoxFit.cover,
      //       height: 150.0,
      //       width: 100.0,
      //     ),
      //     fit: BoxFit.cover,
      //     height: 150.0,
      //     width: 100.0,
      //   ),
      // ),
    );
  }
}
class SliderCardImage extends StatelessWidget {
  const SliderCardImage({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ShaderMask(
      blendMode: BlendMode.dstIn,
      shaderCallback: (rect) {
        return  const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black,
            Colors.black,
            Colors.transparent,
          ],
          stops: [0.3, 0.5, 1],
        ).createShader(
          Rect.fromLTRB(0, 0, rect.width, rect.height),
        );
      },
      child: ImageWithShimmer(
        height: size.height * 0.5,
        width: double.infinity,
        imageUrl: imageUrl,
      ),
    );
  }
}

class ImageWithShimmer extends StatelessWidget {
  const ImageWithShimmer({
    super.key,
    required this.imageUrl,
    required this.width,
    required this.height,
  });

  final String imageUrl;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Image.file(
      File(imageUrl),
      height: height,
      width: width,
      fit: BoxFit.cover,

      errorBuilder: (_, __, ___) => const Icon(
        Icons.error,
        color: Colors.red,
      ),
    );
  }
}


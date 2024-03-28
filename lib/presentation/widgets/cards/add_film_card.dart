// import 'package:flutter/material.dart';
//
// class AddFilmCard extends StatelessWidget {
//   const AddFilmCard({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: Center(
//             child: Form(
//               key: formKey,
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   const SizedBox(height: 20),
//                   GestureDetector(
//                       onTap: () {
//                         _showPicker(context);
//                       },
//                       child: _getMediaWidget()),
//                   SizedBox(height: 20),
//                   KTextField(
//                     controller:  titleCtrl,
//                     isSubmitted: false,
//                     labelText: 'Kinonyn ady',
//                     keyboardType: TextInputType.text,
//                     validator: (val) {
//                       if (val == null || val.isEmpty) {
//                         return 'Doldurmaly';
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 20),
//                   KTextField(
//                     controller:  descriptionCtrl,
//                     isSubmitted: false,
//                     keyboardType: TextInputType.text,
//                     labelText: 'Beyany',
//                     validator: (val) {
//                       if (val == null || val.isEmpty) {
//                         return 'Doldurmaly';
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 20),
//                   KTextField(
//                     controller:  countTCtrl,
//                     isSubmitted: false,
//                     keyboardType: TextInputType.number,
//                     labelText: 'Bilet sany',
//                     validator: (val) {
//                       if (val == null || val.isEmpty) {
//                         return 'Doldurmaly';
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 20),
//                   MainButton(
//                     onPressed:(){
//                       addFilm();
//                       clearCtrl();
//                       _showToast();
//                     },
//                     buttonTile: 'Gosmak',
//                     width: size.width - 40,
//                   ),
//                 ],
//               ),
//             );),
//       ),
//     );
//   }
// }

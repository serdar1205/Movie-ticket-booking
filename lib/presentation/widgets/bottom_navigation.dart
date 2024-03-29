import 'package:flutter/material.dart';
import 'package:movies/core/constants/colors/app_colors.dart';

// ignore: must_be_immutable
class BottomNavBar extends StatelessWidget {
  BottomNavBar({Key? key,required this.pageIndex, required this.isAdmin, required this.onTap}) : super(key: key);
  bool isAdmin;
  int pageIndex;
  void Function(int)? onTap;
  final List<String> pageTitles = [
    "Baş sahypa",
    "Halanlarym",
    "Alnan biletler",
    "Admin",
  ];
  final List<String> adminTitles = [
    "Kinolar",
    'Kino gosmak'
  ];

  final List<IconData> pageIcons = [
    Icons.home,
    Icons.favorite_border,
    Icons.history,
    Icons.person,
  ];
  final List<IconData> adminIcons = [
    Icons.movie,
    Icons.add
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3, left: 2),
      child: BottomNavigationBar(
        items: List.generate(
          isAdmin ? adminTitles.length : pageTitles.length,
              (index) => BottomNavigationBarItem(
            icon:Icon(isAdmin ? adminIcons[index] : pageIcons[index],size: 24,),
            label:isAdmin ? adminTitles[index] : pageTitles[index],
          ),
        ),
        type: BottomNavigationBarType.fixed,
        currentIndex: pageIndex,
        onTap: onTap,
        fixedColor:AppColors.mainbuttonColor,
      ),
    );
  }
}


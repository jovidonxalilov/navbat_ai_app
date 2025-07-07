import 'package:flutter/material.dart';
import 'bottom_navigation_bar_container.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({
    super.key,
    required this.onTap,
    required this.selectIndex,
  });

  final ValueChanged<int> onTap;
  final int selectIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      decoration: BoxDecoration(
        color: Color(0xFF1C1C1E), // BottomBar background color
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(25),
          topLeft: Radius.circular(25),
        ),
        border: Border(
          top: BorderSide(
            color: Color(0xFF1C1C1E),
            width: 1.5,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BottomNavigationBarContainer(
              svg: "assets/icons/home.svg",
              text: "Home",
              callback: () => onTap(0),
              select: selectIndex,
              index: 0,
            ),
            BottomNavigationBarContainer(
              svg: "assets/icons/profile.svg",
              text: "Map",
              callback: () => onTap(1),
              select: selectIndex,
              index: 1,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_mise/const/colors.dart';

const regions = [
  '서울',
  '경기',
  '대구',
  '충남',
  '인천',
  '대전',
  '경북',
  '세종',
  '광주',
  '전북',
  '강원',
  '울산',
  '전남',
  '부산',
  '제주',
  '충북',
  '경남',
];

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: darkColor,
      child: ListView(
        children: [
          DrawerHeader(
            child: Text(
              '지역 선택',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
          ),
          ...regions
              .map(
                (e) => ListTile(
                  title: Text(e),
                  onTap: () {},
                  tileColor: Colors.white,
                  selectedTileColor: lightColor,
                  selectedColor: Colors.white,
                  selected: e == '서울',
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_mise/const/colors.dart';
import 'package:flutter_mise/const/regions.dart';

typedef OnRegionTap = void Function(String region);

class MainDrawer extends StatelessWidget {
  final String selectedRegion;
  final OnRegionTap onRegionTap;

  const MainDrawer({
    required this.selectedRegion,
    required this.onRegionTap,
    Key? key,
  }) : super(key: key);

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
                  onTap: () {
                    onRegionTap(e);
                  },
                  tileColor: Colors.white,
                  selectedTileColor: lightColor,
                  selectedColor: Colors.white,
                  selected: e == selectedRegion,
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}

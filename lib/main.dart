import 'package:flutter/material.dart';
import 'package:flutter_mise/model/stat_model.dart';
import 'package:flutter_mise/screen/home_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {

  await Hive.initFlutter();

  Hive.registerAdapter(StatModelAdapter());
  Hive.registerAdapter(ItemCodeAdapter());

  for (ItemCode itemCode in ItemCode.values) {
    await Hive.openBox<StatModel>(itemCode.name);
  }

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'sunflower',
      ),
      home: HomeScreen(),
    ),
  );
}

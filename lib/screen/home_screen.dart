import 'package:flutter/material.dart';
import 'package:flutter_mise/component/category_card.dart';
import 'package:flutter_mise/component/main_app_bar.dart';
import 'package:flutter_mise/component/main_drawer.dart';
import 'package:flutter_mise/component/main_stat.dart';
import 'package:flutter_mise/const/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      drawer: MainDrawer(),
      body: CustomScrollView(
        slivers: [
          MainAppBar(),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CategoryCard(),
              ],
            ),
          )
        ],
      ),
    );
  }
}

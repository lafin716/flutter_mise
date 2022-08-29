import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mise/component/category_card.dart';
import 'package:flutter_mise/component/hourly_card.dart';
import 'package:flutter_mise/component/main_app_bar.dart';
import 'package:flutter_mise/component/main_drawer.dart';
import 'package:flutter_mise/const/colors.dart';
import 'package:flutter_mise/const/data.dart';
import 'package:flutter_mise/model/stat_model.dart';
import 'package:flutter_mise/repository/stat_repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    final statModels = await StatRepository.fetchData();

    print(statModels);
  }

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
                const SizedBox(
                  height: 16.0,
                ),
                HourlyCard(),
              ],
            ),
          )
        ],
      ),
    );
  }
}

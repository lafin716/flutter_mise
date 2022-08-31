import 'package:flutter/material.dart';
import 'package:flutter_mise/container/category_card.dart';
import 'package:flutter_mise/container/hourly_card.dart';
import 'package:flutter_mise/component/main_app_bar.dart';
import 'package:flutter_mise/component/main_drawer.dart';
import 'package:flutter_mise/const/colors.dart';
import 'package:flutter_mise/const/regions.dart';
import 'package:flutter_mise/model/stat_and_status_model.dart';
import 'package:flutter_mise/model/stat_model.dart';
import 'package:flutter_mise/repository/stat_repository.dart';
import 'package:flutter_mise/utils/data_utils.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String region = regions[0];
  bool isExpended = true;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(scrollListener);
    fetchData();
  }

  @override
  void dispose() {
    scrollController.removeListener(scrollListener);
    scrollController.dispose();
    super.dispose();
  }

  Future<void> fetchData() async {
    List<Future> futures = [];

    for (ItemCode itemCode in ItemCode.values) {
      futures.add(StatRepository.fetchData(
        itemCode: itemCode,
      ));
    }

    final results = await Future.wait(futures);
    for (int i = 0; i < results.length; i++) {
      final key = ItemCode.values[i];
      final value = results[i];
      final box = Hive.box<StatModel>(key.name);

      for (StatModel stat in value) {
        box.put(stat.dataTime.toString(), stat);
      }
    }
  }

  scrollListener() {
    bool isExpended = scrollController.offset < 500 - kToolbarHeight;

    if (isExpended != this.isExpended) {
      setState(() {
        this.isExpended = isExpended;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box>(
      valueListenable: Hive.box<StatModel>(ItemCode.PM10.name).listenable(),
      builder: (context, box, widget) {
        final stat = box.values.toList().last as StatModel;
        // PM10 box
        final status = DataUtils.getStatusFromItemCodeAndValue(
          value: stat.getLevelFromRegion(region),
          itemCode: ItemCode.PM10,
        );

        return Scaffold(
          drawer: MainDrawer(
            selectedRegion: region,
            onRegionTap: onRegionTap,
            darkColor: status.darkColor,
            lightColor: status.lightColor,
          ),
          body: Container(
            color: status.primaryColor,
            child: CustomScrollView(
              controller: scrollController,
              slivers: [
                MainAppBar(
                  stat: stat,
                  status: status,
                  region: region,
                  dateTime: stat.dataTime,
                  isExpended: isExpended,
                ),
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CategoryCard(
                        region: region,
                        darkColor: status.darkColor,
                        lightColor: status.lightColor,
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      ...ItemCode.values.map((itemCode) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: HourlyCard(
                            darkColor: status.darkColor,
                            lightColor: status.lightColor,
                            region: region,
                            itemCode: itemCode,
                          ),
                        );
                      }).toList(),
                      const SizedBox(
                        height: 16.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  onRegionTap(String region) {
    setState(() {
      this.region = region;
    });
    Navigator.of(context).pop();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_mise/component/category_card.dart';
import 'package:flutter_mise/component/hourly_card.dart';
import 'package:flutter_mise/component/main_app_bar.dart';
import 'package:flutter_mise/component/main_drawer.dart';
import 'package:flutter_mise/const/colors.dart';
import 'package:flutter_mise/const/regions.dart';
import 'package:flutter_mise/model/stat_and_status_model.dart';
import 'package:flutter_mise/model/stat_model.dart';
import 'package:flutter_mise/repository/stat_repository.dart';
import 'package:flutter_mise/utils/data_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String region = regions[0];

  Future<Map<ItemCode, List<StatModel>>> fetchData() async {
    Map<ItemCode, List<StatModel>> stats = {};

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

      stats.addAll({
        key: value,
      });
    }

    return stats;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(
        selectedRegion: region,
        onRegionTap: onRegionTap,
      ),
      body: FutureBuilder<Map<ItemCode, List<StatModel>>>(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('에러가 있습니다.'),
              );
            }

            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            Map<ItemCode, List<StatModel>> stats = snapshot.data!;
            StatModel pm10RecentStat = stats[ItemCode.PM10]![0];

            final status = DataUtils.getStatusFromItemCodeAndValue(
              itemCode: ItemCode.PM10,
              value: pm10RecentStat.seoul,
            );

            final statAndStatusModels = stats.keys.map(
                  (key) {
                final value = stats[key]!;
                final stat = value[0];

                return StatAndStatusModel(
                  itemCode: key,
                  status: DataUtils.getStatusFromItemCodeAndValue(
                    value: stat.getLevelFromRegion(region),
                    itemCode: key,
                  ),
                  stat: stat,
                );
              },
            ).toList();

            return Container(
              color: status.primaryColor,
              child: CustomScrollView(
                slivers: [
                  MainAppBar(
                    stat: pm10RecentStat,
                    status: status,
                    region: region,
                    dateTime: pm10RecentStat.dataTime,
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CategoryCard(
                          region: region,
                          models: statAndStatusModels,
                          darkColor: status.darkColor,
                          lightColor: status.lightColor,
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        ...stats.keys.map(
                            (itemCode) {
                            final stat = stats[itemCode]!;

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: HourlyCard(
                                darkColor: status.darkColor,
                                lightColor: status.lightColor,
                                region: region,
                                category: DataUtils.getItemCodeToKrString(itemCode: itemCode),
                                stats: stat,
                              ),
                            );
                          }
                        ).toList(),
                        const SizedBox(
                          height: 16.0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }

  onRegionTap(String region) {
    setState(() {
      this.region = region;
    });
    Navigator.of(context).pop();
  }
}

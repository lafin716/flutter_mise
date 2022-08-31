import 'package:flutter/material.dart';
import 'package:flutter_mise/component/card_title.dart';
import 'package:flutter_mise/component/main_card.dart';
import 'package:flutter_mise/model/stat_model.dart';
import 'package:flutter_mise/utils/data_utils.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HourlyCard extends StatelessWidget {
  final String region;
  final Color darkColor;
  final Color lightColor;
  final ItemCode itemCode;

  const HourlyCard({
    required this.region,
    required this.darkColor,
    required this.lightColor,
    required this.itemCode,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainCard(
      backgroundColor: lightColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CardTitle(
            title: '시간별 ${DataUtils.getItemCodeToKrString(itemCode: itemCode)}',
            backgroundColor: darkColor,
          ),
          ValueListenableBuilder<Box>(
            valueListenable: Hive.box<StatModel>(itemCode.name).listenable(),
            builder: (context, box, widget) {
              return Column(
                children: box.values
                    .map(
                      (stat) => renderRow(stat: stat),
                    )
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget renderRow({
    required StatModel stat,
  }) {
    final status = DataUtils.getStatusFromItemCodeAndValue(
      value: stat.getLevelFromRegion(region),
      itemCode: stat.itemCode,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 4.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text('${stat.dataTime.hour}시'),
          ),
          Expanded(
            child: Image.asset(
              status.imagePath,
              height: 20.0,
            ),
          ),
          Expanded(
            child: Text(
              status.label,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}

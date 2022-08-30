import 'package:flutter_mise/const/status_level.dart';
import 'package:flutter_mise/model/stat_model.dart';
import 'package:flutter_mise/model/status_model.dart';

class DataUtils {
  static String getTimeFromDateTime({required DateTime dateTime}) {
    return '${dateTime.year}-${getTimeFormat(dateTime.month)}-${getTimeFormat(dateTime.day)} ${getTimeFormat(dateTime.hour)}:${getTimeFormat(dateTime.minute)}';
  }

  static String getTimeFormat(int number) {
    return number.toString().padLeft(2, '0');
  }

  static String getUnitFromItemCode({
    required ItemCode itemCode,
  }) {
    switch (itemCode) {
      case ItemCode.PM10:
      case ItemCode.PM25:
        return '㎍/m';
      default:
        return 'ppm';
    }
  }

  static String getItemCodeToKrString({
    required ItemCode itemCode,
  }) {
    switch (itemCode) {
      case ItemCode.PM10:
        return '미세먼지';
      case ItemCode.PM25:
        return '초미세먼지';
      case ItemCode.NO2:
        return '이산화질소';
      case ItemCode.O3:
        return '오존';
      case ItemCode.CO:
        return '일산화탄소';
      case ItemCode.SO2:
        return '아황산가스';
    }
  }

  static StatusModel getStatusFromItemCodeAndValue({
    required double value,
    required ItemCode itemCode,
  }) {
    return statusLevel.where(
      (status) {
        if (itemCode == ItemCode.PM10) {
          return status.minFineDust < value;
        } else if (itemCode == ItemCode.PM25) {
          return status.minFineUltraDust < value;
        } else if (itemCode == ItemCode.CO) {
          return status.minCO < value;
        } else if (itemCode == ItemCode.O3) {
          return status.minO3 < value;
        } else if (itemCode == ItemCode.NO2) {
          return status.minNO2 < value;
        } else if (itemCode == ItemCode.SO2) {
          return status.minSO2 < value;
        } else {
          throw Exception('알 수 없는 아이템 코드입니다.');
        }
      }
    ).last;
  }
}

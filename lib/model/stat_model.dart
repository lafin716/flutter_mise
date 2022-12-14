import 'package:hive_flutter/hive_flutter.dart';

part 'stat_model.g.dart';

@HiveType(typeId: 2)
enum ItemCode {
  @HiveField(0)
  PM10,
  @HiveField(1)
  PM25,
  @HiveField(2)
  NO2,
  @HiveField(3)
  O3,
  @HiveField(4)
  CO,
  @HiveField(5)
  SO2,
}

@HiveType(typeId: 1)
class StatModel {
  @HiveField(0)
  final double daegu;
  @HiveField(1)
  final double chungnam;
  @HiveField(2)
  final double incheon;
  @HiveField(3)
  final double daejeon;
  @HiveField(4)
  final double gyeongbuk;
  @HiveField(5)
  final double sejong;
  @HiveField(6)
  final double gwangju;
  @HiveField(7)
  final double jeonbuk;
  @HiveField(8)
  final double gangwon;
  @HiveField(9)
  final double ulsan;
  @HiveField(10)
  final double jeonnam;
  @HiveField(11)
  final double seoul;
  @HiveField(12)
  final double busan;
  @HiveField(13)
  final double jeju;
  @HiveField(14)
  final double chungbuk;
  @HiveField(15)
  final double gyeongnam;
  @HiveField(16)
  final double gyeonggi;
  @HiveField(17)
  final ItemCode itemCode;
  @HiveField(18)
  final DateTime dataTime;


  StatModel({
    required this.daegu,
    required this.chungnam,
    required this.incheon,
    required this.daejeon,
    required this.gyeongbuk,
    required this.sejong,
    required this.gwangju,
    required this.jeonbuk,
    required this.gangwon,
    required this.ulsan,
    required this.jeonnam,
    required this.seoul,
    required this.busan,
    required this.jeju,
    required this.chungbuk,
    required this.gyeongnam,
    required this.gyeonggi,
    required this.itemCode,
    required this.dataTime
  });

  StatModel.fromJson({required Map<String, dynamic> json}):
        daegu = double.parse(json['daegu'] ?? '0'),
        chungnam = double.parse(json['chungnam'] ?? '0'),
        incheon = double.parse(json['incheon'] ?? '0'),
        daejeon = double.parse(json['daejeon'] ?? '0'),
        gyeongbuk = double.parse(json['gyeongbuk'] ?? '0'),
        sejong = double.parse(json['sejong'] ?? '0'),
        gwangju = double.parse(json['gwangju'] ?? '0'),
        jeonbuk = double.parse(json['jeonbuk'] ?? '0'),
        gangwon = double.parse(json['gangwon'] ?? '0'),
        ulsan = double.parse(json['ulsan'] ?? '0'),
        jeonnam = double.parse(json['jeonnam'] ?? '0'),
        seoul = double.parse(json['seoul'] ?? '0'),
        busan = double.parse(json['busan'] ?? '0'),
        jeju = double.parse(json['jeju'] ?? '0'),
        chungbuk = double.parse(json['chungbuk'] ?? '0'),
        gyeongnam = double.parse(json['gyeongnam'] ?? '0'),
        gyeonggi = double.parse(json['gyeonggi'] ?? '0'),
        dataTime = DateTime.parse(json['dataTime']),
        itemCode = parseItemCode(json['itemCode']);

  static ItemCode parseItemCode(String raw) {
    if (raw == 'PM2.5') {
      return ItemCode.PM25;
    }

    // ItemCode.CO.toString()
    // ItemCode.CO ??? ????????????
    return ItemCode.values.firstWhere((element) => element.name == raw);
  }

  double getLevelFromRegion(String region) {
    if (region == '??????') {
      return seoul;
    }
    if (region == '??????') {
      return gyeonggi;
    }
    if (region == '??????') {
      return daegu;
    }
    if (region == '??????') {
      return chungnam;
    }
    if (region == '??????') {
      return incheon;
    }
    if (region == '??????') {
      return daejeon;
    }
    if (region == '??????') {
      return gyeongbuk;
    }
    if (region == '??????') {
      return sejong;
    }
    if (region == '??????') {
      return gwangju;
    }
    if (region == '??????') {
      return jeonbuk;
    }
    if (region == '??????') {
      return gangwon;
    }
    if (region == '??????') {
      return ulsan;
    }
    if (region == '??????') {
      return jeonnam;
    }
    if (region == '??????') {
      return busan;
    }
    if (region == '??????') {
      return jeju;
    }
    if (region == '??????') {
      return chungbuk;
    }
    if (region == '??????') {
      return gyeongnam;
    }

    throw Exception('??? ??? ?????? ???????????????.');
  }
}

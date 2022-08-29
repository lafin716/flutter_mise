import 'package:dio/dio.dart';
import 'package:flutter_mise/const/data.dart';
import 'package:flutter_mise/model/stat_model.dart';

class StatRepository {
  static Future<List<StatModel>> fetchData({
    required ItemCode itemCode,
  }) async {
    final response = await Dio().get(
      'http://apis.data.go.kr/B552584/ArpltnStatsSvc/getCtprvnMesureLIst',
      queryParameters: {
        'serviceKey': serviceKey,
        'returnType': 'json',
        'pageNo': 1,
        'numOfRows': 30,
        'itemCode': itemCode.name,
        'dataGubun': 'HOUR',
        'searchCondition': 'WEEK',
      },
    );

    return response.data['response']['body']['items']
        .map<StatModel>(
          (response) => StatModel.fromJson(
            json: response,
          ),
        )
        .toList();
  }
}

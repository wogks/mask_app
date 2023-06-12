import 'package:dio/dio.dart';
import 'package:mask_app/const/data.dart';
import 'package:mask_app/model/stat_model.dart';

class StatRepository {
  static Future<List<StatModel>> fetchData() async {
    final response = await Dio().get(
      'http://apis.data.go.kr/B552584/ArpltnStatsSvc/getCtprvnMesureLIst',
      queryParameters: {
        'serviceKey': serviceKey,
        'returnType': 'json',
        'numOfRows': 30,
        'pageNo': 1,
        'itemCode': 'PM10',
        'year': 2023,
        'dataGubun': 'HOUR',
        'searchCondition': 'WEEK',
      },
    );
    return List.from(response.data['response']['body']['items'])
        .map<StatModel>(
          (item) => StatModel.fromJson(json: item),
        )
        .toList();
  }
}

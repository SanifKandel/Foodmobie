import 'package:dio/dio.dart';
import 'package:foodreminder/app/constants.dart';
import 'package:foodreminder/data_source/remote_data_source/response/dinner_response.dart';
import 'package:foodreminder/data_source/remote_data_source/response/lunch_response.dart';
import 'package:foodreminder/data_source/remote_data_source/response/breakfast_response.dart';
import 'package:foodreminder/helper/http_service.dart';
import 'package:foodreminder/model/recommendation.dart';

class RecommendRemoteDataSource {
  final Dio _httpServices = HttpServices().getDioInstance();

  Future<List<Recommend>> getRecommendedBreakfastFood() async {
    try {
      Response response = await _httpServices.get(
        Constant.breakfastURL,
        options: Options(
          headers: {
            "Authorization": Constant.token,
          },
        ),
      );
      if (response.statusCode == 200) {
        BreakfastResponse recomendResponse =
            BreakfastResponse.fromJson(response.data);
        return recomendResponse.breakfast!;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Recommend>> getRecommendedLunchFood() async {
    try {
      Response response = await _httpServices.get(
        Constant.lunchURL,
        options: Options(
          headers: {
            "Authorization": Constant.token,
          },
        ),
      );
      if (response.statusCode == 200) {
        LunchResponse lunchResponse = LunchResponse.fromJson(response.data);
        return lunchResponse.lunch!;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Recommend>> getRecommendedDinnerFood() async {
    try {
      Response response = await _httpServices.get(
        Constant.dinnerURL,
        options: Options(
          headers: {
            "Authorization": Constant.token,
          },
        ),
      );
      if (response.statusCode == 200) {
        DinnerResponse dinnerResponse = DinnerResponse.fromJson(response.data);
        return dinnerResponse.dinner!;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}

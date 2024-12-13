import 'package:dio/dio.dart';
import 'package:foodreminder/app/constants.dart';
import 'package:foodreminder/data_source/remote_data_source/response/food_response.dart';
import 'package:foodreminder/helper/http_service.dart';
import 'package:foodreminder/model/food.dart';

class FoodsRemoteDataSource {
  final Dio _httpServices;

  FoodsRemoteDataSource({Dio? dio})
      : _httpServices = dio ?? HttpServices().getDioInstance();

  Future<List<Food>> getAllFoods() async {
    try {
      Response response = await _httpServices.get(
        Constant.foodsURL,
        options: Options(
          headers: {
            "Authorization": Constant.token,
          },
        ),
      );
      if (response.statusCode == 200) {
        FoodResponse foodsResponse = FoodResponse.fromJson(response.data);
        return foodsResponse.data!;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}

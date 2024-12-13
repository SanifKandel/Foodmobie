import 'package:foodreminder/app/network_connectivity.dart';
import 'package:foodreminder/data_source/local_data_source/food_data_source.dart';
import 'package:foodreminder/data_source/remote_data_source/food_remote_data_source.dart';
import 'package:foodreminder/model/food.dart';

abstract class FoodsRepository {
  Future<int> addFoods(Food foods);
  Future<List<Food>> getAllFoods();
  Future<Food?> getFoodsByFoodsName(String foodsName);
}

class FoodsRepositoryImpl extends FoodsRepository {
  @override
  Future<int> addFoods(Food foods) {
    return FoodsDataSource().addFoods(foods);
  }

  @override
  Future<List<Food>> getAllFoods() async {
    bool status = await NetworkConnectivity.isOnline();
    List<Food> lstFoods = [];
    if (status) {
      lstFoods = await FoodsRemoteDataSource().getAllFoods();
      await FoodsDataSource().addAllFoods(lstFoods);
      return lstFoods;
    } else {
      return FoodsDataSource().getAllFoods();
    }
  }

  @override
  Future<Food?> getFoodsByFoodsName(String foodsName) {
    return FoodsDataSource().getFoodsByFoodsName(foodsName);
  }
}

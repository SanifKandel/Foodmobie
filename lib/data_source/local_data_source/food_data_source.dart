import 'package:foodreminder/helper/objectbox.dart';
import 'package:foodreminder/model/food.dart';
import 'package:foodreminder/state/objectbox_state.dart';

class FoodsDataSource {
  ObjectBoxInstance get objectBoxInstance => ObjectBoxState.objectBoxInstance!;
  Future<int> addFoods(Food foods) async {
    try {
      return objectBoxInstance.addFoods(foods);
    } catch (e) {
      return 0;
    }
  }

  Future addAllFoods(List<Food> lstFoods) async {
    try {
      return objectBoxInstance.addAllFoods(lstFoods);
    } catch (e) {
      throw Exception("error adding food to object box $e");
    }
  }

  Future<List<Food>> getAllFoods() async {
    try {
      return objectBoxInstance.getAllFoods();
    } catch (e) {
      return [];
    }
  }

  Future<Food?> getFoodsByFoodsName(String foodsName) async {
    try {
      return objectBoxInstance.getFoodsByFoodsName(foodsName);
    } catch (e) {
      return null;
    }
  }
}

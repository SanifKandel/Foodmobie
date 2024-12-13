import 'dart:convert';

import 'package:foodreminder/app/network_connectivity.dart';
import 'package:foodreminder/data_source/remote_data_source/recommendation_remote_data.dart';
import 'package:foodreminder/model/recommendation.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class RecommendRepository {
  Future<List<Recommend>> getRecommendedBreakfastFood();
  Future<List<Recommend>> getRecommendedLunchFood();
  Future<List<Recommend>> getRecommendedDinnerFood();
}

class RecommendRepositoryImpl extends RecommendRepository {
  @override
  Future<List<Recommend>> getRecommendedBreakfastFood() async {
    final prefs = await SharedPreferences.getInstance();
    bool status = await NetworkConnectivity.isOnline();
    if (status) {
      List<Recommend> recommendedFoods =
          await RecommendRemoteDataSource().getRecommendedBreakfastFood();
      await prefs.setStringList('recommended_foods',
          recommendedFoods.map((food) => json.encode(food.toJson())).toList());
      return recommendedFoods;
    } else {
      // Retrieve the data from Shared Preferences
      List<String> jsonStringList =
          prefs.getStringList('recommended_foods') ?? [];
      List<Recommend> recommendedFoods = jsonStringList
          .map((jsonString) => Recommend.fromJson(json.decode(jsonString)))
          .toList();
      return recommendedFoods;
    }
  }

  @override
  Future<List<Recommend>> getRecommendedLunchFood() async {
    final prefs = await SharedPreferences.getInstance();
    bool status = await NetworkConnectivity.isOnline();
    if (status) {
      List<Recommend> recommendedFoods =
          await RecommendRemoteDataSource().getRecommendedLunchFood();
      await prefs.setStringList('recommended_lunch_foods',
          recommendedFoods.map((food) => json.encode(food.toJson())).toList());
      return recommendedFoods;
    } else {
      // Retrieve the data from Shared Preferences
      List<String> jsonStringList =
          prefs.getStringList('recommended_lunch_foods') ?? [];
      List<Recommend> recommendedFoods = jsonStringList
          .map((jsonString) => Recommend.fromJson(json.decode(jsonString)))
          .toList();
      return recommendedFoods;
    }
  }

  @override
  Future<List<Recommend>> getRecommendedDinnerFood() async {
    final prefs = await SharedPreferences.getInstance();
    bool status = await NetworkConnectivity.isOnline();
    if (status) {
      List<Recommend> recommendedFoods =
          await RecommendRemoteDataSource().getRecommendedDinnerFood();
      await prefs.setStringList('recommended_dinner_foods',
          recommendedFoods.map((food) => json.encode(food.toJson())).toList());
      return recommendedFoods;
    } else {
      // Retrieve the data from Shared Preferences
      List<String> jsonStringList =
          prefs.getStringList('recommended_dinner_foods') ?? [];
      List<Recommend> recommendedFoods = jsonStringList
          .map((jsonString) => Recommend.fromJson(json.decode(jsonString)))
          .toList();
      return recommendedFoods;
    }
  }
}

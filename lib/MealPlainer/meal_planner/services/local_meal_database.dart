import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/meal_model.dart';

class LocalMealDatabase {
  static const String _fallbackMealsKey = 'fallback_meals';
  static const int _maxStoredMeals = 50;  // Store up to 50 meals per type

  // Singleton pattern
  static final LocalMealDatabase _instance = LocalMealDatabase._internal();
  factory LocalMealDatabase() => _instance;
  LocalMealDatabase._internal();

  Future<void> storeMeal(Meal meal) async {
    final prefs = await SharedPreferences.getInstance();
    final storedMeals = await getMealsByType(meal.type ?? 'any');
    
    if (!storedMeals.any((m) => m.id == meal.id)) {
      storedMeals.add(meal);
      if (storedMeals.length > _maxStoredMeals) {
        storedMeals.removeAt(0);  // Remove oldest meal
      }
      
      await prefs.setString(
        _getFallbackKey(meal.type ?? 'any'),
        json.encode(storedMeals.map((m) => m.toJson()).toList()),
      );
    }
  }

  Future<List<Meal>> getMealsByType(String type) async {
    final prefs = await SharedPreferences.getInstance();
    final mealsJson = prefs.getString(_getFallbackKey(type));
    if (mealsJson == null) return [];

    try {
      final List<dynamic> mealsList = json.decode(mealsJson);
      return mealsList.map((m) => Meal.fromJson(m)).toList();
    } catch (e) {
      print('Error loading fallback meals: $e');
      return [];
    }
  }

  Future<Meal?> getRandomMealByType(String type) async {
    final meals = await getMealsByType(type);
    if (meals.isEmpty) return null;
    meals.shuffle();
    return meals.first;
  }

  String _getFallbackKey(String type) => '${_fallbackMealsKey}_$type';
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/meal_model.dart';
import '../models/nutrients.dart';
import '../models/user_preferences.dart';
import 'package:fitnessapp/Service/spoonacular_service.dart';
import 'local_meal_database.dart';

class MealService {
  static const String _mealPlanKeyPrefix = 'meal_plan_';
  static const String _mealCacheKeyPrefix = 'meal_cache_';
  static const Duration _cacheDuration = Duration(days: 7);

  final SpoonacularService _spoonacularService = SpoonacularService();
  final LocalMealDatabase _localDb = LocalMealDatabase();

  int _apiFailureCount = 0;
  static const int _maxApiFailures = 3;

  String getMealPlanKey(DateTime date) {
    return _mealPlanKeyPrefix + date.toIso8601String().split('T')[0];
  }

  Future<MealPlan> getDailyMealPlan(
      [DateTime? date, bool forceRefresh = false]) async {
    final targetDate = date ?? DateTime.now();
    final prefs = await SharedPreferences.getInstance();
    final mealPlanKey = getMealPlanKey(targetDate);

    if (!forceRefresh) {
      final savedMealPlan = prefs.getString(mealPlanKey);
      if (savedMealPlan != null) {
        try {
          final mealPlanMap = json.decode(savedMealPlan);
          return MealPlan.fromJson(mealPlanMap);
        } catch (e) {
          print('Error loading saved meal plan: $e');
        }
      }
    }

    final userPrefs = await UserPreferences.load();
    try {
      String? diet = _getDietFromPreferences(userPrefs);
      List<String>? exclude = _getExclusionsFromPreferences(userPrefs);
      String? cuisine = _getCuisineFromPreferences(userPrefs);

      MealPlan? mealPlan;
      try {
        mealPlan =
            await _fetchFromApiWithRetry(userPrefs, diet, exclude, cuisine);
      } catch (e) {
        print('API Error: $e');
        mealPlan = await _getFallbackMealPlan(userPrefs);
      }

      if (mealPlan != null) {
        await saveMealPlan(mealPlan, targetDate);
        // Cache successful API meals for fallback
        if (mealPlan.meals.isNotEmpty) {
          for (var meal in mealPlan.meals) {
            await _localDb.storeMeal(meal);
          }
        }
        return mealPlan;
      }

      throw Exception('Failed to generate meal plan');
    } catch (e) {
      print('Error in getDailyMealPlan: $e');
      rethrow;
    }
  }

  Future<MealPlan?> _fetchFromApiWithRetry(
    UserPreferences userPrefs,
    String? diet,
    List<String>? exclude,
    String? cuisine,
  ) async {
    for (int attempt = 1; attempt <= 3; attempt++) {
      try {
        final mealPlanData = await _spoonacularService.getDailyMealPlan(
          targetCalories: userPrefs.targetCalories,
          diet: diet,
          exclude: exclude,
          cuisine: cuisine,
          offset: DateTime.now().millisecondsSinceEpoch % 100,
        );

        if (mealPlanData['meals'] == null ||
            (mealPlanData['meals'] as List).isEmpty) {
          continue;
        }

        _apiFailureCount = 0; // Reset failure count on success
        return _createMealPlanFromData(mealPlanData, userPrefs);
      } catch (e) {
        print('API attempt $attempt failed: $e');
        if (attempt == 3) {
          _apiFailureCount++;
          rethrow;
        }
        await Future.delayed(Duration(seconds: attempt * 2));
      }
    }
    return null;
  }

  Future<MealPlan> _getFallbackMealPlan(UserPreferences userPrefs) async {
    final meals = <Meal>[];
    final mealTypes = ['breakfast', 'lunch', 'dinner'];

    for (final type in mealTypes) {
      final meal = await _localDb.getRandomMealByType(type) ??
          _getEmergencyFallbackMeal(type);
      meals.add(meal);
    }

    return MealPlan(
      meals: meals,
      nutrients: Nutrients(
        calories: userPrefs.targetCalories.toDouble(),
        protein: userPrefs.targetCalories * 0.8,
        fat: userPrefs.targetCalories * 0.3,
        carbohydrates: userPrefs.targetCalories * 0.5,
      ),
    );
  }

  Meal _getEmergencyFallbackMeal(String type) {
    // Emergency fallback meals when everything else fails
    final fallbacks = {
      'breakfast': Meal(
        id: -1,
        title: 'Basic Oatmeal with Fruits',
        readyInMinutes: 10,
        servings: 1,
        image: 'https://spoonacular.com/recipeImages/basic-oatmeal-bowl.jpg',
        type: 'breakfast',
        healthScore: 85,
        diets: ['vegetarian'],
      ),
      'lunch': Meal(
        id: -2,
        title: 'Mixed Green Salad with Protein',
        readyInMinutes: 15,
        servings: 1,
        image: 'https://spoonacular.com/recipeImages/mixed-green-salad.jpg',
        type: 'lunch',
        healthScore: 90,
        diets: ['gluten-free'],
      ),
      'dinner': Meal(
        id: -3,
        title: 'Grilled Chicken with Vegetables',
        readyInMinutes: 30,
        servings: 1,
        image:
            'https://spoonacular.com/recipeImages/grilled-chicken-vegetables.jpg',
        type: 'dinner',
        healthScore: 88,
        diets: ['gluten-free'],
      ),
    };

    return fallbacks[type]!;
  }

  MealPlan _createMealPlanFromData(
      Map<String, dynamic> mealPlanData, UserPreferences userPrefs) {
    final allMeals = (mealPlanData['meals'] as List).map((mealData) {
      return Meal(
        id: mealData['id'],
        title: mealData['title'],
        readyInMinutes: mealData['readyInMinutes'] ?? 30,
        servings: mealData['servings'] ?? 1,
        image: mealData['image'],
        diets: List<String>.from(mealData['diets'] ?? []),
        healthScore: mealData['healthScore']?.toDouble() ?? 80,
        type: null,
      );
    }).toList();

    final meals = <Meal>[];
    final mealTypes = ['breakfast', 'lunch', 'dinner'];

    for (var i = 0; i < mealTypes.length && i < allMeals.length; i++) {
      meals.add(allMeals[i].copyWith(type: mealTypes[i]));
    }

    return MealPlan(
      meals: meals,
      nutrients: Nutrients(
        calories: userPrefs.targetCalories.toDouble(),
        protein: userPrefs.targetCalories * 0.2,
        fat: userPrefs.targetCalories * 0.3,
        carbohydrates: userPrefs.targetCalories * 0.5,
      ),
    );
  }

  Future<void> saveMealPlan(MealPlan mealPlan, DateTime date) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final mealPlanKey = getMealPlanKey(date);

      // Get existing meal plan if any
      final existingPlanJson = prefs.getString(mealPlanKey);
      List<Meal> existingMeals = [];
      if (existingPlanJson != null) {
        try {
          final existingPlan = MealPlan.fromJson(json.decode(existingPlanJson));
          existingMeals = existingPlan.meals;
        } catch (e) {
          print('Error loading existing meal plan: $e');
        }
      }

      // Merge existing meals with new ones
      final meals = List<Meal>.from(mealPlan.meals);
      for (var existingMeal in existingMeals) {
        if (!meals.any(
            (m) => m.type?.toLowerCase() == existingMeal.type?.toLowerCase())) {
          meals.add(existingMeal);
        }
      }

      final updatedMealPlan = MealPlan(
        meals: meals,
        nutrients: mealPlan.nutrients,
      );

      await prefs.setString(mealPlanKey, json.encode(updatedMealPlan.toJson()));
    } catch (e) {
      print('Error saving meal plan: $e');
      throw Exception('Failed to save meal plan');
    }
  }

  Future<MealPlan> getMealsByType(
      String type, UserPreferences userPrefs) async {
    try {
      final mealPlanData = await _spoonacularService.getDailyMealPlan(
        targetCalories: userPrefs.targetCalories,
        diet: _getDietFromPreferences(userPrefs),
        exclude: _getExclusionsFromPreferences(userPrefs),
        cuisine: _getCuisineFromPreferences(userPrefs),
        mealType: type,
      );

      final meals = (mealPlanData['meals'] as List)
          .map((meal) => Meal.fromJson({...meal, 'type': type}))
          .toList();

      return MealPlan(
        meals: meals,
        nutrients: Nutrients(
            calories: userPrefs.targetCalories.toDouble() ?? 2000.0,
            protein: 0,
            fat: 0,
            carbohydrates: 0),
      );
    } catch (e) {
      debugPrint('Error getting meals by type: $e');
      // Return empty meal plan on error
      return MealPlan(
        meals: [],
        nutrients: Nutrients(
            calories: userPrefs.targetCalories.toDouble() ?? 2000.0,
            protein: 0,
            fat: 0,
            carbohydrates: 0),
      );
    }
  }

  Future<MealPlan> getMealPlan(UserPreferences preferences) async {
    try {
      final spoonacularService = SpoonacularService();
      final mealData = await spoonacularService.getAllMealTypes(
        targetCalories: preferences.targetCalories,
        diet: _getDietFromPreferences(preferences),
        exclude: _getExclusionsFromPreferences(preferences),
        cuisine: _getCuisineFromPreferences(preferences),
      );

      // Convert meals and tag them with their type
      final breakfast = (mealData['breakfast'] as List)
          .map((meal) => Meal.fromJson({...meal, 'type': 'breakfast'}))
          .toList();
      final lunch = (mealData['lunch'] as List)
          .map((meal) => Meal.fromJson({...meal, 'type': 'lunch'}))
          .toList();
      final dinner = (mealData['dinner'] as List)
          .map((meal) => Meal.fromJson({...meal, 'type': 'dinner'}))
          .toList();

      // Combine all meals into a single list
      final allMeals = [...breakfast, ...lunch, ...dinner];

      return MealPlan(
        meals: allMeals,
        nutrients: Nutrients(
            calories: preferences.targetCalories.toDouble() ?? 2000.0,
            protein: 0,
            fat: 0,
            carbohydrates: 0),
      );
    } catch (e) {
      debugPrint('Error getting meal plan: $e');
      return await _getLocalMealPlan(preferences);
    }
  }

  Future<MealPlan> _getLocalMealPlan(UserPreferences preferences) async {
    // Return an empty meal plan as fallback
    return MealPlan(
      meals: [],
      nutrients: Nutrients(
          calories: preferences.targetCalories.toDouble() ?? 2000.0,
          protein: 0,
          fat: 0,
          carbohydrates: 0),
    );
  }

  String? _getDietFromPreferences(UserPreferences prefs) {
    if (prefs.vegetarian) return 'vegetarian';
    if (prefs.vegan) return 'vegan';
    if (prefs.glutenFree) return 'gluten free';
    if (prefs.keto) return 'ketogenic';
    if (prefs.paleo) return 'paleo';
    if (prefs.lowCarb) return 'low carb';
    if (prefs.mediterranean) return 'mediterranean';
    return null;
  }

  List<String>? _getExclusionsFromPreferences(UserPreferences prefs) {
    final exclusions = [...prefs.excludedIngredients, ...prefs.allergies];
    return exclusions.isNotEmpty ? exclusions : null;
  }

  String? _getCuisineFromPreferences(UserPreferences prefs) {
    if (prefs.culturalPreferences.isEmpty) return null;
    // Map common cultural preferences to Spoonacular cuisine types
    final cuisineMap = {
      'indian': 'indian',
      'chinese': 'chinese',
      'mexican': 'mexican',
      'italian': 'italian',
      'japanese': 'japanese',
      'thai': 'thai',
      'mediterranean': 'mediterranean',
      'middle eastern': 'middle eastern',
      'korean': 'korean',
      'vietnamese': 'vietnamese',
      'greek': 'greek',
      'french': 'french',
    };

    // Return the first matching cuisine preference
    for (var pref in prefs.culturalPreferences) {
      final cuisine = cuisineMap[pref.toLowerCase()];
      if (cuisine != null) return cuisine;
    }
    return null;
  }

  bool _preferencesEqual(UserPreferences saved, UserPreferences current) {
    return saved.targetCalories == current.targetCalories &&
        saved.vegetarian == current.vegetarian &&
        saved.vegan == current.vegan &&
        saved.glutenFree == current.glutenFree &&
        saved.keto == current.keto &&
        saved.paleo == current.paleo &&
        saved.lowCarb == current.lowCarb &&
        saved.mediterranean == current.mediterranean &&
        saved.maxPrepTime == current.maxPrepTime &&
        _listEquals(saved.allergies, current.allergies) &&
        _listEquals(saved.excludedIngredients, current.excludedIngredients) &&
        _listEquals(saved.culturalPreferences, current.culturalPreferences);
  }

  bool _listEquals<T>(List<T> a, List<T> b) {
    if (identical(a, b)) return true;
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (!b.contains(a[i])) return false;
    }
    return true;
  }

  Future<void> clearSavedMealPlan([DateTime? date]) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (date != null) {
        await prefs.remove(getMealPlanKey(date));
      } else {
        final keys = prefs.getKeys();
        for (var key in keys) {
          if (key.startsWith(_mealPlanKeyPrefix)) {
            await prefs.remove(key);
          }
        }
      }
    } catch (e) {
      print('Error clearing meal plan: $e');
    }
  }
}

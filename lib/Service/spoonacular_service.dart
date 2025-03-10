import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class SpoonacularService {
  static const String _baseUrl = 'api.spoonacular.com';
  static const List<String> _apiKeys = [
    'e2df5d824fd048b38b1440ee39057ea7',
    '91585a75013e466da051216f0928c672',
    'b9e6952fb6464e07a572b80e4f723767',
    '6622e40befa646619520d16357e44df8'
  ];
  static int _currentKeyIndex = 0;

  String get _apiKey => _apiKeys[_currentKeyIndex];

  void _rotateApiKey() {
    _currentKeyIndex = (_currentKeyIndex + 1) % _apiKeys.length;
    debugPrint('Switching to API key: $_apiKey');
  }

  String getImageUrl(int id, String? imageType) {
    final type = imageType ?? 'jpg';
    return 'https://spoonacular.com/recipeImages/$id-636x393.$type';
  }

  // Get meal plan for a day
  Future<Map<String, dynamic>> getDailyMealPlan({
    int? targetCalories,
    String? diet,
    List<String>? exclude,
    String? mealType,
    String? cuisine,
    int offset = 0,
  }) async {
    for (int attempt = 0; attempt < _apiKeys.length; attempt++) {
      try {
        final queryParams = {
          'apiKey': _apiKey,
          'number': '15',
          'offset': offset.toString(),
          'addRecipeInformation': 'true',
          'sort': 'random',
          if (targetCalories != null) 'maxCalories': targetCalories.toString(),
          if (diet != null) ..._getDietParams(diet),
          if (exclude != null && exclude.isNotEmpty)
            'excludeIngredients': exclude.join(','),
          if (mealType != null) 'type': mealType.toLowerCase(),
          if (cuisine != null) 'cuisine': cuisine.toLowerCase(),
        };

        final uri = Uri.https(_baseUrl, '/recipes/complexSearch', queryParams);
        debugPrint('🌐 Making request to: $uri');

        final response = await http.get(
          uri,
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        );

        if (response.statusCode == 402) {
          debugPrint('API quota exceeded for key: $_apiKey');
          _rotateApiKey();
          continue;
        }

        if (response.statusCode != 200) {
          final errorBody = json.decode(response.body);
          debugPrint(
              'Error response: ${response.statusCode} - ${response.body}');
          throw Exception(
              'Failed to fetch meals: ${errorBody['message'] ?? 'Unknown error'}');
        }

        final data = json.decode(response.body);
        if (data['results'] == null || (data['results'] as List).isEmpty) {
          if (mealType != null) {
            return getDailyMealPlan(
              targetCalories: targetCalories,
              diet: diet,
              exclude: exclude,
              mealType: null,
              cuisine: cuisine,
              offset: offset,
            );
          }
          throw Exception('No meals found for the given criteria');
        }

        // Filter results to ensure they match dietary restrictions
        final results = (data['results'] as List).where((meal) {
          if (diet == 'vegetarian') {
            return meal['vegetarian'] == true;
          } else if (diet == 'vegan') {
            return meal['vegan'] == true;
          } else if (diet == 'gluten free') {
            return meal['glutenFree'] == true;
          }
          return true;
        }).toList();

        return {'meals': results};
      } catch (e) {
        debugPrint('Error in getDailyMealPlan: $e');
        if (attempt == _apiKeys.length - 1) {
          throw Exception('Failed to fetch meals: $e');
        }
        _rotateApiKey();
      }
    }
    throw Exception('All API keys exhausted');
  }

  Map<String, String> _getDietParams(String diet) {
    switch (diet.toLowerCase()) {
      case 'vegetarian':
        return {
          'diet': 'vegetarian',
          'vegetarian': 'true',
        };
      case 'vegan':
        return {
          'diet': 'vegan',
          'vegan': 'true',
        };
      case 'gluten free':
        return {
          'diet': 'gluten free',
          'glutenFree': 'true',
        };
      default:
        return {'diet': diet};
    }
  }

  // Get meals for each type (breakfast, lunch, dinner)
  Future<Map<String, dynamic>> getAllMealTypes({
    int? targetCalories,
    String? diet,
    List<String>? exclude,
    String? cuisine,
  }) async {
    try {
      final mealTypes = ['breakfast', 'lunch', 'dinner'];
      final results = await Future.wait(
        mealTypes.map((type) => getDailyMealPlan(
              targetCalories: targetCalories,
              diet: diet,
              exclude: exclude,
              mealType: type,
              cuisine: cuisine,
            )),
      );

      return {
        'breakfast': results[0]['meals'],
        'lunch': results[1]['meals'],
        'dinner': results[2]['meals'],
      };
    } catch (e) {
      debugPrint('Error in getAllMealTypes: $e');
      throw Exception('Failed to fetch all meal types: $e');
    }
  }

  Map<String, dynamic> getMockMealPlan({
    int? targetCalories,
  }) {
    return {
      "meals": [
        {
          "id": 655219,
          "title": "Peanut Butter And Chocolate Oatmeal",
          "readyInMinutes": 45,
          "servings": 1,
          "image": "https://spoonacular.com/recipeImages/655219-636x393.jpg",
          "diets": ["gluten free", "dairy free"],
          "healthScore": 100
        },
        {
          "id": 649931,
          "title": "Lentil Salad With Vegetables",
          "readyInMinutes": 45,
          "servings": 4,
          "image": "https://spoonacular.com/recipeImages/649931-636x393.jpg",
          "diets": [
            "gluten free",
            "dairy free",
            "lacto ovo vegetarian",
            "vegan"
          ],
          "healthScore": 100
        },
        {
          "id": 632935,
          "title": "Asparagus and Pea Soup: Real Convenience Food",
          "readyInMinutes": 20,
          "servings": 2,
          "image": "https://spoonacular.com/recipeImages/632935-636x393.jpg",
          "diets": [
            "gluten free",
            "dairy free",
            "lacto ovo vegetarian",
            "vegan"
          ],
          "healthScore": 100
        }
      ],
      "nutrients": {
        "calories": targetCalories ?? 2000,
        "protein": 100,
        "fat": 70,
        "carbohydrates": 250
      }
    };
  }

  // Get detailed nutrient information for a recipe
  Future<Map<String, dynamic>> getRecipeNutrition(int recipeId) async {
    try {
      final uri = Uri.https(
        _baseUrl,
        '/recipes/$recipeId/nutritionWidget.json',
        {'apiKey': _apiKey},
      );

      debugPrint('🌐 Making nutrition request to: $uri');

      final response = await http.get(
        uri,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      debugPrint('📥 Nutrition response status: ${response.statusCode}');
      debugPrint('📥 Nutrition response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        debugPrint('✅ Nutrition data: $data');
        return data;
      } else {
        final errorBody = json.decode(response.body);
        throw Exception(
            'Failed to load nutrition info: ${errorBody['message'] ?? response.body}');
      }
    } catch (e, stackTrace) {
      debugPrint('❌ Error in getRecipeNutrition: $e');
      debugPrint('Stack trace: $stackTrace');
      rethrow;
    }
  }

  // Search recipes with nutrition requirements
  Future<List<dynamic>> searchRecipes({
    required String query,
    int? minCalories,
    int? maxCalories,
    int? minProtein,
    int? maxProtein,
    int? number = 10,
  }) async {
    try {
      final queryParameters = {
        'apiKey': _apiKey,
        'query': query,
        'number': number.toString(),
      };

      if (minCalories != null)
        queryParameters['minCalories'] = minCalories.toString();
      if (maxCalories != null)
        queryParameters['maxCalories'] = maxCalories.toString();
      if (minProtein != null)
        queryParameters['minProtein'] = minProtein.toString();
      if (maxProtein != null)
        queryParameters['maxProtein'] = maxProtein.toString();

      final uri =
          Uri.https(_baseUrl, '/recipes/complexSearch', queryParameters);

      debugPrint('🌐 Making search request to: $uri');

      final response = await http.get(
        uri,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      debugPrint('📥 Search response status: ${response.statusCode}');
      debugPrint('📥 Search response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        debugPrint('✅ Search data: $data');
        if (!data.containsKey('results')) {
          throw Exception('Missing results key in response');
        }
        return data['results'] as List<dynamic>;
      } else {
        final errorBody = json.decode(response.body);
        throw Exception(
            'Failed to search recipes: ${errorBody['message'] ?? response.body}');
      }
    } catch (e, stackTrace) {
      debugPrint('❌ Error in searchRecipes: $e');
      debugPrint('Stack trace: $stackTrace');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getRecipeDetails(int recipeId) async {
    try {
      final uri = Uri.https(
        _baseUrl,
        '/recipes/$recipeId/information',
        {
          'apiKey': _apiKey,
          'includeNutrition': 'true',
        },
      );

      debugPrint('🌐 Making recipe details request to: $uri');

      final response = await http.get(
        uri,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      debugPrint('📥 Recipe details response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        debugPrint('✅ Recipe details data received');
        return data;
      } else if (response.statusCode == 402) {
        _rotateApiKey();
        return getRecipeDetails(recipeId);
      } else {
        throw Exception('Failed to fetch recipe details');
      }
    } catch (e) {
      debugPrint('❌ Error fetching recipe details: $e');
      throw Exception('Failed to fetch recipe details: $e');
    }
  }
}

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

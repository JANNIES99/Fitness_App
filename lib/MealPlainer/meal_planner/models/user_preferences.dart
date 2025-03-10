import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static const String _prefsKey = 'user_preferences';
  
  final int targetCalories;
  final bool vegetarian;
  final bool vegan;
  final bool glutenFree;
  final bool keto;
  final bool paleo;
  final bool lowCarb;
  final bool mediterranean;
  final List<String> allergies;
  final List<String> excludedIngredients;
  final List<String> culturalPreferences;
  final int maxPrepTime;

  UserPreferences({
    this.targetCalories = 2000,
    this.vegetarian = false,
    this.vegan = false,
    this.glutenFree = false,
    this.keto = false,
    this.paleo = false,
    this.lowCarb = false,
    this.mediterranean = false,
    List<String>? allergies,
    List<String>? excludedIngredients,
    List<String>? culturalPreferences,
    this.maxPrepTime = 60,
  })  : allergies = List<String>.from(allergies ?? []),
        excludedIngredients = List<String>.from(excludedIngredients ?? []),
        culturalPreferences = List<String>.from(culturalPreferences ?? []);

  Map<String, dynamic> toJson() {
    return {
      'targetCalories': targetCalories,
      'vegetarian': vegetarian,
      'vegan': vegan,
      'glutenFree': glutenFree,
      'keto': keto,
      'paleo': paleo,
      'lowCarb': lowCarb,
      'mediterranean': mediterranean,
      'allergies': allergies,
      'excludedIngredients': excludedIngredients,
      'culturalPreferences': culturalPreferences,
      'maxPrepTime': maxPrepTime,
    };
  }

  factory UserPreferences.fromJson(Map<String, dynamic> json) {
    return UserPreferences(
      targetCalories: json['targetCalories'] as int? ?? 2000,
      vegetarian: json['vegetarian'] as bool? ?? false,
      vegan: json['vegan'] as bool? ?? false,
      glutenFree: json['glutenFree'] as bool? ?? false,
      keto: json['keto'] as bool? ?? false,
      paleo: json['paleo'] as bool? ?? false,
      lowCarb: json['lowCarb'] as bool? ?? false,
      mediterranean: json['mediterranean'] as bool? ?? false,
      allergies: List<String>.from(json['allergies'] ?? []),
      excludedIngredients: List<String>.from(json['excludedIngredients'] ?? []),
      culturalPreferences: List<String>.from(json['culturalPreferences'] ?? []),
      maxPrepTime: json['maxPrepTime'] as int? ?? 60,
    );
  }

  static Future<UserPreferences> load() async {
    final prefs = await SharedPreferences.getInstance();
    final String? prefsJson = prefs.getString(_prefsKey);
    
    if (prefsJson != null) {
      try {
        return UserPreferences.fromJson(json.decode(prefsJson));
      } catch (e) {
        print('Error loading preferences: $e');
      }
    }
    
    return UserPreferences();
  }

  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsKey, json.encode(toJson()));
  }

  UserPreferences copyWith({
    int? targetCalories,
    bool? vegetarian,
    bool? vegan,
    bool? glutenFree,
    bool? keto,
    bool? paleo,
    bool? lowCarb,
    bool? mediterranean,
    List<String>? allergies,
    List<String>? excludedIngredients,
    List<String>? culturalPreferences,
    int? maxPrepTime,
  }) {
    return UserPreferences(
      targetCalories: targetCalories ?? this.targetCalories,
      vegetarian: vegetarian ?? this.vegetarian,
      vegan: vegan ?? this.vegan,
      glutenFree: glutenFree ?? this.glutenFree,
      keto: keto ?? this.keto,
      paleo: paleo ?? this.paleo,
      lowCarb: lowCarb ?? this.lowCarb,
      mediterranean: mediterranean ?? this.mediterranean,
      allergies: allergies ?? List<String>.from(this.allergies),
      excludedIngredients: excludedIngredients ?? List<String>.from(this.excludedIngredients),
      culturalPreferences: culturalPreferences ?? List<String>.from(this.culturalPreferences),
      maxPrepTime: maxPrepTime ?? this.maxPrepTime,
    );
  }
}

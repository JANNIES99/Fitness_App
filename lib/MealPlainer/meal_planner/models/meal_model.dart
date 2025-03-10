import 'nutrients.dart';

class MealPlan {
  final List<Meal> meals;
  final Nutrients nutrients;

  MealPlan({
    required this.meals,
    required this.nutrients,
  });

  Map<String, dynamic> toJson() {
    return {
      'meals': meals.map((meal) => meal.toJson()).toList(),
      'nutrients': nutrients.toJson(),
    };
  }

  factory MealPlan.fromJson(Map<String, dynamic> json) {
    return MealPlan(
      meals: (json['meals'] as List)
          .map((mealJson) => Meal.fromJson(mealJson as Map<String, dynamic>))
          .toList(),
      nutrients: Nutrients.fromJson(json['nutrients'] as Map<String, dynamic>),
    );
  }

  MealPlan copyWith({
    List<Meal>? meals,
    Nutrients? nutrients,
  }) {
    return MealPlan(
      meals: meals ?? this.meals,
      nutrients: nutrients ?? this.nutrients,
    );
  }
}

class Meal {
  final int id;
  final String title;
  final int readyInMinutes;
  final int servings;
  final String? image;
  final List<String> diets;
  final int healthScore;
  final String? type;

  Meal({
    required this.id,
    required this.title,
    required this.readyInMinutes,
    required this.servings,
    this.image,
    required this.diets,
    required this.healthScore,
    this.type,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'readyInMinutes': readyInMinutes,
      'servings': servings,
      'image': image,
      'diets': diets,
      'healthScore': healthScore,
      'type': type,
    };
  }

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      readyInMinutes: (json['readyInMinutes'] as num).toInt(),
      servings: (json['servings'] as num).toInt(),
      image: json['image'] as String?,
      diets: (json['diets'] as List<dynamic>).map((e) => e as String).toList(),
      healthScore: (json['healthScore'] as num).toInt(),
      type: json['type'] as String?,
    );
  }

  Meal copyWith({
    int? id,
    String? title,
    int? readyInMinutes,
    int? servings,
    String? image,
    List<String>? diets,
    int? healthScore,
    String? type,
  }) {
    return Meal(
      id: id ?? this.id,
      title: title ?? this.title,
      readyInMinutes: readyInMinutes ?? this.readyInMinutes,
      servings: servings ?? this.servings,
      image: image ?? this.image,
      diets: diets ?? this.diets,
      healthScore: healthScore ?? this.healthScore,
      type: type ?? this.type,
    );
  }
}

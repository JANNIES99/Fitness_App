class Nutrients {
  final double calories;
  final double protein;
  final double fat;
  final double carbohydrates;

  Nutrients({
    required this.calories,
    required this.protein,
    required this.fat,
    required this.carbohydrates,
  });

  Map<String, dynamic> toJson() {
    return {
      'calories': calories,
      'protein': protein,
      'fat': fat,
      'carbohydrates': carbohydrates,
    };
  }

  factory Nutrients.fromJson(Map<String, dynamic> json) {
    return Nutrients(
      calories: json['calories']?.toDouble() ?? 2000,
      protein: json['protein']?.toDouble() ?? 100,
      fat: json['fat']?.toDouble() ?? 70,
      carbohydrates: json['carbohydrates']?.toDouble() ?? 250,
    );
  }
}

import 'package:flutter/material.dart';
import '../common/colo_extension.dart';
import '../meal_planner/models/meal_model.dart';

class MealFoodScheduleRow extends StatelessWidget {
  final Meal meal;

  const MealFoodScheduleRow({
    super.key,
    required this.meal,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              meal.image ?? 'assets/images/meal_placeholder.jpg',
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 50,
                  height: 50,
                  color: TColor.lightGray,
                  child: Icon(Icons.restaurant, color: TColor.gray),
                );
              },
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  meal.title,
                  style: TextStyle(
                    color: TColor.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.timer_outlined, size: 16, color: TColor.gray),
                    const SizedBox(width: 4),
                    Text(
                      '${meal.readyInMinutes} min',
                      style: TextStyle(
                        color: TColor.gray,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(Icons.person_outline, size: 16, color: TColor.gray),
                    const SizedBox(width: 4),
                    Text(
                      '${meal.servings} servings',
                      style: TextStyle(
                        color: TColor.gray,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
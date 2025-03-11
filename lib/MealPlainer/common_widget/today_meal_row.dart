import '../common/colo_extension.dart';
import 'package:flutter/material.dart';

import '../meal_planner/models/meal_model.dart';
import '../meal_planner/meal_food_details_view.dart';

class TodayMealRow extends StatelessWidget {
  final Meal meal;
  const TodayMealRow({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (meal.id != 0) {
          // Only navigate if it's a real meal
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MealFoodDetailsView(meal: meal),
            ),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: TColor.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 2)],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: meal.image != null && meal.image!.isNotEmpty
                  ? Image.network(
                      meal.image!,
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          _buildPlaceholderIcon(),
                    )
                  : _buildPlaceholderIcon(),
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
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (meal.id != 0) // Only show details for real meals
                    Text(
                      "${meal.readyInMinutes} mins • ${meal.servings} servings",
                      style: TextStyle(
                        color: TColor.gray,
                        fontSize: 10,
                      ),
                    ),
                ],
              ),
            ),
            if (meal.id != 0) // Only show notification icon for real meals
              IconButton(
                onPressed: () {},
                icon: Image.asset(
                  "images/Diet/bell.png",
                  width: 25,
                  height: 25,
                ),
              )
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholderIcon() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: TColor.lightGray,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Icon(Icons.restaurant, color: TColor.gray, size: 20),
    );
  }
}

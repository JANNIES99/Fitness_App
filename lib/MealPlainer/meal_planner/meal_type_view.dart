import 'package:flutter/material.dart';
import '../common/colo_extension.dart';
import 'models/meal_model.dart';  // This has both Meal and MealPlan
import 'models/user_preferences.dart';
import 'services/meal_service.dart';

class MealTypeView extends StatefulWidget {
  final String mealType;
  final Function(Meal) onMealSelected;

  const MealTypeView({
    super.key,
    required this.mealType,
    required this.onMealSelected,
  });

  @override
  State<MealTypeView> createState() => _MealTypeViewState();
}

class _MealTypeViewState extends State<MealTypeView> {
  final MealService _mealService = MealService();
  bool _isLoading = true;
  List<Meal> _meals = [];
  Meal? _selectedMeal;

  @override
  void initState() {
    super.initState();
    _loadMeals();
  }

  Future<void> _loadMeals() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final userPrefs = await UserPreferences.load();
      final mealPlan = await _mealService.getMealsByType(
        widget.mealType.toLowerCase(),
        userPrefs,
      );
      setState(() {
        _meals = mealPlan.meals;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading meals: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColor.white,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: TColor.black,
            size: 20,
          ),
        ),
        title: Text(
          "${widget.mealType} Options",
          style: TextStyle(
            color: TColor.black,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          if (_selectedMeal != null)
            TextButton(
              onPressed: () {
                widget.onMealSelected(_selectedMeal!);
              },
              child: Text(
                "Save",
                style: TextStyle(
                  color: TColor.primaryColor1,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: _meals.length,
              itemBuilder: (context, index) {
                final meal = _meals[index];
                final isSelected = _selectedMeal?.id == meal.id;

                return Card(
                  elevation: isSelected ? 4 : 1,
                  margin: const EdgeInsets.only(bottom: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(
                      color: isSelected ? TColor.primaryColor1 : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _selectedMeal = meal;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        children: [
                          if (meal.image != null)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                meal.image!,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 80,
                                    height: 80,
                                    color: TColor.lightGray,
                                    child: Icon(
                                      Icons.restaurant,
                                      color: TColor.gray,
                                      size: 40,
                                    ),
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
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'Ready in ${meal.readyInMinutes} minutes • ${meal.servings} servings',
                                  style: TextStyle(
                                    color: TColor.gray,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                if (meal.diets.isNotEmpty)
                                  Text(
                                    meal.diets.join(', '),
                                    style: TextStyle(
                                      color: TColor.primaryColor1,
                                      fontSize: 12,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

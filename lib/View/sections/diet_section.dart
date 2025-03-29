import 'package:flutter/material.dart';
import 'package:fitnessapp/MealPlainer/meal_planner/meal_schedule_view.dart';
import 'package:fitnessapp/MealPlainer/common/colo_extension.dart';
import 'package:fitnessapp/MealPlainer/common_widget/today_meal_row.dart';
import 'package:fitnessapp/MealPlainer/meal_planner/models/meal_model.dart';
import 'package:fitnessapp/MealPlainer/meal_planner/models/user_preferences.dart';
import 'package:fitnessapp/MealPlainer/meal_planner/widgets/preferences_dialog.dart';
import 'package:fitnessapp/MealPlainer/meal_planner/services/meal_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DietSection extends StatefulWidget {
  const DietSection({super.key});

  @override
  State<DietSection> createState() => _DietSectionState();
}

class _DietSectionState extends State<DietSection> {
  final MealService _mealService = MealService();
  MealPlan? _mealPlan;
  bool _isLoading = false;
  String? _error;
  Set<int> favoriteMeals = {};
  late UserPreferences _userPreferences;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    _userPreferences = await UserPreferences.load();
    _loadMealPlan();
    _loadFavorites();
  }

  Future<void> _showPreferencesDialog() async {
    await showDialog(
      context: context,
      builder: (context) => PreferencesDialog(
        preferences: _userPreferences,
        onSave: (preferences) async {
          setState(() {
            _userPreferences = preferences;
            _isLoading = true;
          });
          await preferences.save();
          await _loadMealPlan(true); 
        },
      ),
    );
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList('favorite_meals');
    if (favorites != null) {
      setState(() {
        favoriteMeals = favorites.map((s) => int.parse(s)).toSet();
      });
    }
  }

  Future<void> _loadMealPlan([bool forceRefresh = false]) async {
    if (!mounted) return;

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final mealPlan =
          await _mealService.getDailyMealPlan(DateTime.now(), forceRefresh);
      if (mounted) {
        setState(() {
          _mealPlan = mealPlan;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = 'Failed to load meal plan. Please try again.';
          _isLoading = false;
        });
      }
    }
  }

  Widget _buildNutritionCard() {
    if (_mealPlan == null) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: TColor.primaryColor2.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Daily Nutrition',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: TColor.black,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNutrientInfo(
                  'Calories', '${_mealPlan!.nutrients.calories.round()} kcal'),
              _buildNutrientInfo(
                  'Protein', '${_mealPlan!.nutrients.protein.round()}g'),
              _buildNutrientInfo(
                  'Carbs', '${_mealPlan!.nutrients.carbohydrates.round()}g'),
              _buildNutrientInfo('Fat', '${_mealPlan!.nutrients.fat.round()}g'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNutrientInfo(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: TColor.primaryColor2,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: TColor.gray,
          ),
        ),
      ],
    );
  }

  Widget _buildMealsList() {
    if (_mealPlan == null || _mealPlan!.meals.isEmpty) {
      return const Center(
        child: Text('No meals available for today'),
      );
    }

    final mealTypes = ['breakfast', 'lunch', 'dinner'];
    final sortedMeals = <Meal>[];

    for (var type in mealTypes) {
      try {
        final meal = _mealPlan!.meals.firstWhere(
          (meal) => meal.type?.toLowerCase() == type,
          orElse: () => Meal(
            id: 0,
            title: 'No $type planned',
            readyInMinutes: 0,
            servings: 0,
            type: type,
            diets: [],
            healthScore: 0,
            image: null,
          ),
        );
        sortedMeals.add(meal);
      } catch (e) {
        print('Error processing meal type $type: $e');
        sortedMeals.add(Meal(
          id: 0,
          title: 'No $type planned',
          readyInMinutes: 0,
          servings: 0,
          type: type,
          diets: [],
          healthScore: 0,
          image: null,
        ));
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: sortedMeals.map((meal) => TodayMealRow(meal: meal)).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : _error != null
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        const Spacer(),
                        IconButton(
                          icon:
                              Icon(Icons.settings, color: TColor.primaryColor2),
                          onPressed: _showPreferencesDialog,
                        ),
                        IconButton(
                          onPressed: () => _loadMealPlan(true),
                          icon: Icon(
                            Icons.refresh,
                            color: TColor.primaryColor2,
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      'Error loading meal plan',
                      style: TextStyle(fontSize: 18, color: Colors.red),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _error!,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _loadMealPlan,
                      child: const Text('Retry'),
                    ),
                    const Spacer(),
                    const Center(
                      child: Text(
                        "Weight Gain:3100 calories Weight Loss:2100 calories",
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      ),
                    )
                  ],
                ),
              )
            : _mealPlan == null
                ? const Center(child: Text('No meal plan available'))
                : RefreshIndicator(
                    onRefresh: _loadMealPlan,
                    child: ListView(
                      padding: const EdgeInsets.all(16),
                      children: [
                        _buildNutritionCard(),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      MealScheduleView(mealPlan: _mealPlan!),
                                ),
                              );
                            },
                            icon: const Icon(Icons.calendar_today, size: 28),
                            label: const Text(
                              'Daily Schedule',
                              style: TextStyle(fontSize: 20),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: TColor.primaryColor2,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'Today\'s Meals',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildMealsList(),
                        const SizedBox(
                          height: 20,
                        ),
                        const Center(
                          child: Text(
                            "Weight Gain:3100 calories Weight Loss:2100 calories",
                            style: TextStyle(color: Colors.black, fontSize: 12),
                          ),
                        )
                      ],
                    ),
                  );
  }
}

import 'package:flutter/material.dart';
import 'package:calendar_agenda/calendar_agenda.dart';
import '../common/colo_extension.dart';
import '../common_widget/meal_food_schedule_row.dart';
import 'models/meal_model.dart';
import 'models/nutrients.dart';
import 'models/user_preferences.dart';
import 'services/meal_service.dart';
import 'widgets/preferences_dialog.dart';

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

class MealScheduleView extends StatefulWidget {
  final MealPlan? mealPlan;
  const MealScheduleView({super.key, this.mealPlan});

  @override
  State<MealScheduleView> createState() => _MealScheduleViewState();
}

class _MealScheduleViewState extends State<MealScheduleView> {
  final CalendarAgendaController _calendarAgendaControllerAppBar =
      CalendarAgendaController();

  DateTime _selectedDateAppBBar = DateTime.now();

  final MealService _mealService = MealService();
  MealPlan? _currentMealPlan;
  bool _isLoading = true;

  // Nutrition values
  late double calories;
  late double protein;
  late double fat;
  late double carbs;

  @override
  void initState() {
    super.initState();
    // Initialize nutrition values
    calories = 0;
    protein = 0;
    fat = 0;
    carbs = 0;
    _loadInitialMealPlan();
  }

  void _updateNutritionValues() {
    if (_currentMealPlan != null) {
      setState(() {
        calories = _currentMealPlan!.nutrients.calories;
        protein = _currentMealPlan!.nutrients.protein;
        fat = _currentMealPlan!.nutrients.fat;
        carbs = _currentMealPlan!.nutrients.carbohydrates;
      });
    }
  }

  Future<void> _loadInitialMealPlan() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Load or create meal plan
      await _loadMealPlan(_selectedDateAppBBar);

      // If no meals exist, generate random meals for each type
      if (_currentMealPlan == null || _currentMealPlan!.meals.isEmpty) {
        DateTime nextDay = DateTime(_selectedDateAppBBar.day,
            _selectedDateAppBBar.month, _selectedDateAppBBar.day + 1 % 28);
        await _loadMealPlan(nextDay);
      }

      if (_currentMealPlan == null || _currentMealPlan!.meals.isEmpty) {
        await _generateRandomMeals();
      }

      _updateNutritionValues();
    } catch (e) {
      print('Error loading initial meal plan: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _generateRandomMeals() async {
    try {
      final userPrefs = await UserPreferences.load();
      final mealTypes = ['breakfast', 'lunch', 'dinner'];
      final meals = <Meal>[];

      for (var type in mealTypes) {
        try {
          final mealPlan = await _mealService.getMealsByType(type, userPrefs);
          if (mealPlan.meals.isNotEmpty) {
            final randomMeal =
                mealPlan.meals[0]; // Get the first meal as it's already random
            meals.add(randomMeal.copyWith(type: type));
          }
        } catch (e) {
          print('Error generating random meal for $type: $e');
        }
      }

      if (meals.isNotEmpty) {
        final mealPlan = MealPlan(
          meals: meals,
          nutrients: Nutrients(
            calories: userPrefs.targetCalories.toDouble(),
            protein: userPrefs.targetCalories * 0.25,
            fat: userPrefs.targetCalories * 0.3,
            carbohydrates: userPrefs.targetCalories * 0.5,
          ),
        );

        await _mealService.saveMealPlan(mealPlan, _selectedDateAppBBar);
        if (mounted) {
          setState(() {
            _currentMealPlan = mealPlan;
          });
        }
      }
    } catch (e) {
      print('Error generating random meals: $e');
    }
  }

  Future<void> _loadMealPlan(DateTime date, {bool forceRefresh = false}) async {
    if (mounted) {
      setState(() {
        _isLoading = true;
      });
    }

    try {
      final mealPlan = await _mealService.getDailyMealPlan(date, forceRefresh);
      if (mounted) {
        setState(() {
          _currentMealPlan = mealPlan;
          _updateNutritionValues();
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error loading meal plan: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to load meal plan: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _showMealTypeView(String mealType) async {
    try {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      // Get meal recommendations
      final recommendations = await _getMealRecommendations(mealType);

      // Hide loading indicator
      Navigator.pop(context);

      if (!mounted) return;

      // Show recommendations dialog
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Select ${mealType.capitalize()}'),
          content: SizedBox(
            width: double.maxFinite,
            child: recommendations.isEmpty
                ? const Center(
                    child:
                        Text('No meals found. Try adjusting your preferences.'),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: recommendations.length,
                    itemBuilder: (context, index) {
                      final meal = recommendations[index];
                      return ListTile(
                        title: Text(meal.title),
                        subtitle: Text(
                          'Ready in ${meal.readyInMinutes} mins • ${meal.diets.join(", ")}',
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          _selectMeal(meal, mealType);
                        },
                      );
                    },
                  ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
          ],
        ),
      );
    } catch (e) {
      print('Error showing meal type view: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading meals: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<List<Meal>> _getMealRecommendations(String mealType) async {
    try {
      final userPrefs = await UserPreferences.load();
      final mealPlan = await _mealService.getMealsByType(mealType, userPrefs);
      return mealPlan.meals;
    } catch (e) {
      print('Error getting meal recommendations: $e');
      return [];
    }
  }

  // void _showFullMealTypeView(String mealType) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => MealTypeView(
  //         mealType: mealType,
  //         onMealSelected: (meal) async {
  //           Navigator.pop(context);
  //           await _selectMeal(meal, mealType);
  //         },
  //       ),
  //     ),
  //   );
  // }

  Future<void> _selectMeal(Meal meal, String mealType) async {
    try {
      await _updateAndSaveMealPlan(meal, mealType);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Added ${meal.title} to your $mealType'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to save meal selection'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _updateAndSaveMealPlan(
      Meal selectedMeal, String mealType) async {
    _currentMealPlan ??= MealPlan(
      meals: [],
      nutrients: Nutrients(
        calories: 2000,
        protein: 400,
        fat: 600,
        carbohydrates: 1000,
      ),
    );

    // Create a new list with existing meals
    final meals = List<Meal>.from(_currentMealPlan!.meals);

    // Prepare the new meal with correct type
    final mealWithType = selectedMeal.copyWith(type: mealType.toLowerCase());

    // Find and replace or add the meal
    final existingIndex = meals.indexWhere(
      (m) => m.type?.toLowerCase() == mealType.toLowerCase(),
    );

    if (existingIndex != -1) {
      meals[existingIndex] = mealWithType;
    } else {
      meals.add(mealWithType);
    }

    // Create updated meal plan
    final updatedMealPlan = _currentMealPlan!.copyWith(meals: meals);

    try {
      // Save to storage
      await _mealService.saveMealPlan(updatedMealPlan, _selectedDateAppBBar);

      // Update state without refreshing
      if (mounted) {
        setState(() {
          _currentMealPlan = updatedMealPlan;
        });
      }
    } catch (e) {
      print('Error saving meal plan: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to save meal plan: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Widget _buildNutrientInfo(String label, String value, String unit) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            color: TColor.gray,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: TColor.black,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          unit,
          style: TextStyle(
            color: TColor.gray,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  // String _getMealTime(Meal meal) {
  //   // Simple logic to assign times based on meal order
  //   final index = _currentMealPlan!.meals.indexOf(meal);
  //   switch (index) {
  //     case 0:
  //       return '8:00 AM';
  //     case 1:
  //       return '1:00 PM';
  //     case 2:
  //       return '7:00 PM';
  //     default:
  //       return '${index + 8}:00';
  //   }
  // }

  void _showPreferencesDialog() async {
    final userPrefs = await UserPreferences.load();
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => PreferencesDialog(
        preferences: userPrefs,
        onSave: (prefs) async {
          await prefs.save();
          await _mealService.clearSavedMealPlan();
        },
      ),
    );

    if (result == true && mounted) {
      await _loadMealPlan(_selectedDateAppBBar, forceRefresh: true);
    }
  }

  Widget _buildMealTypeCard(String title, VoidCallback onTap) {
    final mealType = title.toLowerCase();
    final meal = _currentMealPlan?.meals.firstWhere(
      (m) => m.type?.toLowerCase() == mealType,
      orElse: () => Meal(
        id: 0,
        title: "",
        readyInMinutes: 0,
        servings: 0,
        diets: [],
        healthScore: 0,
      ),
    );

    IconData iconData;
    switch (mealType) {
      case 'breakfast':
        iconData = Icons.free_breakfast;
        break;
      case 'lunch':
        iconData = Icons.lunch_dining;
        break;
      case 'dinner':
        iconData = Icons.dinner_dining;
        break;
      default:
        iconData = Icons.restaurant;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: TColor.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(
              iconData,
              size: 40,
              color: TColor.primaryColor2,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                color: TColor.black,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (meal?.title.isNotEmpty == true) ...[
              const SizedBox(height: 4),
              Text(
                meal!.title,
                style: TextStyle(
                  color: TColor.gray,
                  fontSize: 12,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColor.white,
        centerTitle: true,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
              margin: const EdgeInsets.all(8),
              height: 40,
              width: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: TColor.lightGray,
                  borderRadius: BorderRadius.circular(10)),
              child: const Icon(Icons.arrow_back_rounded)),
        ),
        title: Text(
          "Meal Schedule",
          style: TextStyle(
              color: TColor.black, fontSize: 16, fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            onPressed: _showPreferencesDialog,
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: TColor.lightGray,
                  borderRadius: BorderRadius.circular(10)),
              child: Icon(
                Icons.settings,
                size: 20,
                color: TColor.primaryColor2,
              ),
            ),
          ),
          IconButton(
            onPressed: () async {
              if (mounted) {
                setState(() {
                  _isLoading = true;
                });
              }
              try {
                await _loadMealPlan(_selectedDateAppBBar);
              } catch (e) {
                print('Error refreshing meals: $e');
              } finally {
                if (mounted) {
                  setState(() {
                    _isLoading = false;
                  });
                }
              }
            },
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: TColor.lightGray,
                  borderRadius: BorderRadius.circular(10)),
              child: _isLoading
                  ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(TColor.primaryColor2),
                      ),
                    )
                  : Icon(
                      Icons.refresh_rounded,
                      size: 20,
                      color: TColor.primaryColor2,
                    ),
            ),
          )
        ],
      ),
      backgroundColor: TColor.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: TColor.white,
              boxShadow: [
                BoxShadow(
                  color: TColor.gray.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: CalendarAgenda(
              controller: _calendarAgendaControllerAppBar,
              appbar: false,
              selectedDayPosition: SelectedDayPosition.center,
              // leading: IconButton(
              //     onPressed: () {}, icon: const Icon(Icons.arrow_back_rounded)),
              // training: IconButton(
              //     onPressed: () {},
              //     icon: const Icon(Icons.arrow_forward_rounded)),
              weekDay: WeekDay.short,
              dayNameFontSize: 12,
              dayNumberFontSize: 16,
              dayBGColor: TColor.lightGray,
              titleSpaceBetween: 15,
              backgroundColor: Colors.transparent,
              fullCalendarScroll: FullCalendarScroll.horizontal,
              fullCalendarDay: WeekDay.short,
              selectedDateColor: Colors.white,
              dateColor: TColor.black,
              locale: 'en',
              initialDate: DateTime.now(),
              calendarEventColor: TColor.primaryColor2,
              firstDate: DateTime.now().subtract(const Duration(days: 140)),
              lastDate: DateTime.now().add(const Duration(days: 60)),
              onDateSelected: (date) async {
                setState(() {
                  _selectedDateAppBBar = date;
                  _isLoading = true;
                });

                try {
                  // Force refresh when selecting a new date to ensure we get different meals
                  await _loadMealPlan(date, forceRefresh: true);
                } catch (e) {
                  print('Error loading meal plan for date: $e');
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Failed to load meal plan: $e'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                } finally {
                  if (mounted) {
                    setState(() {
                      _isLoading = false;
                    });
                  }
                }
              },
              selectedDayLogo: Container(
                width: double.maxFinite,
                height: double.maxFinite,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: TColor.primaryG,
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                TColor.primaryColor2.withOpacity(0.3),
                                TColor.primaryColor1.withOpacity(0.3),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Daily Nutrition",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: TColor.black,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: TColor.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.timer,
                                          size: 14,
                                          color: TColor.primaryColor2,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          "Today",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: TColor.primaryColor2,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              if (_currentMealPlan != null)
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    _buildNutrientInfo(
                                      "Calories",
                                      _currentMealPlan!.nutrients.calories
                                          .toStringAsFixed(0),
                                      "kCal",
                                    ),
                                    _buildNutrientInfo(
                                      "Protein",
                                      _currentMealPlan!.nutrients.protein
                                          .toStringAsFixed(1),
                                      "g",
                                    ),
                                    _buildNutrientInfo(
                                      "Fat",
                                      _currentMealPlan!.nutrients.fat
                                          .toStringAsFixed(1),
                                      "g",
                                    ),
                                    _buildNutrientInfo(
                                      "Carbs",
                                      _currentMealPlan!.nutrients.carbohydrates
                                          .toStringAsFixed(1),
                                      "g",
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Text(
                              "Meal Types",
                              style: TextStyle(
                                color: TColor.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Container(
                                height: 1,
                                color: TColor.gray.withOpacity(0.3),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            Expanded(
                              child: _buildMealTypeCard(
                                "Breakfast",
                                () {
                                  _showMealTypeView("Breakfast");
                                },
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: _buildMealTypeCard(
                                "Lunch",
                                () {
                                  _showMealTypeView("Lunch");
                                },
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: _buildMealTypeCard(
                                "Dinner",
                                () {
                                  _showMealTypeView("Dinner");
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Builder(
                          builder: (context) {
                            if (_isLoading) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }

                            if (_currentMealPlan == null) {
                              return const Center(
                                  child: Text('No meal plan available'));
                            }

                            return Column(
                              children: [
                                // Breakfast Section
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Breakfast",
                                          style: TextStyle(
                                            color: TColor.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Container(
                                            height: 1,
                                            color: TColor.gray.withOpacity(0.3),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    _currentMealPlan!.meals.any((m) =>
                                            m.type?.toLowerCase() ==
                                            'breakfast')
                                        ? MealFoodScheduleRow(
                                            meal: _currentMealPlan!.meals
                                                .firstWhere(
                                              (m) =>
                                                  m.type?.toLowerCase() ==
                                                  'breakfast',
                                            ),
                                          )
                                        : const Text('No breakfast selected'),
                                  ],
                                ),

                                // Lunch Section
                                const SizedBox(height: 15),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Lunch",
                                          style: TextStyle(
                                            color: TColor.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Container(
                                            height: 1,
                                            color: TColor.gray.withOpacity(0.3),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    _currentMealPlan!.meals.any((m) =>
                                            m.type?.toLowerCase() == 'lunch')
                                        ? MealFoodScheduleRow(
                                            meal: _currentMealPlan!.meals
                                                .firstWhere(
                                              (m) =>
                                                  m.type?.toLowerCase() ==
                                                  'lunch',
                                            ),
                                          )
                                        : const Text('No lunch selected'),
                                  ],
                                ),

                                // Dinner Section
                                const SizedBox(height: 15),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Dinner",
                                          style: TextStyle(
                                            color: TColor.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Container(
                                            height: 1,
                                            color: TColor.gray.withOpacity(0.3),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    _currentMealPlan!.meals.any((m) =>
                                            m.type?.toLowerCase() == 'dinner')
                                        ? MealFoodScheduleRow(
                                            meal: _currentMealPlan!.meals
                                                .firstWhere(
                                              (m) =>
                                                  m.type?.toLowerCase() ==
                                                  'dinner',
                                            ),
                                          )
                                        : const Text('No dinner selected'),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

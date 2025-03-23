import 'package:flutter/material.dart';
import '../common/colo_extension.dart';
import 'models/meal_model.dart';
import 'package:fitnessapp/Service/spoonacular_service.dart';
import 'package:flutter_html/flutter_html.dart';

class MealFoodDetailsView extends StatefulWidget {
  final Meal meal;

  const MealFoodDetailsView({
    super.key,
    required this.meal,
  });

  @override
  State<MealFoodDetailsView> createState() => _MealFoodDetailsViewState();
}

class _MealFoodDetailsViewState extends State<MealFoodDetailsView> {
  final SpoonacularService _spoonacularService = SpoonacularService();
  Map<String, dynamic>? _recipeDetails;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadRecipeDetails();
  }

  Future<void> _loadRecipeDetails() async {
    try {
      final details =
          await _spoonacularService.getRecipeDetails(widget.meal.id);
      setState(() {
        _recipeDetails = details;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: TColor.white,
            pinned: true,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios, color: TColor.gray),
            ),
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              background: widget.meal.image != null
                  ? Image.network(
                      widget.meal.image!,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 200,
                          color: TColor.lightGray,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.restaurant,
                                  size: 64, color: TColor.gray),
                              const SizedBox(height: 8),
                              Text(
                                'Image not available',
                                style: TextStyle(color: TColor.gray),
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  : Container(
                      color: TColor.lightGray,
                      child:
                          Icon(Icons.restaurant, size: 64, color: TColor.gray),
                    ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _error != null
                      ? Center(
                          child: Text(
                            'Error loading recipe details: $_error',
                            style: TextStyle(color: TColor.gray),
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.meal.title,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: TColor.black,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Icon(Icons.timer, color: TColor.gray),
                                const SizedBox(width: 8),
                                Text(
                                  '${widget.meal.readyInMinutes} minutes',
                                  style: TextStyle(
                                    color: TColor.gray,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(width: 24),
                                Icon(Icons.people, color: TColor.gray),
                                const SizedBox(width: 8),
                                Text(
                                  '${widget.meal.servings} servings',
                                  style: TextStyle(
                                    color: TColor.gray,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            if (widget.meal.diets.isNotEmpty) ...[
                              const SizedBox(height: 16),
                              Text(
                                'Diet Types',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: TColor.black,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 8,
                                children: widget.meal.diets.map((diet) {
                                  return Chip(
                                    label: Text(
                                      diet,
                                      style: TextStyle(
                                        color: TColor.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                    backgroundColor: TColor.primaryColor2,
                                  );
                                }).toList(),
                              ),
                            ],
                            const SizedBox(height: 16),
                            Text(
                              'Health Score',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: TColor.black,
                              ),
                            ),
                            const SizedBox(height: 8),
                            LinearProgressIndicator(
                              value: widget.meal.healthScore / 100,
                              backgroundColor: TColor.lightGray,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                widget.meal.healthScore >= 70
                                    ? Colors.green
                                    : widget.meal.healthScore >= 40
                                        ? Colors.orange
                                        : Colors.red,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${widget.meal.healthScore.toStringAsFixed(0)}%',
                              style: TextStyle(
                                color: TColor.gray,
                                fontSize: 14,
                              ),
                            ),
                            if (_recipeDetails != null) ...[
                              const SizedBox(height: 24),
                              Text(
                                'Instructions',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: TColor.black,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Html(
                                  data: _recipeDetails!['instructions'] ??
                                      'No instructions available'),
                              const SizedBox(height: 24),
                              Text(
                                'Ingredients',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: TColor.black,
                                ),
                              ),
                              const SizedBox(height: 8),
                              ..._buildIngredientsList(),
                            ],
                          ],
                        ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildIngredientsList() {
    final ingredients =
        _recipeDetails?['extendedIngredients'] as List<dynamic>?;
    if (ingredients == null || ingredients.isEmpty) {
      return [
        Text(
          'No ingredients available',
          style: TextStyle(
            color: TColor.gray,
            fontSize: 14,
          ),
        ),
      ];
    }

    return ingredients.map<Widget>((ingredient) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Icon(Icons.fiber_manual_record, size: 8, color: TColor.gray),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                '${ingredient['amount']?.toStringAsFixed(1) ?? ''} ${ingredient['unit'] ?? ''} ${ingredient['name'] ?? ''}',
                style: TextStyle(
                  color: TColor.gray,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }
}

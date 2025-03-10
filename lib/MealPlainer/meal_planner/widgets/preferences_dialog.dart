import 'package:flutter/material.dart';
import '../models/user_preferences.dart';

class PreferencesDialog extends StatefulWidget {
  final UserPreferences preferences;
  final Function(UserPreferences) onSave;

  const PreferencesDialog({
    super.key,
    required this.preferences,
    required this.onSave,
  });

  @override
  State<PreferencesDialog> createState() => _PreferencesDialogState();
}

class _PreferencesDialogState extends State<PreferencesDialog> {
  late UserPreferences _preferences;
  final _caloriesController = TextEditingController();
  final _prepTimeController = TextEditingController();
  final _allergyController = TextEditingController();
  final _excludeController = TextEditingController();

  final List<String> _availableCuisines = [
    'Indian',
    'Italian',
    'Chinese',
    'Japanese',
    'Mexican',
    'Thai',
    'Mediterranean',
    'French',
    'Korean',
    'Middle Eastern',
    'Vietnamese',
    'Greek',
  ];

  @override
  void initState() {
    super.initState();
    _preferences = widget.preferences.copyWith();
    _caloriesController.text = _preferences.targetCalories.toString();
    _prepTimeController.text = _preferences.maxPrepTime.toString();
  }

  @override
  void dispose() {
    _caloriesController.dispose();
    _allergyController.dispose();
    _excludeController.dispose();
    _prepTimeController.dispose();
    super.dispose();
  }

  void _addAllergy(String allergy) {
    if (!_preferences.allergies.contains(allergy)) {
      setState(() {
        _preferences = _preferences.copyWith(
          allergies: [..._preferences.allergies, allergy],
        );
      });
    }
  }

  void _removeAllergy(String allergy) {
    setState(() {
      _preferences = _preferences.copyWith(
        allergies: _preferences.allergies.where((a) => a != allergy).toList(),
      );
    });
  }

  void _addExclusion(String item) {
    if (!_preferences.excludedIngredients.contains(item)) {
      setState(() {
        _preferences = _preferences.copyWith(
          excludedIngredients: [..._preferences.excludedIngredients, item],
        );
      });
    }
  }

  void _removeExclusion(String item) {
    setState(() {
      _preferences = _preferences.copyWith(
        excludedIngredients: _preferences.excludedIngredients.where((i) => i != item).toList(),
      );
    });
  }

  void _toggleCuisine(String cuisine) {
    setState(() {
      if (_preferences.culturalPreferences.contains(cuisine)) {
        _preferences = _preferences.copyWith(
          culturalPreferences: _preferences.culturalPreferences.where((c) => c != cuisine).toList(),
        );
      } else {
        _preferences = _preferences.copyWith(
          culturalPreferences: [..._preferences.culturalPreferences, cuisine],
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Dietary Preferences',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            
            // Calories and Prep Time
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _caloriesController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Target Daily Calories',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _preferences = _preferences.copyWith(
                          targetCalories: int.tryParse(value) ?? 2000,
                        );
                      });
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: _prepTimeController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Max Prep Time (min)',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _preferences = _preferences.copyWith(
                          maxPrepTime: int.tryParse(value) ?? 60,
                        );
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Diet Types
            const Text(
              'Diet Type',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              children: [
                FilterChip(
                  label: const Text('Vegetarian'),
                  selected: _preferences.vegetarian,
                  onSelected: (bool selected) {
                    setState(() {
                      _preferences = _preferences.copyWith(
                        vegetarian: selected,
                        vegan: selected ? false : _preferences.vegan,
                      );
                    });
                  },
                  backgroundColor: _preferences.vegetarian ? Colors.blue : Colors.grey[200],
                  selectedColor: Colors.blue,
                  labelStyle: TextStyle(
                    color: _preferences.vegetarian ? Colors.white : Colors.black87,
                  ),
                ),
                FilterChip(
                  label: const Text('Vegan'),
                  selected: _preferences.vegan,
                  onSelected: (bool selected) {
                    setState(() {
                      _preferences = _preferences.copyWith(
                        vegan: selected,
                        vegetarian: selected ? false : _preferences.vegetarian,
                      );
                    });
                  },
                  backgroundColor: _preferences.vegan ? Colors.blue : Colors.grey[200],
                  selectedColor: Colors.blue,
                  labelStyle: TextStyle(
                    color: _preferences.vegan ? Colors.white : Colors.black87,
                  ),
                ),
                _buildDietChip('Gluten Free', _preferences.glutenFree, (selected) {
                  setState(() {
                    _preferences = _preferences.copyWith(glutenFree: selected);
                  });
                }),
                _buildDietChip('Keto', _preferences.keto, (selected) {
                  setState(() {
                    _preferences = _preferences.copyWith(keto: selected);
                  });
                }),
                _buildDietChip('Paleo', _preferences.paleo, (selected) {
                  setState(() {
                    _preferences = _preferences.copyWith(paleo: selected);
                  });
                }),
                _buildDietChip('Low Carb', _preferences.lowCarb, (selected) {
                  setState(() {
                    _preferences = _preferences.copyWith(lowCarb: selected);
                  });
                }),
                _buildDietChip('Mediterranean', _preferences.mediterranean, (selected) {
                  setState(() {
                    _preferences = _preferences.copyWith(mediterranean: selected);
                  });
                }),
              ],
            ),
            const SizedBox(height: 20),

            // Cuisine Types
            const Text(
              'Cuisine Types',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              children: _availableCuisines.map((cuisine) {
                final isSelected = _preferences.culturalPreferences.contains(cuisine);
                return FilterChip(
                  label: Text(cuisine),
                  selected: isSelected,
                  onSelected: (_) => _toggleCuisine(cuisine),
                  backgroundColor: isSelected ? Colors.blue : Colors.grey[200],
                  selectedColor: Colors.blue,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            // Allergies
            const Text(
              'Allergies',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _allergyController,
                    decoration: InputDecoration(
                      labelText: 'Add Allergy',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          if (_allergyController.text.isNotEmpty) {
                            _addAllergy(_allergyController.text);
                            _allergyController.clear();
                          }
                        },
                      ),
                    ),
                    onSubmitted: (value) {
                      if (value.isNotEmpty) {
                        _addAllergy(value);
                        _allergyController.clear();
                      }
                    },
                  ),
                ),
              ],
            ),
            Wrap(
              spacing: 8,
              children: _preferences.allergies.map((allergy) {
                return Chip(
                  label: Text(allergy),
                  onDeleted: () => _removeAllergy(allergy),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            // Excluded Ingredients
            const Text(
              'Exclude Ingredients',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _excludeController,
                    decoration: InputDecoration(
                      labelText: 'Add Ingredient to Exclude',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          if (_excludeController.text.isNotEmpty) {
                            _addExclusion(_excludeController.text);
                            _excludeController.clear();
                          }
                        },
                      ),
                    ),
                    onSubmitted: (value) {
                      if (value.isNotEmpty) {
                        _addExclusion(value);
                        _excludeController.clear();
                      }
                    },
                  ),
                ),
              ],
            ),
            Wrap(
              spacing: 8,
              children: _preferences.excludedIngredients.map((item) {
                return Chip(
                  label: Text(item),
                  onDeleted: () => _removeExclusion(item),
                );
              }).toList(),
            ),
            const SizedBox(height: 30),

            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    widget.onSave(_preferences);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDietChip(String label, bool selected, Function(bool) onSelected) {
    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: onSelected,
      backgroundColor: selected ? Colors.blue : Colors.grey[200],
      selectedColor: Colors.blue,
      labelStyle: TextStyle(
        color: selected ? Colors.white : Colors.black87,
      ),
    );
  }
}

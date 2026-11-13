import 'package:json_annotation/json_annotation.dart';

import 'ingredient.dart';
import 'instruction.dart';

part 'cocktail_recipe.g.dart';

@JsonSerializable(explicitToJson: true)
class CocktailRecipe {
  @JsonKey(name: 'cocktail_name')
  final String cocktailName;
  final String description;
  @JsonKey(name: 'total_calories_in_kCal')
  final double totalCalories;
  @JsonKey(name: 'total_volume_in_mL')
  final double totalVolume;
  @JsonKey(name: 'total_carbohydrates_in_g')
  final double totalCarbohydratesInG;
  @JsonKey(name: 'total_protein_in_g')
  final double totalProteinInG;
  @JsonKey(name: 'alcohol_by_volume_%')
  final double alcoholByVolumePercent;
  @JsonKey(name: 'serving_format')
  final String servingFormat;
  @JsonKey(name: 'total_fat_in_g')
  final double totalFatInG;
  final String history;
  final List<Ingredient> ingredients;
  final List<Instruction> instructions;

  CocktailRecipe({
    required this.cocktailName,
    required this.description,
    required this.totalCalories,
    required this.totalVolume,
    required this.totalCarbohydratesInG,
    required this.totalProteinInG,
    required this.totalFatInG,
    required this.history,
    required this.ingredients,
    required this.instructions,
    required this.alcoholByVolumePercent,
    required this.servingFormat,
  });

  double get alcoholUnits {
    return totalVolume * alcoholByVolumePercent / 1000;
  }

  factory CocktailRecipe.fromJson(Map<String, dynamic> json) =>
      _$CocktailRecipeFromJson(json);

  Map<String, dynamic> toJson() => _$CocktailRecipeToJson(this);

  static Map<String, dynamic> get schema {
    Map<String, dynamic> schema = {
      'type': 'OBJECT',
      'properties': {
        'cocktail_name': {'type': 'STRING'},
        'description': {'type': 'STRING'},
        'total_calories_in_kCal': {'type': 'NUMBER'},
        'total_volume_in_mL': {'type': 'NUMBER'},
        'history': {'type': 'STRING'},
        'alcohol_by_volume_%': {'type': 'NUMBER'},
        'serving_format': {'type': 'STRING'},
        'total_carbohydrates_in_g': {'type': 'NUMBER'},
        'total_protein_in_g': {'type': 'NUMBER'},
        'total_fat_in_g': {'type': 'NUMBER'},
        'ingredients': {
          'type': 'ARRAY',
          'items': {
            'type': 'OBJECT',
            'properties': {
              'name': {'type': 'STRING'},
              'quantity_in_mL': {'type': 'NUMBER'},
              'carbohydrates_in_g': {'type': 'NUMBER'},
              'protein_in_g': {'type': 'NUMBER'},
              'fat_in_g': {'type': 'NUMBER'},
              'calories_in_kCal': {'type': 'NUMBER'},
              'alcohol_by_volume_%': {'type': 'NUMBER'},
            },
          },
        },
        'instructions': {
          'type': 'ARRAY',
          'items': {
            'type': 'OBJECT',
            'properties': {
              'step': {'type': 'NUMBER'},
              'description': {'type': 'STRING'},
            },
          },
        },
      },
      'required': [
        'cocktail_name',
        'ingredients',
        'instructions',
        'description',
        'total_calories_in_kCal',
        'total_volume_in_mL',
        'history',
      ],
    };
    return schema;
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cocktail_recipe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CocktailRecipe _$CocktailRecipeFromJson(Map<String, dynamic> json) =>
    CocktailRecipe(
      cocktailName: json['cocktail_name'] as String,
      description: json['description'] as String,
      totalCalories: (json['total_calories_in_kCal'] as num).toDouble(),
      totalVolume: (json['total_volume_in_mL'] as num).toDouble(),
      totalCarbohydratesInG: (json['total_carbohydrates_in_g'] as num)
          .toDouble(),
      totalProteinInG: (json['total_protein_in_g'] as num).toDouble(),
      totalFatInG: (json['total_fat_in_g'] as num).toDouble(),
      history: json['history'] as String,
      ingredients: (json['ingredients'] as List<dynamic>)
          .map((e) => Ingredient.fromJson(e as Map<String, dynamic>))
          .toList(),
      instructions: (json['instructions'] as List<dynamic>)
          .map((e) => Instruction.fromJson(e as Map<String, dynamic>))
          .toList(),
      alcoholByVolumePercent: (json['alcohol_by_volume_%'] as num).toDouble(),
      servingFormat: json['serving_format'] as String,
    );

Map<String, dynamic> _$CocktailRecipeToJson(CocktailRecipe instance) =>
    <String, dynamic>{
      'cocktail_name': instance.cocktailName,
      'description': instance.description,
      'total_calories_in_kCal': instance.totalCalories,
      'total_volume_in_mL': instance.totalVolume,
      'total_carbohydrates_in_g': instance.totalCarbohydratesInG,
      'total_protein_in_g': instance.totalProteinInG,
      'alcohol_by_volume_%': instance.alcoholByVolumePercent,
      'serving_format': instance.servingFormat,
      'total_fat_in_g': instance.totalFatInG,
      'history': instance.history,
      'ingredients': instance.ingredients.map((e) => e.toJson()).toList(),
      'instructions': instance.instructions.map((e) => e.toJson()).toList(),
    };

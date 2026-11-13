// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ingredient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ingredient _$IngredientFromJson(Map<String, dynamic> json) => Ingredient(
  name: json['name'] as String,
  quantityInMl: (json['quantity_in_mL'] as num).toDouble(),
  carbohydratesInG: (json['carbohydrates_in_g'] as num).toDouble(),
  proteinInG: (json['protein_in_g'] as num).toDouble(),
  fatInG: (json['fat_in_g'] as num).toDouble(),
  caloriesInKcal: (json['calories_in_kCal'] as num).toDouble(),
  alcoholByVolumePercent: (json['alcohol_by_volume_%'] as num).toDouble(),
);

Map<String, dynamic> _$IngredientToJson(Ingredient instance) =>
    <String, dynamic>{
      'name': instance.name,
      'quantity_in_mL': instance.quantityInMl,
      'carbohydrates_in_g': instance.carbohydratesInG,
      'protein_in_g': instance.proteinInG,
      'fat_in_g': instance.fatInG,
      'calories_in_kCal': instance.caloriesInKcal,
      'alcohol_by_volume_%': instance.alcoholByVolumePercent,
    };

import 'package:json_annotation/json_annotation.dart';

part 'ingredient.g.dart';

@JsonSerializable()
class Ingredient {
  final String name;
  @JsonKey(name: 'quantity_in_mL')
  final double quantityInMl;
  @JsonKey(name: 'carbohydrates_in_g')
  final double carbohydratesInG;
  @JsonKey(name: 'protein_in_g')
  final double proteinInG;
  @JsonKey(name: 'fat_in_g')
  final double fatInG;
  @JsonKey(name: 'calories_in_kCal')
  final double caloriesInKcal;
  @JsonKey(name: 'alcohol_by_volume_%')
  final double alcoholByVolumePercent;

  factory Ingredient.fromJson(Map<String, dynamic> json) =>
      _$IngredientFromJson(json);

  Ingredient({
    required this.name,
    required this.quantityInMl,
    required this.carbohydratesInG,
    required this.proteinInG,
    required this.fatInG,
    required this.caloriesInKcal,
    required this.alcoholByVolumePercent,
  });

  Map<String, dynamic> toJson() => _$IngredientToJson(this);
}

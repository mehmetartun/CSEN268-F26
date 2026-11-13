import 'package:json_annotation/json_annotation.dart';

part 'instruction.g.dart';

@JsonSerializable()
class Instruction {
  final String description;
  final int step;

  Instruction({required this.description, required this.step});
  factory Instruction.fromJson(Map<String, dynamic> json) =>
      _$InstructionFromJson(json);

  Map<String, dynamic> toJson() => _$InstructionToJson(this);
}

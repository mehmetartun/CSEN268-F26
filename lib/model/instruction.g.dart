// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'instruction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Instruction _$InstructionFromJson(Map<String, dynamic> json) => Instruction(
  description: json['description'] as String,
  step: (json['step'] as num).toInt(),
);

Map<String, dynamic> _$InstructionToJson(Instruction instance) =>
    <String, dynamic>{
      'description': instance.description,
      'step': instance.step,
    };

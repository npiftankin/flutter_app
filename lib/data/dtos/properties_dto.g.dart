// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'properties_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PropertyDto _$PropertyDtoFromJson(Map<String, dynamic> json) => PropertyDto(
  id: (json['id'] as num?)?.toInt(),
  title: json['title'] as String?,
  type: json['type'] as String?,
  area: (json['area'] as num?)?.toInt(),
  pricePerDay: (json['pricePerDay'] as num?)?.toInt(),
  description: json['description'] as String?,
  image: json['image'] as String?,
  status: json['status'] as String?,
  district: json['district'] == null
      ? null
      : DistrictDto.fromJson(json['district'] as Map<String, dynamic>),
  agent: json['agent'] == null ? null : AgentDto.fromJson(json['agent'] as Map<String, dynamic>),
);

DistrictDto _$DistrictDtoFromJson(Map<String, dynamic> json) =>
    DistrictDto(id: (json['id'] as num?)?.toInt(), name: json['name'] as String?);

AgentDto _$AgentDtoFromJson(Map<String, dynamic> json) => AgentDto(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  email: json['email'] as String?,
  phone: json['phone'] as String?,
);

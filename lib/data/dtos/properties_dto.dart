import 'package:json_annotation/json_annotation.dart';

part 'properties_dto.g.dart';

@JsonSerializable(createToJson: false)
class PropertyDto {
  final int? id;
  final String? title;
  final String? type;
  final int? area;
  final int? pricePerDay;
  final String? description;
  final String? image;
  final String? status;
  final DistrictDto? district;
  final AgentDto? agent;

  const PropertyDto({
    this.id,
    this.title,
    this.type,
    this.area,
    this.pricePerDay,
    this.description,
    this.image,
    this.status,
    this.district,
    this.agent,
  });

  factory PropertyDto.fromJson(Map<String, dynamic> json) => _$PropertyDtoFromJson(json);
}

@JsonSerializable(createToJson: false)
class DistrictDto {
  final int? id;
  final String? name;

  const DistrictDto({this.id, this.name});

  factory DistrictDto.fromJson(Map<String, dynamic> json) => _$DistrictDtoFromJson(json);
}

@JsonSerializable(createToJson: false)
class AgentDto {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;

  const AgentDto({this.id, this.name, this.email, this.phone});

  factory AgentDto.fromJson(Map<String, dynamic> json) => _$AgentDtoFromJson(json);
}

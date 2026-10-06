import 'package:flutter/material.dart';
import 'package:flutter_app/components/config.dart';
import 'package:flutter_app/data/dtos/properties_dto.dart';
import 'package:flutter_app/domain/models/card.dart';
import 'package:flutter_app/domain/models/home.dart';
import 'package:flutter_app/domain/models/property_status.dart';

extension PropertiesDtoToModel on List<PropertyDto> {
  HomeData toDomain() => HomeData(data: map((e) => e.toDomain()).toList());
}

extension PropertyDtoToModel on PropertyDto {
  CardData toDomain() => CardData(
        title ?? 'UNKNOWN',
        descriptionText: description ?? '',
        icon: _iconByType(type),
        imageUrl: _resolveImage(image),
        id: id,
        type: type,
        area: area,
        pricePerDay: pricePerDay,
        status: PropertyStatus.fromServer(status),
        districtName: district?.name,
        agentName: agent?.name,
        agentPhone: agent?.phone,
      );

  // Ссылки вида http... берём как есть, пути вида /1.jpg
  // отдаёт веб-клиент, поэтому дописываем его адрес.
  String? _resolveImage(String? image) {
    if (image == null || image.isEmpty) {
      return null;
    }
    if (image.startsWith('http')) {
      return image;
    }
    return Uri.parse(imagesBaseUrl).resolve(image).toString();
  }

  IconData _iconByType(String? type) => switch (type) {
        'Квартира' => Icons.apartment,
        'Дом' => Icons.home,
        'Офис' => Icons.business,
        _ => Icons.home_work,
      };
}

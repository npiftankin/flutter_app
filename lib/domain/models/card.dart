import 'package:flutter/material.dart';
import 'package:flutter_app/domain/models/property_status.dart';

class CardData {
  final String text;
  final String descriptionText;
  final IconData icon;
  final String? imageUrl;
  final int? id;
  final String? type;
  final int? area;
  final int? pricePerDay;
  final PropertyStatus? status;
  final String? districtName;
  final String? agentName;
  final String? agentPhone;

  CardData(
    this.text, {
    required this.descriptionText,
    this.icon = Icons.home_work,
    this.imageUrl,
    this.id,
    this.type,
    this.area,
    this.pricePerDay,
    this.status,
    this.districtName,
    this.agentName,
    this.agentPhone,
  });
}

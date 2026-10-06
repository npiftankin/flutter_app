import 'package:flutter/material.dart';
import 'package:flutter_app/data/repositories/api_interface.dart';
import 'package:flutter_app/domain/models/card.dart';
import 'package:flutter_app/domain/models/home.dart';
import 'package:flutter_app/domain/models/property_status.dart';

class MockRepository extends ApiInterface {
  @override
  Future<HomeData?> loadData({OnErrorCallback? onError, String? type, int? maxPrice}) async {
    return HomeData(
      data: [
        CardData(
          'Дом',
          descriptionText: 'Большой загородный дом с участком.',
          icon: Icons.home,
          imageUrl: 'https://m.terem-pro.ru/upload/iblock/27c/27cd22f5560e08e5e7e106370c0cdf8b.jpg',
          id: 1,
          type: 'Дом',
          area: 120,
          pricePerDay: 9000,
          status: PropertyStatus.active,
          districtName: 'Пригород',
          agentName: 'Иван Петров',
          agentPhone: '+7 (900) 222-33-44',
        ),
        CardData(
          'Квартира',
          descriptionText: 'Современная квартира в центре города.',
          icon: Icons.apartment,
          imageUrl: 'https://s0.rbk.ru/v6_top_pics/media/img/4/60/756113122114604.jpg',
          id: 2,
          type: 'Квартира',
          area: 54,
          pricePerDay: 4500,
          status: PropertyStatus.active,
          districtName: 'Центр',
          agentName: 'Анна Смирнова',
          agentPhone: '+7 (900) 123-45-67',
        ),
      ],
    );
  }
}

import 'package:flutter_app/domain/models/home.dart';

typedef OnErrorCallback = void Function(String? error);

abstract class ApiInterface {
  Future<HomeData?> loadData({OnErrorCallback? onError, String? type, int? maxPrice});
}

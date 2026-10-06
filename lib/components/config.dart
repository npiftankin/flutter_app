// 10.0.2.2 - адрес компьютера из Android-эмулятора.
// Для iOS-симулятора заменить на localhost, для телефона на IP компьютера.
const String apiBaseUrl = String.fromEnvironment(
  'API_URL',
  defaultValue: 'http://10.0.2.2:8080/api/1.0',
);

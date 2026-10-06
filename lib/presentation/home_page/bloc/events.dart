abstract class HomeEvent {
  const HomeEvent();
}

class HomeLoadDataEvent extends HomeEvent {
  final String? type;
  final int? maxPrice;

  const HomeLoadDataEvent({this.type, this.maxPrice});
}

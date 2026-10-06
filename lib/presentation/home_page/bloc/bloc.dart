import 'package:flutter_app/data/repositories/api_interface.dart';
import 'package:flutter_app/presentation/home_page/bloc/events.dart';
import 'package:flutter_app/presentation/home_page/bloc/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ApiInterface repo;

  int _requestId = 0;

  HomeBloc(this.repo) : super(const HomeState()) {
    on<HomeLoadDataEvent>(_onLoadData);
  }

  Future<void> _onLoadData(HomeLoadDataEvent event, Emitter<HomeState> emit) async {
    final int requestId = ++_requestId;

    emit(state.copyWith(isLoading: true, error: null, type: event.type, maxPrice: event.maxPrice));

    String? error;

    final data = await repo.loadData(
      type: event.type,
      maxPrice: event.maxPrice,
      onError: (e) => error = e,
    );

    if (requestId != _requestId) {
      return;
    }

    emit(state.copyWith(isLoading: false, data: data ?? state.data, error: error));
  }
}

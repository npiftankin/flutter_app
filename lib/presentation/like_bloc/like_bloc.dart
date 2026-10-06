import 'package:flutter_app/data/repositories/like_repository.dart';
import 'package:flutter_app/presentation/like_bloc/like_event.dart';
import 'package:flutter_app/presentation/like_bloc/like_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LikeBloc extends Bloc<LikeEvent, LikeState> {
  final LikeRepository repo;

  LikeBloc(this.repo) : super(const LikeState(likedIds: [])) {
    on<ChangeLikeEvent>(_onChangeLike);
    on<LoadLikesEvent>(_onLoadLikes);
  }

  Future<void> _onLoadLikes(LoadLikesEvent event, Emitter<LikeState> emit) async {
    final List<int> data = await repo.loadAll();

    emit(state.copyWith(likedIds: data));
  }

  Future<void> _onChangeLike(ChangeLikeEvent event, Emitter<LikeState> emit) async {
    final updatedList = List<int>.from(state.likedIds);

    if (updatedList.contains(event.id)) {
      await repo.remove(event.id);
      updatedList.remove(event.id);
    } else {
      await repo.add(event.id);
      updatedList.add(event.id);
    }

    emit(state.copyWith(likedIds: updatedList));
  }
}

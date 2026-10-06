abstract class LikeRepository {
  Future<List<int>> loadAll();

  Future<void> add(int id);

  Future<void> remove(int id);
}

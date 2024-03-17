abstract class Iservice<S> {
  Future<List<S>> getAll();
  Future<S> getOne(int id);
  Future<S> create(S s);
  Future<S> update(S s);
  Future<bool> delete(int id);
  Future<List<S>> search(String query);
}

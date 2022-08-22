import '../repositories/repository.dart';

class InMemoryCache implements Repository {
  final storage = <int, Model>{};

  @override
  Model create() {
    final ids = storage.keys.toList()..sort();
    final id = ids.isEmpty ? 1 : ids.last + 1;
    final model = Model(id: id);
    storage[id] = model;
    return model;
  }

  @override
  List<Model> getAll() {
    return storage.values.toList();
  }

  @override
  Model get(int id) {
    return storage[id]!;
  }

  @override
  void update(Model model) {
    storage[model.id] = model;
  }

  @override
  void delete(Model model) {
    storage.remove(model.id);
  }

  @override
  void clear() {
    storage.clear();
  }
}

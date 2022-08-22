import 'package:shulte/shulte/blocks/repository/repository.dart';
import 'package:shulte/shulte/configs/enums.dart';

class InMemoryCache implements Repository {
  final storage = <int, Model>{};

  Model create() {
    final ids = storage.keys.toList()..sort();
    final id = ids == null ? 1 : ids.last + 1;
    final model = Model(id: id);
    storage[id] = model;
    return model;
  }

  List<Model> getAll() {
    return storage.values.toList();
  }

  List<Model> getAllMode(GameMode mode) {
    return storage.values.where((item) => item.data['mode'] == mode).toList();
  }

  Model get(int id) {
    return storage[id]!;
  }
  void update(Model item) {}
  void delete(Model item) {}
  void clear() {}
}

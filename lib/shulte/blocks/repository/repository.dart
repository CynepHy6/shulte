abstract class Repository {
  final storage = <int, Model>{};
  Model create();
  List<Model> getAll();
  Model get(int id);
  void update(Model item);
  void delete(Model item);
  void clear();
}

class Model {
  final int id;
  final Map data;
  Model({
    required this.id,
    required this.data,
  });
}

abstract class Repository {
  Model create();
  List<Model> getAll();
  Model get(int id);
  void update(Model model);
  void delete(Model model);
  void clear();
}

class Model {
  final int id;
  final Map data;
  Model({
    required this.id,
    this.data = const {},
  });
}

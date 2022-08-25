import 'dart:convert';

@Deprecated('not used')
abstract class Repository {
  Model create();
  List<Model> getAll();
  Model get(String id);
  void update(Model model);
  void delete(Model model);
  void clear();
}

class Model {
  final String id;
  final Map data;
  Model({
    required this.id,
    this.data = const {},
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'data': data,
    };
  }

  factory Model.fromMap(Map<String, dynamic> map) {
    final data = Map.from(map['data']);
    return Model(
      id: map['id'] ?? '',
      data: data,
    );
  }

  String toJson() => json.encode(toMap());

  factory Model.fromJson(String source) => Model.fromMap(json.decode(source));
}

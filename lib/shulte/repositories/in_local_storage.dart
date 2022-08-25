import 'package:localstore/localstore.dart';
import 'model.dart';

const collectionName = 'results';

class InLocalStorage {
  final db = Localstore.instance;

  Model create() {
    final id = db.collection(collectionName).doc().id;
    final model = Model(id: id);
    db.collection(collectionName).doc(id).set(model.toMap());
    return model;
  }

  update(Model model) {
    db.collection(collectionName).doc(model.id).set(model.toMap());
  }

  Future<List<Model>?> getAll() async {
    final items = await db.collection(collectionName).get();
    return items?.values.map((value) => Model.fromMap(value)).toList();
  }
}

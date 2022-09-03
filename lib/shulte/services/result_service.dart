import 'package:shulte/shulte/repositories/in_local_storage.dart';

import '../configs/enums.dart';
import '../result.dart';

// TODO сделать хранение в БД?
class ResultService {
  final repository = InLocalStorage();

  save(DateTime date, double time, GameMode mode) {
    final model = repository.create();
    repository.update(Result(
      id: model.id.toString(),
      date: date,
      time: time,
      mode: mode,
    ).toModel());
  }

  Future<List<Result>> getAll(GameMode mode) async {
    final results = await repository.getAll() ?? [];
    final filtered = results.map((item) => Result.fromModel(item)).where((model) => model.mode == mode).toList();

    return filtered;
  }
}

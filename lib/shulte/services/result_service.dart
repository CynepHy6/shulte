import '../configs/enums.dart';
import '../repositories/in_memory_cache.dart';
import '../result.dart';

class ResultService {
  final repository = InMemoryCache();

  save(DateTime date, double time, GameMode mode) {
    final model = repository.create();
    repository.update(Result(id: model.id, date: date, time: time, mode: mode).toModel());
  }

  List<Result> getAll(GameMode mode) {
    return repository
        .getAll()
        .where((item) => item.data['mode'] == mode)
        .map((item) => Result.fromModel(item))
        .toList();
  }
}

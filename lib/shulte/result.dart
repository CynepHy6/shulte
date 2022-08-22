import 'configs/enums.dart';
import 'repositories/repository.dart';

class Result {
  final int id;
  final double time;
  final DateTime date;
  final GameMode mode;
  Result({
    required this.id,
    required this.time,
    required this.date,
    required this.mode,
  });
  Result.fromModel(Model model)
      : id = model.id,
        time = model.data['time'],
        date = model.data['date'],
        mode = model.data['mode'];

  Model toModel() => Model(id: id, data: {
        'time': time,
        'date': date,
        'mode': mode,
      });
}

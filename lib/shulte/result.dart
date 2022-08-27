import 'configs/enums.dart';
import 'repositories/model.dart';
import 'package:intl/intl.dart';

class Result {
  final String id;
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
        time = model.data['time']?.toDouble() ?? 0.0,
        date = DateTime.fromMillisecondsSinceEpoch(model.data['date']),
        mode = GameMode.fromString(model.data['mode']) ?? GameMode.debug;

  Model toModel() => Model(id: id, data: {
        'time': time,
        'date': date.millisecondsSinceEpoch,
        'mode': mode.toString(),
      });

  String get datePretty => DateFormat('kk:mm:ss').format(date);

  String get group => DateFormat('yyyy-MM-dd').format(date);
}

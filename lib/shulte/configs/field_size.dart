import 'enums.dart';

class FieldSize {
  final int rows;
  final int cols;
  FieldSize({
    required this.rows,
    required this.cols,
  });
  static get sizes => {
        GameMode.debug: FieldSize(cols: 1, rows: 1),
        GameMode.x3: FieldSize(cols: 3, rows: 3),
        GameMode.x4: FieldSize(cols: 4, rows: 4),
        GameMode.x5: FieldSize(cols: 5, rows: 5),
        GameMode.x6: FieldSize(cols: 6, rows: 6),
      };
}

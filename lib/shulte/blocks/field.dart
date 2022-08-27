import 'package:flutter/material.dart';

import '../../service_provider.dart';
import '../result.dart';
import '_.dart';
import '../params.dart';
import 'package:grouped_list/grouped_list.dart';

class Field extends StatefulWidget {
  Params params;
  Field({
    Key? key,
    required this.params,
  }) : super(key: key);

  @override
  State<Field> createState() => _FieldState();
}

class _FieldState extends State<Field> {
  Params get params => widget.params;
  double time = 0;
  int nextNum = 1;
  List<Result> results = [];
  Result? bestResult;

  @override
  Widget build(BuildContext context) {
    startGame(params);

    return Stack(children: [
      if (params.isEnd) resultsScreen(),
      if (params.isStart) gameScreen(),
    ]);
  }

  void startGame(Params field) {
    if (field.isRepeat) field.start();
  }

  Widget resultsScreen() {
    getResults();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          if (bestResult != null)
            Text('Лучший результат: ${bestResult!.time} (${bestResult!.group}, ${bestResult!.datePretty})'),
          Expanded(
            child: GroupedListView(
              groupHeaderBuilder: (Result item) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  item.group,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              useStickyGroupSeparators: true,
              elements: results,
              groupComparator: (String g1, String g2) => g2.compareTo(g1),
              groupBy: (Result item) => item.group,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemComparator: (Result item1, Result item2) => item2.date.compareTo(item1.date),
              indexedItemBuilder: (context, Result item, index) {
                final rowStyle = item.date == bestResult?.date ? const TextStyle(fontWeight: FontWeight.bold) : null;
                return ListTile(
                  visualDensity: const VisualDensity(vertical: VisualDensity.minimumDensity),
                  leading: Text('${index + 1}'),
                  title: Text(item.datePretty, style: rowStyle),
                  trailing: Text(item.time.toString(), style: rowStyle),
                  selected: item.date == bestResult?.date,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget repeatButton() {
    return IconButton(
      icon: Icon(Icons.replay_circle_filled_outlined, color: Colors.grey.shade800),
      onPressed: () => setState(() {
        time = params.time;
        nextNum = 1;
        params.start();
      }),
    );
  }

  successTapCallback() => setState(() {
        time = params.isEnd ? 0 : params.time;
        nextNum = params.nextNum;
      });

  Widget gameScreen() {
    final blocks = params.indexes
        .map((idx) => Block(
              idx: idx,
              params: params,
              callback: successTapCallback,
            ))
        .toList();
    return SizedBox(
      height: params.fieldHeight,
      width: params.fieldWidth,
      child: Column(
        children: [
          FieldTitle(
            nextNum: nextNum,
            time: time,
            width: params.fieldWidth,
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: params.cols,
              children: blocks,
            ),
          ),
        ],
      ),
    );
  }

  void getResults() async {
    final items = await ServiceProvider.of(context).resultService.getAll(params.mode);
    if (items.length != results.length) {
      setState(() {
        results = items;
        items.sort((r1, r2) => r1.time.compareTo(r2.time));
        bestResult = items.first;
      });
    }
  }
}

import 'package:flutter/material.dart';
import 'package:x_before_x/customWidgets.dart';
import 'package:x_before_x/storage.dart';

class ChallangePage extends StatefulWidget {
  final String name;
  final int age;
  final String? title;
  const ChallangePage({
    super.key,
    required this.name,
    required this.age,
    this.title = 'General',
  });

  @override
  State<ChallangePage> createState() => _ChallangePageState();
}

class _ChallangePageState extends State<ChallangePage> {
  late List<String> tasks;
  late List<bool> isChecked;
  late Map allData;

  @override
  void initState() {
    super.initState();
    Map? data = DataStorage.getChallangeData();

    if (data != null && data[widget.title] != null) {
      allData = data;
      var innerMap = data[widget.title] as Map;
      var taskList = innerMap[widget.title] as List;
      tasks = taskList.map((map) => map.values.toList()[0].toString()).toList();
      isChecked =
          taskList.map((map) => map.values.toList()[1] as bool).toList();
    } else {
      tasks =
          List.generate(widget.age + 1, (index) => 'challange ${index + 1}');
      isChecked = List.generate(widget.age + 1, (index) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: widget.age == 0
            ? Text('X before X')
            : Text('${widget.age + 1} before ${widget.age + 1}'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
            child: Center(
              child: Text(widget.title ?? 'General'),
            ),
          ),
          for (int i = 0; i < tasks.length; i++)
            CheckBoxItem(
              text: tasks[i],
              isChecked: isChecked[i],
              onIsChecked: (newState) {
                setState(() {
                  isChecked[i] = newState;
                  List newTasks = [];
                  for (int j = 0; j < tasks.length; j++) {
                    Map tempMap = {
                      'task$j': tasks[j],
                      'isChecked': isChecked[j]
                    };
                    newTasks.add(tempMap);
                  }
                  allData[widget.title][widget.title] = newTasks;
                  DataStorage.saveChallangeData(allData);
                });
              },
              onTaskUpdated: (newValue) {
                setState(
                  () {
                    tasks[i] = newValue;
                    List newTasks = [];
                    for (int i = 0; i < tasks.length; i++) {
                      Map tempMap = {
                        'task$i': tasks[i],
                        'isChecked': isChecked[i]
                      };
                      newTasks.add(tempMap);
                    }
                    allData[widget.title][widget.title] = newTasks;
                    DataStorage.saveChallangeData(allData);
                  },
                );
              },
            ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:x_before_x/customWidgets.dart';
import 'package:x_before_x/pages/challangeList.dart';
import 'package:x_before_x/pages/home.dart';
import 'package:x_before_x/storage.dart';
import 'package:x_before_x/theme.dart';

class ChallangeListPage extends StatefulWidget {
  final String name;
  final int age;
  const ChallangeListPage({
    super.key,
    required this.name,
    required this.age,
  });

  @override
  State<ChallangeListPage> createState() => _ChallangeListPageState();
}

class _ChallangeListPageState extends State<ChallangeListPage> {
  late List<String> challangeListNames;

  @override
  void initState() {
    super.initState();
    Map? data = DataStorage.getChallangeData();

    if (data != null) {
      challangeListNames = data.keys.cast<String>().toList();
    } else {
      challangeListNames = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: widget.age == 0
            ? Text('X before X')
            : Text('~ ${widget.age + 1} before ${widget.age + 1} ~'),
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 5),
                child: Center(
                  child: Text(
                      'Welcome ${widget.name[0].toUpperCase()}${widget.name.substring(1)}!'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 20),
                child: Center(
                  child: Text('Pick your Challange list:'),
                ),
              ),
              for (String listName in challangeListNames)
                NavigationButton(
                  text: listName,
                  page: ChallangePage(
                      name: widget.name, age: widget.age, title: listName),
                ),
            ],
          ),
          Positioned(
            bottom: 32,
            left: 16,
            child: RoundButton(
              icon: Icon(Icons.home),
              page: HomePage(),
            ),
          ),
          Positioned(
            bottom: 32,
            right: 16,
            child: PopUpBox(
              style: IconButton.styleFrom(
                backgroundColor: AppColors.appBarColor,
                foregroundColor: AppColors.titleColor,
                shape: CircleBorder(),
                fixedSize: Size(45, 45),
              ),
              title: 'New Challange List',
              buttonText: Icon(Icons.add),
              hintText: 'Name challange list',
              onSubmit: (value) {
                setState(() {
                  challangeListNames.add(value);
                  Map newList =
                      DataStorage.createNewChallangeList(value, widget.age);
                  var oldData = DataStorage.getChallangeData();
                  oldData ??= {};
                  oldData[value] = newList;
                  DataStorage.saveChallangeData(oldData);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:x_before_x/customWidgets.dart';
import 'package:x_before_x/pages/ListofChallangeLists.dart';
import 'package:x_before_x/pages/challangeList.dart';
import 'package:x_before_x/storage.dart';
import 'package:x_before_x/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userName = '';
  int userAge = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('~ SETUP ~'),
        ),
        body: Expanded(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    'Welcome!',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    'Let\'s get you all set up!',
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 10,
                children: [
                  Text('Your name is:'),
                  Text(userName),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 10,
                children: [
                  Text('Your age is:'),
                  if (userAge == 0) Text('') else Text('$userAge'),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(80, 5, 80, 5),
                child: Row(
                  children: [
                    Text("Enter your name: "),
                    PopUpBox(
                      style: IconButton.styleFrom(
                        backgroundColor: AppColors.appBarColor,
                        foregroundColor: AppColors.titleColor,
                        shape: CircleBorder(),
                        fixedSize: Size(45, 45),
                      ),
                      title: 'Enter name',
                      buttonText: Icon(Icons.person),
                      hintText: 'enter your name...',
                      onSubmit: (value) {
                        setState(() {
                          userName = value;
                          DataStorage.saveName(value);
                        });
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(80, 5, 80, 5),
                child: Row(
                  children: [
                    Text("Enter your age: "),
                    PopUpBox(
                      style: IconButton.styleFrom(
                        backgroundColor: AppColors.appBarColor,
                        foregroundColor: AppColors.titleColor,
                        shape: CircleBorder(),
                        fixedSize: Size(45, 45),
                      ),
                      title: 'Enter age',
                      buttonText: Icon(Icons.numbers),
                      hintText: 'enter your age...',
                      onSubmit: (value) {
                        setState(() {
                          userAge = int.parse(value);
                          DataStorage.saveAge(
                            int.parse(value),
                          );
                        });
                      },
                    ),
                  ],
                ),
              ),
              if (userName.isNotEmpty && userAge != 0)
                NavigationButton(
                  text: 'continue',
                  page: ChallangeListPage(name: userName, age: userAge),
                )
            ],
          ),
        ));
  }
}

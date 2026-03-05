import 'package:flutter/material.dart';
import 'package:x_before_x/customWidgets.dart';
import 'package:x_before_x/pages/ListofChallangeLists.dart';
import 'package:x_before_x/pages/home.dart';
import 'package:x_before_x/quotes.dart';
import 'package:x_before_x/storage.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with TickerProviderStateMixin {
  late String randomQuote;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    randomQuote =
        quotes[(DateTime.now().millisecondsSinceEpoch % quotes.length)];
    _animationController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );
    _animationController.repeat();
    _loadAndNavigate();
  }

  void _loadAndNavigate() async {
    await Future.wait([
      DataStorage.initializeStorage(),
      Future.delayed(
        Duration(seconds: 5),
      )
    ]);

    String? name = DataStorage.getName();
    if (name == null || name.isEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ChallangeListPage(
            name: name,
            age: DataStorage.getAge() ?? 0,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              'Setting things up for you..',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            RippleAnimation(
              controller: _animationController,
            ),
            SizedBox(height: 40),
            Text(
              randomQuote,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

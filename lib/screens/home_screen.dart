import 'package:flutter/material.dart';
import 'package:setu_todo/utils/app_assets.dart';
import 'package:setu_todo/utils/app_colors.dart';
import 'package:setu_todo/screens/calender.dart';
import 'package:setu_todo/screens/journal.dart';
import 'package:setu_todo/screens/todays_todo.dart';
import 'package:setu_todo/widgets/stacked_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, dynamic>> stackedWidgetsInfos = [
    {
      "placeVal": 0,
      "pageName": "JOURNAL",
      "top": 0.352,
      "child": const Journal(),
    },
    {
      "placeVal": 1,
      "pageName": "CALENDER",
      "top": 0.26,
      "child": const Calander(),
    },
    {
      "placeVal": 2,
      "pageName": "TODAY’S TODO",
      "top": 0.17,
      "child": const TodaysTodo(),
    },
  ];

  reArrageListItems(int toChangeIndex) {
    if (toChangeIndex != stackedWidgetsInfos.length - 1) {
      final clickedIndexVal = stackedWidgetsInfos[toChangeIndex];
      stackedWidgetsInfos[toChangeIndex] = stackedWidgetsInfos.last;
      stackedWidgetsInfos[stackedWidgetsInfos.length - 1] = clickedIndexVal;
      if (clickedIndexVal["placeVal"] != 1 &&
          stackedWidgetsInfos[1]["placeVal"] != 1) {
        final zeroIndexVal = stackedWidgetsInfos[0];
        stackedWidgetsInfos[0] = stackedWidgetsInfos[1];
        stackedWidgetsInfos[1] = zeroIndexVal;
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> stackedPages =
        List.generate(stackedWidgetsInfos.length, (int i) {
      return StackedWidget(
        isOnTop: i == stackedWidgetsInfos.length - 1,
        pageName: stackedWidgetsInfos[i]["pageName"],
        top: stackedWidgetsInfos[i]["top"],
        child: stackedWidgetsInfos[i]["child"],
        onTap: () {
          reArrageListItems(i);
        },
      );
    });
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.appPrimary,
                    AppColors.gradientBottom,
                  ],
                ),
              ),
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 15,
              ),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset(AppAssets.appLogo),
                    ),
                  ],
                ),
              ),
            ),
            ...stackedPages,
          ],
        ),
      ),
    );
  }
}

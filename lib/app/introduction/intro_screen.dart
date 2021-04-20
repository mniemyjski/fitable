import 'package:fitable/constants/constants.dart';
import 'package:fitable/routers/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroScreen extends StatelessWidget {
  List<PageViewModel> pages() {
    return [
      PageViewModel(
        title: "Title page",
        body: "Here you can write the description of the page, to explain someting...",
        image: Center(
          child: Image.asset("resources/images/work_in_progress.jpg"),
        ),
      ),
      PageViewModel(
        title: "Title page",
        body: "Here you can write the description of the page, to explain someting...",
        image: Center(
          child: Image.asset("resources/images/work_in_progress.jpg"),
        ),
      ),
      PageViewModel(
        title: "Title page",
        body: "Here you can write the description of the page, to explain someting...",
        image: Center(
          child: Image.asset("resources/images/work_in_progress.jpg"),
        ),
      ),
      PageViewModel(
        title: "Title page",
        body: "Here you can write the description of the page, to explain someting...",
        image: Center(
          child: Image.asset("resources/images/work_in_progress.jpg"),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: pages(),
      showSkipButton: true,
      skip: Text(Constants.skip(), style: TextStyle(fontWeight: FontWeight.w600)),
      next: Text(Constants.next(), style: TextStyle(fontWeight: FontWeight.w600)),
      done: Text(Constants.done(), style: TextStyle(fontWeight: FontWeight.w600)),
      onDone: () => Navigator.pushNamedAndRemoveUntil(context, AppRoute.homeScreen, (_) => false),
    );
  }
}
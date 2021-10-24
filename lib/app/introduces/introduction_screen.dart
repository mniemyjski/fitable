import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:fitable/config/routes/routes.gr.dart';
import 'package:fitable/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);
  static const String routeName = '/intro';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => IntroScreen(),
    );
  }

  List<PageViewModel> pages() {
    return [
      PageViewModel(
        title: "Title page",
        body: "Here you can write the description of the page, to explain someting...",
        image: Center(
          child: Image.asset(Strings.work_in_progress()),
        ),
      ),
      PageViewModel(
        title: "Title page",
        body: "Here you can write the description of the page, to explain someting...",
        image: Center(
          child: Image.asset(Strings.work_in_progress()),
        ),
      ),
      PageViewModel(
        title: "Title page",
        body: "Here you can write the description of the page, to explain someting...",
        image: Center(
          child: Image.asset(Strings.work_in_progress()),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: pages(),
      globalBackgroundColor: Colors.grey[200],
      showSkipButton: true,
      skip: Text(Strings.skip(), style: TextStyle(fontWeight: FontWeight.w600)),
      next: Text(Strings.next(), style: TextStyle(fontWeight: FontWeight.w600)),
      done: Text(Strings.done(), style: TextStyle(fontWeight: FontWeight.w600)),
      onDone: () => context.router.push(const HomeRoute()),
    );
  }
}

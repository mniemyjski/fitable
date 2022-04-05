import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:fitable/config/routes/routes.gr.dart';
import 'package:fitable/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

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
      // globalBackgroundColor: Colors.grey[200],
      showSkipButton: true,
      skip: Text(Strings.skip(),
          style: Theme.of(context).textTheme.bodyText2!.copyWith(fontWeight: FontWeight.bold)),
      next: Text(Strings.next(),
          style: Theme.of(context).textTheme.bodyText2!.copyWith(fontWeight: FontWeight.bold)),
      done: Text(Strings.done(),
          style: Theme.of(context).textTheme.bodyText2!.copyWith(fontWeight: FontWeight.bold)),
      onDone: () => context.router.push(const HomeRoute()),
    );
  }
}

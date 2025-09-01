import 'package:TribbianiNotes/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:TribbianiNotes/Pages/loading_page.dart';

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({super.key});

  @override
  State<IntroductionPage> createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  late PageController _pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
  }

  bool isLastPage = false;
  int lastPage = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (pageIndex) {
              setState(() {
                isLastPage = (3 == pageIndex);
              });
            },
            children: [
              welcome(context),
              tasksAndReminders(),
              groups(),
              personalize(),
            ],
          ),
          Align(
            alignment: const Alignment(0, 0.65),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {
                    _pageController.jumpToPage(lastPage);
                  },
                  child: Text('Skip'),
                ),
                SmoothPageIndicator(
                  controller: _pageController,
                  count: 4,
                  effect: JumpingDotEffect(
                    activeDotColor: Theme.of(context).colorScheme.primary,
                    dotColor: Theme.of(context).colorScheme.onPrimary,
                    verticalOffset: 20,
                  ),
                ),
                isLastPage ? DoneButton() : NextButton(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget DoneButton() {
    return TextButton(
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoadingPage(),
          ),
        );
        // flag onboarding false
        Settings().onboarding = false;
        Settings().saveSettings();
      },
      child: Text('Done'),
    );
  }

  Widget NextButton() {
    return TextButton(
      onPressed: () {
        _pageController.nextPage(
            duration: const Duration(milliseconds: 250), curve: Curves.easeIn);
      },
      child: Text('Next'),
    );
  }

  Widget welcome(BuildContext context) {
    return content(
      asset: 'assets/to_do_list.svg',
      title: 'Welcome',
      body:
          'Stay organized with reminders and to-dos — simple, flexible, and just for you.',
    );
  }

  Widget tasksAndReminders() {
    return content(
      asset: 'assets/reminder.svg',
      title: 'Never miss a thing',
      body:
          'Add tasks with titles, notes, and dates. Get notified once, or set them to repeat daily, weekly, or more.',
    );
  }

  Widget groups() {
    return content(
      asset: 'assets/files.svg',
      title: 'Organize your world',
      body:
          'Create groups for projects, events, or categories. Each group has its own tasks.',
    );
  }

  Widget personalize() {
    return content(
      asset: 'assets/personal_settings.svg',
      title: 'Make it yours',
      body:
          'Choose auto-delete or keep completed tasks. Switch between light, dark, or dynamic themes.',
    );
  }

  Widget content({
    required String asset,
    required String title,
    required String body,
  }) {
    return Align(
      alignment: Alignment(0, -0.3),
      child: SizedBox(
        width: 340,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              asset,
              width: 280,
            ),
            Divider(
              height: 50,
              color: Colors.transparent,
            ),
            Text(
              title,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Divider(
              height: 30,
              color: Colors.transparent,
            ),
            Text(body),
          ],
        ),
      ),
    );
  }
}

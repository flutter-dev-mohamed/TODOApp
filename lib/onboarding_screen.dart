import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:todo_app/Pages/loading_page.dart';

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

  bool lastPage = false;

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      // TODO: AddThe Screens Here!
      Container(
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      Container(
        color: Theme.of(context).colorScheme.secondaryContainer,
      ),
      Container(
        color: Theme.of(context).colorScheme.tertiaryContainer,
      ),
    ];

    return Stack(
      children: [
        PageView(
          controller: _pageController,
          onPageChanged: (pageIndex) {
            setState(() {
              lastPage = ((screens.length - 1) == pageIndex);
            });
          },
          children: screens,
        ),
        Align(
          alignment: const Alignment(0, 0.65),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  _pageController.jumpToPage(2);
                },
                child: Text('Skip'),
              ),
              SmoothPageIndicator(
                controller: _pageController,
                count: screens.length,
                effect: JumpingDotEffect(
                  activeDotColor: Theme.of(context).colorScheme.primary,
                  dotColor: Theme.of(context).colorScheme.onPrimary,
                  verticalOffset: 20,
                ),
              ),
              lastPage ? DoneButton() : NextButton(),
            ],
          ),
        )
      ],
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
      },
      child: Text('Done'),
    );
  }

  Widget NextButton() {
    return TextButton(
      onPressed: () {
        _pageController.nextPage(
            duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
      },
      child: Text('Next'),
    );
  }
}

import 'package:flat_and_fast/common/controls/buttons/feature_button.dart';
import 'package:flutter/material.dart';

class Carousel extends StatefulWidget {
  const Carousel({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  final int _pageCount = OnboardingPageType.values.length;
  final PageController _pageController =
  PageController(initialPage: OnboardingPageType.welcome.index);
  int _currentPage = OnboardingPageType.welcome.index;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 50),
                child: Container(
                  alignment: Alignment.topRight,
                  child: Visibility(
                    visible: _currentPage ==
                        OnboardingPageType.appFeature1.index ||
                        _currentPage == OnboardingPageType.appFeature2.index,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: TextButton(
                        onPressed: () {
                          _pageController.animateToPage(
                              OnboardingPageType.appFeature3.index,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease);
                        },
                        child: const Text('Skip'),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: PageView(
                    physics: const ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int pageIndex) =>
                        _pageChangedHandler(pageIndex),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(color: Colors.blueAccent.shade100, child: Center(child: Text('First tab'))),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(color: Colors.blueAccent.shade100, child: Center(child: Text('Second tab'))),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(color: Colors.blueAccent.shade100, child: Center(child: Text('Third tab'))),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(color: Colors.blueAccent.shade100, child: Center(child: Text('Fourth tab'))),
                      ),
                    ]),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 150),
                child: Column(
                  children: [
                    Row(
                      children: _buildPageIndicator(),
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    const SizedBox(height: 24.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: FeatureButton(
                        title: _currentPage == OnboardingPageType.appFeature3.index
                            ? 'Start'
                            : 'Next',
                        action: () {
                          if (_currentPage ==
                              OnboardingPageType.appFeature3.index) {}
                          _pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease);
                        },
                      ),
                    ),
                    Visibility(
                      visible:
                      _currentPage == OnboardingPageType.appFeature3.index,
                      child: ConstrainedBox(
                        constraints:
                        const BoxConstraints(minHeight: 50, maxHeight: 60),
                        child: Wrap(
                          alignment: WrapAlignment.spaceAround,
                          spacing: 60,
                          children: [
                            TextButton(onPressed: () {}, child: const Text('Sign in')),
                            TextButton(onPressed: () {}, child: const Text('Sign up',))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _pageChangedHandler(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  List<Widget> _buildPageIndicator() {
    final List<Widget> list = [];
    for (int i = 0; i < _pageCount; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      height: 12.0,
      width: 12.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.blueAccent : Colors.grey.shade300,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}

enum OnboardingPageType {
  welcome,
  appFeature1,
  appFeature2,
  appFeature3
}
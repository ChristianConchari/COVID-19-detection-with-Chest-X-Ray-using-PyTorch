import 'dart:ui';

import 'package:covid_detection_app/widgets/slide.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:covid_detection_app/pages/home_page.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  int _currentPage = 0;
  List<Slide> _slides = [];
  PageController _pageController = PageController();

  String onBoardHeading1 =
      'COVID-19 has taken over much of our lives. \n \n Even now health professionals are fighting to save lives, we feel a duty to help them.';

  String onBoardHeading2 =
      'To support them we have decided to use artificial intelligence toolsto aid in the diagnosis of COVID-19 in imaging tests. \n \n';
  String onBoardHeading3 =
      'Let´s take advantage of technology to face this problem. With effort and care, we can get ahead together!';

  @override
  void initState() {
    _currentPage = 0;
    _slides = [
      Slide(image: 'assets/images/wear_mask.png', heading: onBoardHeading1),
      Slide(image: 'assets/images/logo_imt.png', heading: onBoardHeading2),
      Slide(image: 'assets/images/logo_ucb.png', heading: onBoardHeading3),
    ];
    _pageController = PageController(initialPage: _currentPage);
    super.initState();
  }

  List<Widget> _buildSlides() {
    return _slides.map(_buildSlide).toList();
  }

  Widget _buildSlide(Slide slide) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            margin: EdgeInsets.all(35),
            child: Image.asset(
              slide.image,
              fit: BoxFit.contain,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 45),
          child: Text(
            slide.heading,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              letterSpacing: 2,
              color: Colors.grey[700],
            ),
          ),
        ),
        SizedBox(
          height: 150,
        )
      ],
    );
  }

  void _handlingOnPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  Widget _buildPageIndicator() {
    Row row = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [],
    );
    for (int i = 0; i < _slides.length; i++) {
      row.children.add(_buildPageIndicatorItem(i));
      if (i != _slides.length - 1)
        row.children.add(
          SizedBox(
            width: 12,
          ),
        );
    }
    return row;
  }

  Widget _buildPageIndicatorItem(int index) {
    return Container(
      width: index == _currentPage ? 8 : 5,
      height: index == _currentPage ? 8 : 5,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: index == _currentPage ? Color(0xFF2898D8) : Color(0xFF30AEF6)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          PageView(
            controller: _pageController,
            onPageChanged: _handlingOnPageChanged,
            physics: BouncingScrollPhysics(),
            children: _buildSlides(),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 15,
                ),
                _buildPageIndicator(),
                SizedBox(
                  height: 15,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 32),
                  child: SizedBox(
                    width: double.infinity,
                    child: GradientButton(
                      callback: () => {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                        ),
                      },
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF2898D8),
                          Color(0XFF2C9BDB),
                        ],
                      ),
                      elevation: 0,
                      increaseWidthBy: double.infinity,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Text(
                        "LET´S DETECT COVID",
                        style: TextStyle(
                          letterSpacing: 4,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

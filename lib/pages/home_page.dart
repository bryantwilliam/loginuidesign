import 'package:flutter/material.dart';
import 'package:loginuidesign/pages/login_page.dart';
import 'package:loginuidesign/utils/animations/login_page_animations.dart';
import 'package:loginuidesign/utils/animations/page_routes/slide_page_route.dart';

class AnimatedHomePage extends StatefulWidget {
  const AnimatedHomePage({super.key});

  @override
  State<AnimatedHomePage> createState() => _AnimatedHomePageState();
}

class _AnimatedHomePageState extends State<AnimatedHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      reverseDuration: const Duration(milliseconds: 400),
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _HomePage(
      animationController: _animationController,
    );
  }
}

class _HomePage extends StatelessWidget {
  static const Color _primaryColor = Color.fromRGBO(169, 224, 241, 1);

  final AnimationController animationController;
  late final EnterAnimation _animation;

  _HomePage({required this.animationController}) {
    _animation = EnterAnimation(animationController);
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    AnimatedBuilder avatarWidget() {
      double circleD = deviceHeight * 0.25;
      return AnimatedBuilder(
        animation: animationController,
        builder: (BuildContext context_, widget_) {
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.diagonal3Values(
              _animation.circleSize.value,
              _animation.circleSize.value,
              1,
            ),
            child: Container(
              height: circleD,
              width: circleD,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(500),
                color: _primaryColor,
                image: const DecorationImage(
                  image: AssetImage("assets/images/main_avatar.png"),
                ),
              ),
            ),
          );
        },
      );
    }

    Text nameWidget() {
      return const Text(
        "John Doe",
        style: TextStyle(
          color: _primaryColor,
          fontSize: 35,
          fontWeight: FontWeight.w400,
        ),
      );
    }

    Widget logoutButton() {
      return MaterialButton(
        minWidth: deviceWidth * 0.38,
        height: deviceHeight * 0.055,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: _primaryColor,
            width: 3,
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        onPressed: () {
          Navigator.pushReplacement(
            context,
            SlidePageRoute(const AnimatedLoginPage()),
          );
        },
        child: const Text(
          "LOG OUT",
          style: TextStyle(
            fontSize: 16,
            color: _primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Align(
        child: SizedBox(
          width: deviceWidth,
          height: deviceHeight * 0.6,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              avatarWidget(),
              SizedBox(
                height: deviceHeight * 0.03,
              ),
              nameWidget(),
              SizedBox(
                height: deviceHeight * 0.2,
              ),
              logoutButton(),
            ],
          ),
        ),
      ),
    );
  }
}

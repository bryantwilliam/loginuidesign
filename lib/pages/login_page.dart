import 'package:flutter/material.dart';
import 'package:loginuidesign/pages/home_page.dart';
import 'package:loginuidesign/utils/animations/login_page_animations.dart';
import 'package:loginuidesign/utils/animations/page_routes/fade_page_route.dart';

class AnimatedLoginPage extends StatefulWidget {
  const AnimatedLoginPage({super.key});

  @override
  State<AnimatedLoginPage> createState() => _AnimatedLoginPageState();
}

class _AnimatedLoginPageState extends State<AnimatedLoginPage>
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
    return _LoginPage(
      animationController: _animationController,
    );
  }
}

class _LoginPage extends StatelessWidget {
  static const Color _primaryColor = Color.fromRGBO(125, 191, 211, 1);
  static const Color _secondaryColor = Color.fromRGBO(169, 224, 241, 1);

  final AnimationController animationController;
  late final EnterAnimation _animation;

  _LoginPage({
    required this.animationController,
  }) {
    _animation = EnterAnimation(animationController);
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;
    final double deviceWidth = MediaQuery.of(context).size.width;

    AnimatedBuilder avatarWidget() {
      double circleD = deviceHeight * 0.25;
      return AnimatedBuilder(
          animation: animationController,
          builder: (BuildContext context, Widget? widget) {
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
                  color: _secondaryColor,
                  image: const DecorationImage(
                    image: AssetImage("assets/images/main_avatar.png"),
                  ),
                ),
              ),
            );
          });
    }

    SizedBox loginTextField(bool isPassword) {
      const textStyle = TextStyle(
        color: Colors.white,
      );
      const border = UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white,
        ),
      );
      return SizedBox(
        width: deviceWidth * 0.70,
        child: TextField(
          obscureText: isPassword,
          cursorColor: Colors.white,
          autocorrect: false,
          style: textStyle,
          decoration: InputDecoration(
            hintText: isPassword ? "Password" : "john.doe@gmail.com",
            hintStyle: textStyle,
            enabledBorder: border,
            focusedBorder: border,
          ),
        ),
      );
    }

    Widget loginButton() {
      return MaterialButton(
        minWidth: deviceWidth * 0.38,
        height: deviceHeight * 0.055,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        onPressed: () async {
          await animationController.reverse();
          Navigator.pushReplacement(
            context,
            FadePageRoute(const AnimatedHomePage()),
          );
        },
        child: const Text(
          "LOG IN",
          style: TextStyle(
            fontSize: 16,
            color: _primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: _primaryColor,
      body: Align(
        alignment: Alignment.center,
        child: SizedBox(
          height: deviceHeight * 0.6,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              avatarWidget(),
              SizedBox(height: deviceHeight * 0.05),
              loginTextField(false),
              loginTextField(true),
              SizedBox(height: deviceHeight * 0.1),
              loginButton(),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:bandung_travel_recommendation_mobile_flutter/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignInOrSignUpLayout extends StatefulWidget {
  final Key formKey;
  final double? contentHeight;
  final List<Widget> contents;
  final AutovalidateMode? autovalidateMode;
  SignInOrSignUpLayout({
    Key? key,
    required this.formKey,
    this.contentHeight,
    required this.contents,
    this.autovalidateMode,
  }) : super(key: key);

  @override
  State<SignInOrSignUpLayout> createState() => _SignInOrSignUpLayoutState();
}

class _SignInOrSignUpLayoutState extends State<SignInOrSignUpLayout> {
  var _isKeyboardOpen = false;
  _onKeyboardOpen(BuildContext context) {
    if (MediaQuery.of(context).viewInsets.bottom > 0.0 && !_isKeyboardOpen) {
      _isKeyboardOpen = true;
      // debugPrint("Keyboard Open");
    } else if (MediaQuery.of(context).viewInsets.bottom == 0.0 &&
        _isKeyboardOpen) {
      _isKeyboardOpen = false;
      // debugPrint("Keyboard Close");
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    _onKeyboardOpen(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background_2.png'),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Positioned(
          top: size.height * 1 / 6.5,
          width: size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SvgPicture.asset(
              'assets/images/logo.svg',
              alignment: Alignment.center,
              width: size.width,
              color: MyColors.semiDarkColor,
            ),
          ),
        ),
        Positioned(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          width: size.width,
          child: Column(children: [
            Visibility(
              visible: !_isKeyboardOpen,
              child: SvgPicture.asset(
                'assets/images/person.svg',
                alignment: Alignment.center,
                height: size.height * 1 / 4,
              ),
            ),
            Container(
              width: size.width,
              height: this.widget.contentHeight,
              margin: EdgeInsets.only(
                left: size.width * (1 / 12),
                right: size.width * (1 / 12),
                bottom: 24,
              ),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                  color: _isKeyboardOpen
                      ? MyColors.primaryLightColor
                      : Color.fromARGB(100, 255, 255, 255),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      spreadRadius: 5,
                      blurRadius: 45,
                      offset: Offset(0, 5),
                    ),
                  ]),
              child: Form(
                key: this.widget.formKey,
                autovalidateMode: this.widget.autovalidateMode,
                child: Column(children: this.widget.contents),
              ),
            ),
          ]),
        ),
      ]),
    );
  }
}

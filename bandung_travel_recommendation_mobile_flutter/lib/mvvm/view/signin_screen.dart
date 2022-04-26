import 'package:bandung_travel_recommendation_mobile_flutter/componens/text_form_custom_v1.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignInScreen extends StatefulWidget {
  static const routeName = '/Auth/SignInScreen';
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
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
          bottom: 0,
          width: size.width,
          child: Column(children: [
            SvgPicture.asset(
              'assets/images/person.svg',
              alignment: Alignment.center,
              height: size.height * 1 / 4,
            ),
            Container(
              width: size.width,
              height: size.height * 1 / 3.5,
              margin: EdgeInsets.only(
                  left: size.width * (1 / 12),
                  right: size.width * (1 / 12),
                  bottom: 24),
              decoration: BoxDecoration(
                  color: Color.fromARGB(100, 255, 255, 255),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      spreadRadius: 5,
                      blurRadius: 45,
                      offset: Offset(0, 5), // changes position of shadow
                    ),
                  ]),
              child: Form(
                key: _formKey,
                child: Column(children: <Widget>[
                  SizedBox(height: 18),
                  Text(
                    "Hai, Welcome Back",
                    style: TextStyle(
                      color: MyColors.DarkColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 12),
                  // Text(
                  //   "Error Message in Here",
                  //   style: TextStyle(
                  //     color: MyColors.ErrorColor,
                  //     fontWeight: FontWeight.normal,
                  //     fontSize: 10,
                  //   ),
                  // ),
                  // SizedBox(height: 6),
                  TextFormCustomV1(
                    hintText: "Enter your email",
                    margin: EdgeInsets.symmetric(horizontal: 24),
                    icon: Icon(
                      Icons.email,
                      color: MyColors.whiteColor,
                      size: 24,
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 6),
                  TextFormCustomV1(
                    hintText: "Enter your password",
                    margin: EdgeInsets.symmetric(horizontal: 24),
                    icon: Icon(
                      Icons.lock_rounded,
                      color: MyColors.whiteColor,
                      size: 24,
                    ),
                    isPassword: true,
                  ),
                  SizedBox(height: 6),
                  TextButtonCustomV1(),
                ]),
              ),
            ),
          ]),
        ),
      ]),
    );
  }
}

class TextButtonCustomV1 extends StatelessWidget {
  // final String text;
  const TextButtonCustomV1({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      child: TextButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          backgroundColor: MyColors.primaryColor,
          padding:
              EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Sign In",
              style: TextStyle(
                color: MyColors.whiteColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

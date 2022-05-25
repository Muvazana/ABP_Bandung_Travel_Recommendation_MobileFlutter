import 'package:bandung_travel_recommendation_mobile_flutter/componens/text_button_custom_v1.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/componens/text_form_custom_v1.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/auth/view/layout/signin_or_signup_layout.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

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
    // final size = MediaQuery.of(context).size;
    return SignInOrSignUpLayout(
      formKey: this._formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      contents: <Widget>[
        Text(
          "Welcome Back",
          style: TextStyle(
            color: MyColors.darkColor,
            fontWeight: FontWeight.bold,
            fontSize: 24,
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
          icon: Icon(
            Icons.email,
            color: MyColors.whiteColor,
            size: 24,
          ),
          keyboardType: TextInputType.emailAddress,
          validator: MultiValidator([
            RequiredValidator(errorText: "* Required!"),
            EmailValidator(errorText: "Email not Valid!")
          ]),
        ),
        SizedBox(height: 6),
        TextFormCustomV1(
          hintText: "Enter your password",
          icon: Icon(
            Icons.lock_rounded,
            color: MyColors.whiteColor,
            size: 24,
          ),
          isPassword: true,
          validator: RequiredValidator(errorText: "* Required!"),
        ),
        SizedBox(height: 8),
        TextButtonCustomV1(
          text: "Sign In",
          backgroundColor: MyColors.primaryColor,
          textColor: MyColors.whiteColor,
          elevation: 0,
          onPressed: () {
            if (this._formKey.currentState!.validate()) {
              debugPrint("Valid");
            } else {
              debugPrint("Not Valid");
            }
          },
        ),
        SizedBox(height: 6),
        Row(children: [
          Text(
            "Don't have an account? ",
            style: TextStyle(
              color: MyColors.semiDarkColor,
              fontSize: 12,
            ),
          ),
          InkWell(
            child: Text(
              "Sign Up",
              style: TextStyle(
                  color: MyColors.darkColor,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
            onTap: () {},
          ),
        ]),
      ],
    );
  }
}

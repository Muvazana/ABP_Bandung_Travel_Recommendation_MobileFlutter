import 'package:bandung_travel_recommendation_mobile_flutter/componens/text_button_custom_v1.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/componens/text_form_custom_v1.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/auth/model/user_model.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/auth/view/layout/signin_or_signup_layout.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/auth/view/signup_screen.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/auth/view_model/auth_viewmodel.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/utils/const.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class SignInScreen extends StatelessWidget {
  static const routeName = '/Auth/SignInScreen';
  SignInScreen({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SignInOrSignUpLayout(
      formKey: this._formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      contents: <Widget>[
        Text(
          "Welcome Back",
          style: TextStyle(
            color: MyColorsConst.darkColor,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        SizedBox(height: 12),
        TextFormCustomV1(
          hintText: "Enter your email",
          icon: Icon(
            Icons.email,
            color: MyColorsConst.whiteColor,
            size: 24,
          ),
          keyboardType: TextInputType.emailAddress,
          controller: emailController,
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
            color: MyColorsConst.whiteColor,
            size: 24,
          ),
          isPassword: true,
          controller: passwordController,
          validator: RequiredValidator(errorText: "* Required!"),
        ),
        SizedBox(height: 8),
        TextButtonCustomV1(
          text: "Sign In",
          backgroundColor: MyColorsConst.primaryColor,
          textColor: MyColorsConst.whiteColor,
          elevation: 0,
          onPressed: () {
            var user = UserModel(
              email: emailController.text,
              password: passwordController.text,
            );
            context.read<AuthViewModel>().loginProcess(
                  context,
                  userModel: user,
                  isFormValid: this._formKey.currentState!.validate(),
                );
          },
        ),
        SizedBox(height: 6),
        Row(children: [
          Text(
            "Don't have an account? ",
            style: TextStyle(
              color: MyColorsConst.semiDarkColor,
              fontSize: 12,
            ),
          ),
          InkWell(
            child: Text(
              "Sign Up",
              style: TextStyle(
                color: MyColorsConst.darkColor,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () =>
                Navigator.pushReplacementNamed(context, SignUpScreen.routeName),
          ),
        ]),
      ],
    );
  }
}

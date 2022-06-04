import 'dart:convert';

import 'package:bandung_travel_recommendation_mobile_flutter/componens/loading_cutom.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/componens/snackbar_custom.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/auth/model/auth_services.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/auth/model/user_model.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/auth/view/signin_or_signup_screen.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/auth/view/signin_screen.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/menu/model/user_services.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/menu/view/layout/sidebar_layout.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/menu/view_model/menu_viewmodel.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/utils/services.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/utils/shared_pref.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class AuthViewModel extends ChangeNotifier {
  void registerProcess(
    BuildContext context, {
    required UserModel userModel,
    required bool isFormValid,
  }) async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (isFormValid) {
      LoadingCustom.show(context);
      var res = await AuthServices.register(userModel);
      LoadingCustom.dismiss(context);
      if (res is ServicesSuccess) {
        SnackbarCustom.show(
          context,
          snackbarCustomModel: SnackbarCustomModel(
            title: "Create Account",
            message: "Account created successfully!",
            status: SnackbarCustomEnum.SUCCESS,
          ),
        );
        Navigator.pushReplacementNamed(context, SignInScreen.routeName);
      } else {
        res = res as ServicesFailure;
        SnackbarCustom.show(
          context,
          snackbarCustomModel: SnackbarCustomModel(
            title: "Create Account",
            message: "Failed to create an account!",
            //  + response.errorResponse.toString(),
            status: SnackbarCustomEnum.ERROR,
          ),
        );
      }
    } else {
      SnackbarCustom.show(
        context,
        snackbarCustomModel: SnackbarCustomModel(
          title: "Error",
          message: "Invalid Form Field!",
          status: SnackbarCustomEnum.ERROR,
        ),
      );
    }
  }

  void loginProcess(
    BuildContext context, {
    required UserModel userModel,
    required bool isFormValid,
  }) async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (isFormValid) {
      LoadingCustom.show(context);
      var res = await AuthServices.login(userModel);
      if (res is ServicesSuccess) {
        // debugPrint(response.response["user"].toString());
        var user = UserModel.fromMapApi(res.response);
        res = await GeneralSharedPreferences.saveUserData(user);
        if (res is ServicesSuccess) {
          var provider = context.read<MenuViewModel>();
          provider.setUpMenu();
          provider.setUserLogged = user;
          res = await provider.fetchPlacesFromServer(user.token!);
          LoadingCustom.dismiss(context);
          if (res is ServicesFailure) {
            SnackbarCustom.show(
              context,
              snackbarCustomModel: SnackbarCustomModel(
                title: "Sign In",
                message:
                    "Sign In success!\nBut, Failed to fetch Place Data:\nPlease check your internet connection and restart this App",
                status: SnackbarCustomEnum.INFO,
              ),
            );
          } else {
            SnackbarCustom.show(
              context,
              snackbarCustomModel: SnackbarCustomModel(
                title: "Sign In",
                message: "Sign In success!",
                status: SnackbarCustomEnum.SUCCESS,
              ),
            );
          }
          await Navigator.pushNamedAndRemoveUntil(
            context,
            SidebarLayout.routeName,
            (Route<dynamic> route) => false,
          );
        } else {
          res = res as ServicesFailure;
          SnackbarCustom.show(
            context,
            snackbarCustomModel: SnackbarCustomModel(
              title: "Failed to Sign In!",
              message: res.errorResponse.toString(),
              status: SnackbarCustomEnum.ERROR,
            ),
          );
        }
      } else {
        LoadingCustom.dismiss(context);
        res = res as ServicesFailure;
        SnackbarCustom.show(
          context,
          snackbarCustomModel: SnackbarCustomModel(
            title: "Failed to Sign In!",
            message: res.errorResponse.toString(),
            status: SnackbarCustomEnum.ERROR,
          ),
        );
      }
    } else {
      SnackbarCustom.show(
        context,
        snackbarCustomModel: SnackbarCustomModel(
          title: "Error",
          message: "Invalid Form Field!",
          status: SnackbarCustomEnum.ERROR,
        ),
      );
    }
  }

  void checkUserTokenExist(BuildContext context) async {
    LoadingCustom.show(context);
    var res = await GeneralSharedPreferences.getUserData();
    if (res is ServicesSuccess) {
      var user = UserModel.fromMapPref(res.response);
      res = await UserServices.getInformation(user.token!);
      if (res is ServicesSuccess) {
        var provider = context.read<MenuViewModel>();
        provider.setUpMenu();
        provider.setUserLogged = user;
        res = await provider.fetchPlacesFromServer(user.token!);
        LoadingCustom.dismiss(context);
        if (res is ServicesFailure) {
          SnackbarCustom.show(
            context,
            snackbarCustomModel: SnackbarCustomModel(
              title: "Sign In",
              message:
                  "Sign In success!\nBut, Failed to fetch Place Data:\nPlease check your internet connection and restart this App",
              status: SnackbarCustomEnum.INFO,
            ),
          );
        } else {
          SnackbarCustom.show(
            context,
            snackbarCustomModel: SnackbarCustomModel(
              title: "Sign In",
              message: "Sign In success!",
              status: SnackbarCustomEnum.SUCCESS,
            ),
          );
        }
        await Navigator.pushNamedAndRemoveUntil(
          context,
          SidebarLayout.routeName,
          (Route<dynamic> route) => false,
        );
      } else {
        await GeneralSharedPreferences.removeUserData();
        SnackbarCustom.show(
          context,
          snackbarCustomModel: SnackbarCustomModel(
            title: "Failed to Sign In!",
            message: "Invalid Token!",
            status: SnackbarCustomEnum.ERROR,
          ),
        );
      }
    }
    LoadingCustom.dismiss(context);
  }

  void logoutProcess(BuildContext context) async {
    LoadingCustom.show(context);
    var res = await GeneralSharedPreferences.getUserData();
    if (res is ServicesSuccess) {
      var user = UserModel.fromMapPref(res.response);
      res = await AuthServices.logout(user.token!);
      if (res is ServicesSuccess) {
        await GeneralSharedPreferences.removeUserData();
        LoadingCustom.dismiss(context);
        SnackbarCustom.show(
          context,
          snackbarCustomModel: SnackbarCustomModel(
            title: "Logout",
            message: "Logout success!",
            status: SnackbarCustomEnum.SUCCESS,
          ),
        );
        await Navigator.pushNamedAndRemoveUntil(
          context,
          SignInOrSignUpScreen.routeName,
          (Route<dynamic> route) => false,
        );
      } else {
        SnackbarCustom.show(
          context,
          snackbarCustomModel: SnackbarCustomModel(
            title: "Failed to Logout!",
            message:
                "Please check your internet connection and restart this App",
            status: SnackbarCustomEnum.ERROR,
          ),
        );
      }
    }
    LoadingCustom.dismiss(context);
  }
}

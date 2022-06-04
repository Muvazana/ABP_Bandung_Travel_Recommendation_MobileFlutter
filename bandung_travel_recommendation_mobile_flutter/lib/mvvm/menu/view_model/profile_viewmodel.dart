import 'package:bandung_travel_recommendation_mobile_flutter/componens/loading_cutom.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/componens/snackbar_custom.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/auth/model/user_model.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/menu/model/user_services.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/menu/view_model/menu_viewmodel.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/utils/services.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/utils/shared_pref.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class ProfileViewModel extends ChangeNotifier {
  bool _isEdit = false;

  bool get isEdit => _isEdit;

  changeEditorSave(
    BuildContext context, {
    required UserModel newUserModel,
    required bool isFormValid,
  }) async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (_isEdit) {
      var user = context.read<MenuViewModel>().getUserLogged;
      user = user!.copyWith(name: newUserModel.name, password: newUserModel.password);
      await _editProcess(
        context,
        userModel: user,
        isFormValid: isFormValid,
      );
      _isEdit = !_isEdit;
    } else {
      _isEdit = !_isEdit;
    }
    notifyListeners();
  }

  Future<void> _editProcess(
    BuildContext context, {
    required UserModel userModel,
    required bool isFormValid,
  }) async {
    if (isFormValid) {
      LoadingCustom.show(context);
      var res = await UserServices.edit(userModel);
      if (res is ServicesSuccess) {
        res = await GeneralSharedPreferences.saveUserData(userModel);
        if (res is ServicesSuccess) {
          context.read<MenuViewModel>().setUserLogged =
              userModel.copyWith(password: null);
          SnackbarCustom.show(
            context,
            snackbarCustomModel: SnackbarCustomModel(
              title: "Edit Profile",
              message: "Edit Profile success!",
              status: SnackbarCustomEnum.SUCCESS,
            ),
          );
        } else {
          res = res as ServicesFailure;
          SnackbarCustom.show(
            context,
            snackbarCustomModel: SnackbarCustomModel(
              title: "Error!",
              message: "Please restart this App",
              status: SnackbarCustomEnum.ERROR,
            ),
          );
        }
      } else {
        res = res as ServicesFailure;
        SnackbarCustom.show(
          context,
          snackbarCustomModel: SnackbarCustomModel(
            title: "Failed to Edit Profile!",
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
    LoadingCustom.dismiss(context);
  }
}

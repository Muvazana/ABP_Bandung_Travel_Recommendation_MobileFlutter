import 'package:bandung_travel_recommendation_mobile_flutter/componens/loading_cutom.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/componens/snackbar_custom.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/menu/model/favorite_place_model.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/menu/model/place_model.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/menu/model/user_services.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/menu/view_model/menu_viewmodel.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/utils/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class AddScheduleViewModel extends ChangeNotifier {
  int _currentStepperIndex = 0;
  List<PlaceModel> _selectedPlaces = [];

  int get currentStepperIndex => _currentStepperIndex;
  List<PlaceModel> get getSelectedPlaces => _selectedPlaces;

  StepState getStepState(int stepperIndex) {
    return _currentStepperIndex > stepperIndex
        ? StepState.complete
        : _currentStepperIndex == stepperIndex
            ? StepState.editing
            : StepState.indexed;
  }

  void addSelectedPlaces(PlaceModel place) {
    _selectedPlaces.add(place);
    notifyListeners();
  }

  void setUpAddSchedule() {
    _currentStepperIndex = 0;
    _selectedPlaces.clear();
    notifyListeners();
  }

  void removeSelectedPlaces(PlaceModel place) {
    _selectedPlaces.removeWhere((element) => place.id == element.id);
    notifyListeners();
  }

  void onStepContinue(BuildContext context, int maxStep) {
    var isLastStep = (maxStep - 1) == _currentStepperIndex;
    if (isLastStep) {
      _addSchedule2Server(context);
    } else {
      _currentStepperIndex += 1;
    }
    notifyListeners();
  }

  void _addSchedule2Server(BuildContext context) async {
    if (_selectedPlaces.isNotEmpty) {
      LoadingCustom.show(context);
      var menuProvider = context.read<MenuViewModel>();
      var token = menuProvider.getUserLogged!.token!;
      var res = await UserServices.addFavoritePlace(
          token: token, places: _selectedPlaces);
      if (res is ServicesSuccess) {
        res = await UserServices.getFavoritePlaces(token);
        if (res is ServicesSuccess) {
          menuProvider.setFavoritePlaces =
              FavoritePlaceModel.favoritePlaceFromMap(res.response);
          LoadingCustom.dismiss(context);
          notifyListeners();
          SnackbarCustom.show(
            context,
            snackbarCustomModel: SnackbarCustomModel(
              title: "Add Schedule",
              message: "Add Schedule Success!",
              status: SnackbarCustomEnum.SUCCESS,
            ),
          );
        } else {
          LoadingCustom.dismiss(context);
          SnackbarCustom.show(
            context,
            snackbarCustomModel: SnackbarCustomModel(
              title: "Add Schedule",
              message:
                  "Add Schedule Success!\nBut, Failed to Fetch Favorite Place Data \nPlease check your internet connection and restart this App",
              status: SnackbarCustomEnum.ERROR,
            ),
          );
        }
        Navigator.pop(context);
      } else {
        LoadingCustom.dismiss(context);
        res = res as ServicesFailure;
        debugPrint("dadada"+ res.errorResponse);
        SnackbarCustom.show(
          context,
          snackbarCustomModel: SnackbarCustomModel(
            title: "Add Schedule",
            message: "Failed to Add Schedule!",
            status: SnackbarCustomEnum.ERROR,
          ),
        );
      }
    } else {
      SnackbarCustom.show(
        context,
        snackbarCustomModel: SnackbarCustomModel(
          title: "Error",
          message: "Please Select Destination First!",
          status: SnackbarCustomEnum.ERROR,
        ),
      );
    }
  }

  void onStepCancel(BuildContext context) {
    if (_currentStepperIndex == 0) {
      // _selectedPlaces.clear;
      // Navigator.pop(context);
      // debugPrint("on cancel Clicked");
    } else {
      _currentStepperIndex -= 1;
    }
    notifyListeners();
  }
}

import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/menu/model/place_model.dart';
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

  void removeSelectedPlaces(PlaceModel place) {
    _selectedPlaces.removeWhere((element) => place.id == element.id,);
    notifyListeners();
  }

  void onStepContinue(int maxStep) {
    var isLastStep = (maxStep - 1) == _currentStepperIndex;
    if (isLastStep) {
      // TODO when last step
      debugPrint("on last step Clicked %");
    } else {
      _currentStepperIndex += 1;
    }
    notifyListeners();
  }

  void onStepCancel() {
    if (_currentStepperIndex == 0) {
      // TODO when first step
      debugPrint("on cancel Clicked");
    } else {
      _currentStepperIndex -= 1;
    }
    notifyListeners();
  }
}

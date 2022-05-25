import 'package:bandung_travel_recommendation_mobile_flutter/utils/const.dart';
import 'package:flutter/material.dart';

class ProfileViewModel extends ChangeNotifier {
  bool _isEdit = false;

  bool get isEdit => _isEdit;

  changeEditorSave() {
    if (_isEdit) {
      // TODO when profile in Edit Mode
      _isEdit = !_isEdit;
    } else {
      _isEdit = !_isEdit;
    }
    notifyListeners();
  }
}

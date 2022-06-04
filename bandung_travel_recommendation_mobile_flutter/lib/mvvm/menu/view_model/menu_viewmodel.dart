import 'package:bandung_travel_recommendation_mobile_flutter/componens/loading_cutom.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/componens/snackbar_custom.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/auth/model/user_model.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/menu/model/favorite_place_model.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/menu/model/place_model.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/menu/model/dest_services.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/menu/model/user_services.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/utils/const.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/utils/services.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';

class MenuViewModel extends ChangeNotifier {
  AppBar? _appBarTitle;
  SidebarXController? _sidebarXController;
  UserModel? _userLogged;
  PlaceModel? _placeById;
  List<PlaceModel>? _placesDest;
  List<PlaceModel>? _placesHotel;
  List<FavoritePlaceModel>? _favoritesDest;

  MenuViewModel() {
    _sidebarXController = SidebarXController(selectedIndex: 0, extended: true);
    setOnSidebarItemSelected();
  }

  AppBar? get getAppBarTitle => _appBarTitle;
  SidebarXController? get getSidebarXController => _sidebarXController;
  UserModel? get getUserLogged => _userLogged;
  // PlaceModel? get getPlaceById => _placeById;
  List<PlaceModel>? get getPlacesDest => _placesDest;
  List<PlaceModel>? get getPlacesHotel => _placesHotel;
  List<FavoritePlaceModel>? get getFavoritesDest => _favoritesDest;

  set setFavoritePlaces(List<FavoritePlaceModel> favoritesDest) {
    _favoritesDest = favoritesDest;
    notifyListeners();
  }

  void deleteFavoritePlaces(
    BuildContext context, {
    required FavoritePlaceModel favoritePlace,
  }) async {
    LoadingCustom.show(context);
    if (_userLogged != null) {
      var res = await UserServices.deleteFavoritePlace(
          token: _userLogged!.token!, favoritePlace: favoritePlace);
      if (res is ServicesSuccess) {
        res = await UserServices.getFavoritePlaces(_userLogged!.token!);
        if (res is ServicesSuccess) {
          _favoritesDest =
              FavoritePlaceModel.favoritePlaceFromMap(res.response);
          LoadingCustom.dismiss(context);
          notifyListeners();
          SnackbarCustom.show(
            context,
            snackbarCustomModel: SnackbarCustomModel(
              title: "Delete",
              message: "Delete Favorite Place Success!",
              status: SnackbarCustomEnum.SUCCESS,
            ),
          );
        } else {
          LoadingCustom.dismiss(context);
          SnackbarCustom.show(
            context,
            snackbarCustomModel: SnackbarCustomModel(
              title: "Delete",
              message:
                  "Please check your internet connection and restart this App",
              status: SnackbarCustomEnum.ERROR,
            ),
          );
        }
      } else {
        LoadingCustom.dismiss(context);
        SnackbarCustom.show(
          context,
          snackbarCustomModel: SnackbarCustomModel(
            title: "Delete",
            message:
                "Please check your internet connection and restart this App",
            status: SnackbarCustomEnum.ERROR,
          ),
        );
      }
    } else {
      LoadingCustom.dismiss(context);
      SnackbarCustom.show(
        context,
        snackbarCustomModel: SnackbarCustomModel(
          title: "Delete",
          message: "Please check your internet connection and restart this App",
          status: SnackbarCustomEnum.ERROR,
        ),
      );
    }
  }

  Future<Object> fetchPlacesFromServer(String token) async {
    var resServicesDest = await DestServices.getDestinations(token);
    var resServicesHotel = await DestServices.getHotels(token);
    var resServicesFavorite = await UserServices.getFavoritePlaces(token);
    if (resServicesDest is ServicesSuccess &&
        resServicesHotel is ServicesSuccess &&
        resServicesFavorite is ServicesSuccess) {
      _placesDest = PlaceModel.placesFromMap(resServicesDest.response);
      _placesHotel = PlaceModel.placesFromMap(resServicesHotel.response);
      _favoritesDest =
          FavoritePlaceModel.favoritePlaceFromMap(resServicesFavorite.response);
      notifyListeners();
      return ServicesSuccess(
        code: MyGeneralConst.CODE_PROCESS_SUCCESS,
        response: "Success Fetch Places From Server",
      );
    }
    return ServicesFailure(
      code: MyGeneralConst.CODE_UNKWON_ERROR,
      errorResponse: "Failed Fetch Places From Server!",
    );
  }

  Future<PlaceModel>? getPlaceById(PlaceModel placeModel) async {
    if (_userLogged != null) {
      var res = await DestServices.getPlaceById(
        token: _userLogged!.token!,
        place: placeModel,
      );
      if (res is ServicesSuccess) {
        return PlaceModel.fromMap(res.response);
      }
      return throw res as ServicesFailure;
    }
    return throw ServicesFailure(
        code: MyGeneralConst.CODE_UNKWON_ERROR, errorResponse: "Uknown Error");
  }

  void touchPlace(BuildContext context, PlaceModel placeModel) async {
    var res = await GeneralSharedPreferences.getUserData();
    if (res is ServicesSuccess) {
      var user = UserModel.fromMapPref(res.response);
      res =
          await UserServices.touchPlace(token: user.token!, place: placeModel);
      if (res is ServicesFailure) {
        SnackbarCustom.show(
          context,
          snackbarCustomModel: SnackbarCustomModel(
            title: "Failed to touch place",
            message:
                "Please check your internet connection and restart this App",
            status: SnackbarCustomEnum.ERROR,
          ),
        );
      }
    }
  }

  set setUserLogged(UserModel user) {
    _userLogged = user;
    notifyListeners();
  }

  setOnSidebarItemSelected({int? index}) {
    if (index != null) _sidebarXController!.selectIndex(index);
    var title = null;
    switch (_sidebarXController!.selectedIndex) {
      case 0:
        title = null;
        break;
      case 1:
        title = "Dashboard";
        break;
      case 2:
        title = "Favorite";
        break;
      case 3:
        title = "Profile";
        break;
      default:
        title = "Error";
        break;
    }
    _appBarTitle = title != null
        ? AppBar(
            title: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            backgroundColor: MyColorsConst.primaryColor,
          )
        : null;
    notifyListeners();
  }
}

import 'package:bandung_travel_recommendation_mobile_flutter/componens/cache_network_image_custom.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/componens/text_button_custom_v1.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/componens/timeline_tile_custom.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/menu/model/place_model.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/menu/view_model/menu_viewmodel.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/utils/const.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class MyModalBottomSheetCustom {
  MyModalBottomSheetCustom(String imageName);

  static showScheduleDetail(BuildContext context,
      {required List<PlaceModel> place}) {
    var size = MediaQuery.of(context).size;
    var textStyle = TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: MyColorsConst.semiDarkColor,
    );

    return _buildMainModalBottomSheetCustom(
      context,
      title: "Schedule Detail",
      content: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 16),
        shrinkWrap: true,
        itemBuilder: (context, index) => TimeLineTileCustom(
          place.elementAt(index).name!,
          isFirst: index == 0,
          isLast: index == place.length - 1,
        ),
        itemCount: place.length,
      ),
    );
  }

  static showPlaceDetail(BuildContext context, {required PlaceModel place}) {
    var provider = context.read<MenuViewModel>();
    provider.touchPlace(context, place);

    var size = MediaQuery.of(context).size;
    var textStyle = TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: MyColorsConst.semiDarkColor,
    );
    Widget buildDetail(PlaceModel _place) => ListView(
          padding: EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 16),
          children: <Widget>[
            CacheNetworkImageCustom(
              _place.imageName != null
                  ? "${MyGeneralConst.API_IMAGE_URL}/${_place.imageName}"
                  : "dummy",
              width: double.infinity,
              height: size.height / 4,
            ),
            SizedBox(height: 18),
            Text(
              _place.name ?? '',
              style: textStyle,
            ),
            Text(
              _place.placeType?.name ?? '',
              style: textStyle.copyWith(
                fontWeight: FontWeight.normal,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Google Rating: ${_place.rate.toString()} ⭐",
                  style: textStyle.copyWith(
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                  ),
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.visibility,
                      color: MyColorsConst.semiDarkColor,
                      size: 16,
                    ),
                    SizedBox(width: 6),
                    Text(
                      _place.view.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: MyColorsConst.semiDarkColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              "${_place.description} ${_place.description}",
              textAlign: TextAlign.justify,
              style: textStyle.copyWith(
                fontWeight: FontWeight.normal,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 16),
            TextButtonCustomV1(
              text: "Open in Google Map",
              onPressed: () {
                // TODO when Open in Google Map clicked
              },
            ),
          ],
        );
    return _buildMainModalBottomSheetCustom(
      context,
      title: "Place Detail",
      content: FutureBuilder(
        future: provider.getPlaceById(place),
        builder: (context, snap) {
          Widget child;
          if (snap.hasData)
            child = buildDetail(snap.data as PlaceModel);
          else if (snap.hasError) {
            child = Container(
              child: Center(
                child: Text(
                  "Error when Fetch Data!",
                  style: textStyle.copyWith(
                    color: MyColorsConst.errorColor,
                  ),
                ),
              ),
            );
          } else {
            child = Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return child;
        },
      ),
    );
  }

  static _buildMainModalBottomSheetCustom(BuildContext context,
      {required String title, required Widget content}) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.85,
          minChildSize: 0.4,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: MyColorsConst.whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          width: 50,
                          child: Divider(
                            color: Colors.black26,
                            thickness: 3,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              title,
                              maxLines: 1,
                              style: TextStyle(
                                color: MyColorsConst.semiDarkColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                            IconButton(
                              onPressed: () => Navigator.of(context).pop(),
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints(),
                              icon: Icon(
                                Icons.close_sharp,
                                color: MyColorsConst.semiDarkColor,
                                size: 32,
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          color: Colors.black26,
                          thickness: 1,
                        ),
                      ],
                    ),
                  ),
                  // Content
                  Expanded(child: content),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

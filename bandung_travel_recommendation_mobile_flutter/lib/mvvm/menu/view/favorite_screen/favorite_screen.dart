import 'package:bandung_travel_recommendation_mobile_flutter/componens/modal_bottom_sheet_custom.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/componens/timeline_tile_custom.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/menu/model/favorite_place_model.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/menu/view/favorite_screen/add_schedule_screen.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/menu/view_model/menu_viewmodel.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/utils/const.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<MenuViewModel>();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: provider.getFavoritesDest != null &&
                provider.getFavoritesDest!.length > 0
            ? ListView.builder(
                itemBuilder: (context, index) => card_expansion_custom_v1(
                  favoritePlace: provider.getFavoritesDest!.elementAt(index),
                ),
                itemCount: provider.getFavoritesDest!.length,
              )
            : Center(
                child: Text(
                  "Not Create Favorite Destination yet!",
                  style: TextStyle(
                    color: MyColorsConst.semiDarkColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyColorsConst.primaryColor,
        child: Icon(
          Icons.add,
          color: MyColorsConst.whiteColor,
          size: 32,
        ),
        onPressed: () => Navigator.pushNamed(
          context,
          AddScheduleScreen.routeName,
        ),
      ),
    );
  }
}

class card_expansion_custom_v1 extends StatefulWidget {
  const card_expansion_custom_v1({
    Key? key,
    required this.favoritePlace,
  }) : super(key: key);

  final FavoritePlaceModel favoritePlace;

  @override
  State<card_expansion_custom_v1> createState() =>
      _card_expansion_custom_v1State();
}

class _card_expansion_custom_v1State extends State<card_expansion_custom_v1> {
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        context.read<MenuViewModel>().deleteFavoritePlaces(context,
            favoritePlace: this.widget.favoritePlace);
      },
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: _isExpanded
              ? MyColorsConst.primaryColor
              : MyColorsConst.whiteColor,
          semanticContainer: true,
          elevation: 3,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: ExpansionTile(
              initiallyExpanded: _isExpanded,
              onExpansionChanged: (value) {
                setState(() {
                  _isExpanded = value;
                });
              },
              // collapsedBackgroundColor: MyColors.whiteColor,
              // backgroundColor: Colors.transparent,
              collapsedTextColor: MyColorsConst.semiDarkColor,
              textColor: MyColorsConst.whiteColor,
              collapsedIconColor: MyColorsConst.semiDarkColor,
              iconColor: MyColorsConst.whiteColor,
              tilePadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.favoritePlace.places.map((e) => e.name).join('-'),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "${widget.favoritePlace.places.length} Place",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "created : ${widget.favoritePlace.createdAt.toLocal()}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              expandedAlignment: Alignment.centerLeft,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  padding: const EdgeInsets.all(8),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) => TimeLineTileCustom(
                      widget.favoritePlace.places.elementAt(index).name!,
                      isFirst: index == 0,
                      isLast: index == widget.favoritePlace.places.length - 1,
                      onTap: () => MyModalBottomSheetCustom.showPlaceDetail(
                        context,
                        place: widget.favoritePlace.places.elementAt(index),
                      ),
                    ),
                    itemCount: widget.favoritePlace.places.length,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

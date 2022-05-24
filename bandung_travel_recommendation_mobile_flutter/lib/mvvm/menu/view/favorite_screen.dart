import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/menu/model/favorite_place_model.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemBuilder: (context, index) => card_expansion_custom_v1(
            favoritePlace:
                FavoritePlace.dataDummyList(count: 6).elementAt(index),
          ),
          itemCount: FavoritePlace.dataDummyList(count: 6).length,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyColors.primaryColor,
        child: Icon(
          Icons.add,
          color: MyColors.whiteColor,
          size: 32,
        ),
        onPressed: () {
          // TODO event when floating button pressed
        },
      ),
    );
  }
}

class card_expansion_custom_v1 extends StatefulWidget {
  const card_expansion_custom_v1({
    Key? key,
    required this.favoritePlace,
  }) : super(key: key);

  final FavoritePlace favoritePlace;

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
        // TODO event when long pressed
        debugPrint("Long Pressed ID: ${this.widget.favoritePlace.id}");
      },
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: _isExpanded ? MyColors.primaryColor : MyColors.whiteColor,
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
              collapsedTextColor: MyColors.semiDarkColor,
              textColor: MyColors.whiteColor,
              collapsedIconColor: MyColors.semiDarkColor,
              iconColor: MyColors.whiteColor,
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
                    itemBuilder: (context, index) => _timelineTile(
                      widget.favoritePlace.places.elementAt(index).name,
                      isFirst: index == 0,
                      isLast: index == widget.favoritePlace.places.length - 1,
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

  Widget _timelineTile(
    String title, {
    bool isFirst = false,
    bool isLast = false,
  }) {
    return TimelineTile(
      alignment: TimelineAlign.start,
      isFirst: isFirst,
      isLast: isLast,
      indicatorStyle:
          IndicatorStyle(width: 12, height: 12, color: MyColors.primaryColor),
      afterLineStyle: LineStyle(thickness: 3, color: MyColors.primaryColor),
      beforeLineStyle: LineStyle(thickness: 3, color: MyColors.primaryColor),
      endChild: Container(
        margin: const EdgeInsets.only(left: 8),
        alignment: Alignment.centerLeft,
        constraints: const BoxConstraints(
          minHeight: 30,
        ),
        child: Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: MyColors.semiDarkColor,
            fontSize: 16,
            // fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

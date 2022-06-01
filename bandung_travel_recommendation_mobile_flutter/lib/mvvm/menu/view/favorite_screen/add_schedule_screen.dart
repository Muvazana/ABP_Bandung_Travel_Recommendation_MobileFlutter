import 'package:bandung_travel_recommendation_mobile_flutter/componens/card/schedule_place_card.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/componens/modal_bottom_sheet_custom.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/componens/text_button_custom_v1.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/componens/timeline_tile_custom.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/menu/model/place_model.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/mvvm/menu/view_model/add_schedule_viewmodel.dart';
import 'package:bandung_travel_recommendation_mobile_flutter/utils/const.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class AddScheduleScreen extends StatelessWidget {
  static const routeName = '/Menu/AddScheduleScreen';
  const AddScheduleScreen({Key? key}) : super(key: key);
  final TextStyle textStyle = const TextStyle(
    color: MyColorsConst.semiDarkColor,
    fontSize: 14,
  );
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var watchScheduleProvider = context.watch<AddScheduleViewModel>();
    var readScheduleProvider = context.read<AddScheduleViewModel>();
    var places = PlaceModel.dataDummyList(count: 25);
    List<Step> getSteps = [
      Step(
        state: readScheduleProvider.getStepState(0),
        isActive: watchScheduleProvider.currentStepperIndex >= 0,
        title: Text(
          'Hotel',
          style: textStyle,
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Select Hotels :",
              style: textStyle.copyWith(fontSize: 18),
            ),
            SizedBox(height: 8),
            ListView.builder(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: places.length,
              itemBuilder: (context, index) {
                return SchedulePlaceCard(
                  imageUrl: places.elementAt(index).imageName,
                  title: places.elementAt(index).name,
                  description: places.elementAt(index).description,
                  view: places.elementAt(index).view.toString(),
                  onLongPress: () {
                    MyModalBottomSheetCustom.showPlaceDetail(
                      context,
                      place: places.elementAt(index),
                    );
                  },
                  onTap: (isSelected) {
                    // TODO when Card Selected
                    if (isSelected)
                      readScheduleProvider
                          .addSelectedPlaces(places.elementAt(index));
                    else
                      readScheduleProvider
                          .removeSelectedPlaces(places.elementAt(index));
                  },
                );
              },
            ),
          ],
        ),
      ),
      Step(
        state: readScheduleProvider.getStepState(1),
        isActive: watchScheduleProvider.currentStepperIndex >= 1,
        title: Text(
          'Place',
          style: textStyle,
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Select Places :",
              style: textStyle.copyWith(fontSize: 18),
            ),
            SizedBox(height: 8),
            ListView.builder(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: places.length,
              itemBuilder: (context, index) {
                return SchedulePlaceCard(
                  imageUrl: places.elementAt(index).imageName,
                  title: places.elementAt(index).name,
                  description: places.elementAt(index).description,
                  view: places.elementAt(index).view.toString(),
                  onLongPress: () {
                    MyModalBottomSheetCustom.showPlaceDetail(
                      context,
                      place: places.elementAt(index),
                    );
                  },
                  onTap: (isSelected) {
                    // TODO when Card Selected
                    if (isSelected)
                      readScheduleProvider
                          .addSelectedPlaces(places.elementAt(index));
                    else
                      readScheduleProvider
                          .removeSelectedPlaces(places.elementAt(index));
                  },
                );
              },
            ),
          ],
        ),
      ),
      Step(
        state: readScheduleProvider.getStepState(2),
        isActive: watchScheduleProvider.currentStepperIndex >= 2,
        title: Text(
          'Finish',
          style: textStyle,
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Schedule Detail :",
              style: textStyle.copyWith(fontSize: 18),
            ),
            SizedBox(height: 8),
            ListView.builder(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) => TimeLineTileCustom(
                watchScheduleProvider.getSelectedPlaces.elementAt(index).name,
                isFirst: index == 0,
                isLast: index == watchScheduleProvider.getSelectedPlaces.length - 1,
              ),
              itemCount: watchScheduleProvider.getSelectedPlaces.length,
            )
          ],
        ),
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Schedule",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: MyColorsConst.primaryColor,
      ),
      body: Stepper(
        type: StepperType.horizontal,
        currentStep: watchScheduleProvider.currentStepperIndex,
        steps: getSteps,
        controlsBuilder: (context, details) => Container(),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(
          watchScheduleProvider, readScheduleProvider, getSteps),
      floatingActionButton:
          watchScheduleProvider.currentStepperIndex != (getSteps.length - 1)
              ? _buildFloatingButton(context)
              : null,
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildBottomNavigationBar(AddScheduleViewModel watchScheduleProvider,
          AddScheduleViewModel readScheduleProvider, List<Step> getSteps) =>
      Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: Offset(0, -5),
                blurRadius: 10,
                spreadRadius: 5),
          ],
        ),
        child: Row(
          children: <Widget>[
            if (watchScheduleProvider.currentStepperIndex != 0)
              Expanded(
                child: TextButtonCustomV1(
                  text: "Back",
                  isOutlineType: true,
                  textColor: MyColorsConst.primaryColor,
                  borderColor: MyColorsConst.primaryColor,
                  backgroundColor: Colors.transparent,
                  onPressed: readScheduleProvider.onStepCancel,
                ),
              ),
            SizedBox(width: 16),
            Expanded(
              child: TextButtonCustomV1(
                text: watchScheduleProvider.currentStepperIndex !=
                        (getSteps.length - 1)
                    ? "Next"
                    : "Save",
                onPressed: () =>
                    readScheduleProvider.onStepContinue(getSteps.length),
              ),
            ),
          ],
        ),
      );

  Widget _buildFloatingButton(BuildContext context) {
    var watchScheduleProvider = context.watch<AddScheduleViewModel>();
    return FittedBox(
      child: Stack(
        alignment: Alignment(1.1, -1.5),
        children: [
          FloatingActionButton.extended(
            onPressed: () {
              MyModalBottomSheetCustom.showScheduleDetail(
                context,
                // TODO change this to real data
                place: watchScheduleProvider.getSelectedPlaces,
              );
            },
            icon: Icon(
              Icons.not_listed_location,
              color: MyColorsConst.whiteColor,
            ),
            label: Text(
              "Schedule Detail",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: MyColorsConst.primaryColor,
          ),
          Container(
            child: Center(
              child: Text(
                watchScheduleProvider.getSelectedPlaces.length.toString(),
                style: TextStyle(color: Colors.white),
              ),
            ),
            padding: EdgeInsets.all(4),
            constraints: BoxConstraints(minHeight: 24, minWidth: 24),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  spreadRadius: 1,
                  blurRadius: 5,
                  color: Colors.black.withAlpha(50),
                )
              ],
              borderRadius: BorderRadius.circular(16),
              color: Colors.red, // This would be color of the Badge
            ),
          ),
        ],
      ),
    );
  }
}

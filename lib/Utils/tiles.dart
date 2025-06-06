import 'package:flutter/material.dart';

class foodTileData {
  final String labelfoodTile;
  final String foodTilesvgPath;

  // To be added in the future
  // // New field for data as to create the widget page. Will affect other data classes as well in the future
  // final Widget appPage;
  //
  // foodTileData({required this.labelfoodTile, required this.foodTilesvgPath, required this.appPage});
  foodTileData({required this.labelfoodTile, required this.foodTilesvgPath});
}

class filterTileData {
  final Color tileColor;
  final String filterLabel;
  final String filterSublabel;
  final String filterTilesvgPath;

  filterTileData({required this.tileColor,required this.filterLabel, required this.filterSublabel, required this.filterTilesvgPath,
  });
}

class btmnavgiationTilesData{
  final String btmnavigationTileLabel;
  final String btmnavigationAssetpath;

  // Creating the function to click on the bottom navigation first.
  final Widget appPage;

  btmnavgiationTilesData({required this.btmnavigationTileLabel, required this.btmnavigationAssetpath, required this.appPage});
}

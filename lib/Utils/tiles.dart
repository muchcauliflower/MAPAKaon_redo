import 'package:flutter/material.dart';

class foodTileData {
  final String labelfoodTile;
  final String foodTilesvgPath;

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

  btmnavgiationTilesData({required this.btmnavigationTileLabel, required this.btmnavigationAssetpath});
}

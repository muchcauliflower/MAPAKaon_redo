import 'package:flutter/material.dart';
import 'package:mapakaon_redo/Utils/tiles.dart';

// Declaration of data for foodTiles
final List<foodTileData> foodTiles = [
  foodTileData(labelfoodTile: "Fast Food", foodTilesvgPath: "assets/svgs/default/fastfoodTile.svg"),
  foodTileData(labelfoodTile: "Chicken", foodTilesvgPath: "assets/svgs/default/chickenTile.svg"),
  foodTileData(labelfoodTile: "Filipino", foodTilesvgPath: "assets/svgs/default/filipinoTile.svg"),
  foodTileData(labelfoodTile: "Asian", foodTilesvgPath: "assets/svgs/default/asianTile.svg"),
  foodTileData(labelfoodTile: "Burger", foodTilesvgPath: "assets/svgs/default/burgerTile.svg"),
  foodTileData(labelfoodTile: "Desserts", foodTilesvgPath: "assets/svgs/default/dessertsTile.svg"),
  foodTileData(labelfoodTile: "Coffee/Tea", foodTilesvgPath: "assets/svgs/default/coffeeTile.svg"),
  foodTileData(labelfoodTile: "More", foodTilesvgPath: "assets/svgs/default/moreTile.svg"),
];

// Declaration of data for filterTiles
final List<filterTileData> filterTiles = [
  filterTileData(tileColor: Color(0xFFC28C66), filterLabel: "Near Me", filterSublabel: "Get It Fast", filterTilesvgPath: "assets/svgs/svgfilterTiles/filterNearby.svg"),
  filterTileData(tileColor: Color(0xFF3960A2), filterLabel: "Trending", filterSublabel: "See whats popular", filterTilesvgPath: "assets/svgs/svgfilterTiles/filterTrending.svg"),
  filterTileData(tileColor: Color(0xFF48736A), filterLabel: "From Iloilo", filterSublabel: "Hala Bira! Iloilo!", filterTilesvgPath: "assets/svgs/svgfilterTiles/filterIloilo.svg"),
  filterTileData(tileColor: Colors.transparent, filterLabel: "", filterSublabel: "", filterTilesvgPath: "assets/svgs/svgfilterTiles/placeholdernull.svg"), // THIS IS PLACEHOLDER BUT DO NOT REMOVE
];

final List<btmnavgiationTilesData> navigationTiles = [
  btmnavgiationTilesData(btmnavigationTileLabel: "Home", btmnavigationAssetpath: "assets/svgs/svgNavigation/default/homeDefault.svg"),
  btmnavgiationTilesData(btmnavigationTileLabel: "Maps", btmnavigationAssetpath: "assets/svgs/svgNavigation/default/mapsDefault.svg"),
  btmnavgiationTilesData(btmnavigationTileLabel: "History", btmnavigationAssetpath: "assets/svgs/svgNavigation/default/historyDefault.svg"),
  btmnavgiationTilesData(btmnavigationTileLabel: "Settings", btmnavigationAssetpath: "assets/svgs/svgNavigation/default/settingsDefault.svg"),
];
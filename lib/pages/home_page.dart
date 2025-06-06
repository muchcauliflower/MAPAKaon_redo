import 'dart:ui';
import 'package:flutter/material.dart';
import '../Utils/colors.dart';
import '../Utils/searchbar_Widget.dart';
import '../Utils/tiles_widget.dart';
import '../data/tilesData.dart';
import '';

class HomePage extends StatefulWidget {

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SingleChildScrollView(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Portion of the app. Will include the text Mayong Hapon! Header, Subheader
            // Also include the sections for food types

            Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 100, left: 24, right: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    searchbarWidget(controller: _searchController),
                    Text(
                      "Mayong Hapon!",
                      style: TextStyle(
                        fontFamily: 'FredokaOne',
                        fontSize: 34,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Insert Slogan here...? (Idk you pick)",
                      style: TextStyle(
                        fontFamily: 'FredokaOne',
                        fontSize: 16,
                        color: appColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 248,

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Upper row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(4, (index) {
                      return foodtileWidget(
                        labelfoodTile: foodTiles[index].labelfoodTile,
                        foodTilesvgPath: foodTiles[index].foodTilesvgPath,
                      );
                    }),
                  ),

                  // Padding inbetween
                  SizedBox(height: 20),

                  // Lower Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(4, (index) {
                      return foodtileWidget(
                        labelfoodTile: foodTiles[index + 4].labelfoodTile,
                        foodTilesvgPath: foodTiles[index + 4].foodTilesvgPath,
                      );
                    }),
                  ),
                ],
              ),
            ),

            // Mid Portion. Will hold container with only 3 tiles: Near me, Trending,
            // Iloilo Famous. Similar to  Top portion with rows and columns
            Container(
              height: 228,
              child: Padding(
                padding: const EdgeInsets.only(top: 7.5, left: 2, right: 2),
                // padding: const EdgeInsets.all(2.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(2, (index) {
                        return filtertileWidget(
                          tileColor: filterTiles[index].tileColor,
                          filterLabel: filterTiles[index].filterLabel,
                          filterSublabel: filterTiles[index].filterSublabel,
                          filterTilesvgPath: filterTiles[index].filterTilesvgPath,
                        );
                      }),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(2, (index) {
                        return filtertileWidget(
                          tileColor: filterTiles[index+2].tileColor,
                          filterLabel: filterTiles[index+2].filterLabel,
                          filterSublabel: filterTiles[index+2].filterSublabel,
                          filterTilesvgPath: filterTiles[index+2].filterTilesvgPath,
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5, left: 15, right: 15),
                  child: Text(
                    "Special Offers",
                    style: TextStyle(
                      fontFamily: 'FredokaOne',
                      fontSize: 27.5,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2.5, left: 15, right: 15),
                  child: Text(
                    "Insert Slogan here..? (Idk you pick?)",
                    style: TextStyle(
                      fontFamily: 'FredokaOne',
                      fontSize: 16,
                      color: appColor,
                    ),
                  ),
                ),

                Container(
                  height: 200,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(3, (index) {
                        return Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            width: 300,
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.greenAccent,
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

    );
  }
}

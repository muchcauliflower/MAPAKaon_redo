import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'colors.dart';

class foodtileWidget extends StatelessWidget {
  final String labelfoodTile;
  final String foodTilesvgPath;

  const foodtileWidget({
    required this.labelfoodTile,
    required this.foodTilesvgPath,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 104,
      width: 87,
      decoration: BoxDecoration(
        color: secondaryBgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(foodTilesvgPath, height: 40, width: 40),
          SizedBox(height: 8),
          Text(
            labelfoodTile,
            style: TextStyle(
              fontFamily: 'FredokaOne',
              fontSize: 12,
              color: Color(0xFF5B5B5B),
            ),
          ),
        ],
      ),
    );
  }
}

class filtertileWidget extends StatelessWidget {
  final Color tileColor;
  final String filterLabel;
  final String filterSublabel;
  final String filterTilesvgPath;

  const filtertileWidget({
    required this.tileColor,
    required this.filterLabel,
    required this.filterSublabel,
    required this.filterTilesvgPath,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 104,
      width: 188,
      decoration: BoxDecoration(
        color: tileColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          // Texts with padding
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 80),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    filterLabel,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: 'FredokaOne',
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    filterSublabel,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: 'FredokaOne',
                      fontSize: 9,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // SVG positioned bottom right
          Positioned(
            bottom: -20,
            right: -20,
            child: SvgPicture.asset(filterTilesvgPath, height: 100, width: 100),
          ),
        ],
      ),
    );
  }
}

class btmnavigationWidget extends StatelessWidget {
  final String btmnavigationTileLabel;
  final String btmnavigationAssetpath;

  const btmnavigationWidget({
    required this.btmnavigationTileLabel,
    required this.btmnavigationAssetpath,
    Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SvgPicture.asset(
            btmnavigationAssetpath,
            height: 60,
            width: 60,
        ),

        Text(
          btmnavigationTileLabel,
          style: TextStyle(
            fontFamily: 'fredokaOne',
            color: appColor,
          ),
        ),
      ],
    );
  }
}


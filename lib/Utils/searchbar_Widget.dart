import 'package:flutter/material.dart';
import 'package:mapakaon_redo/Utils/colors.dart';

class searchbarWidget extends StatelessWidget {
  final TextEditingController controller;

  const searchbarWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 15),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: secondaryBgColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 1),
          child: TextField(
            controller: controller,
            style: TextStyle(color: Color(0xFF5B5B5B)),
            decoration: InputDecoration(
              hintText: 'Search...',
              hintStyle: TextStyle(color: Color(0xFF5B5B5B), fontSize: 20),
              prefixIcon: Icon(Icons.search, color: Color(0xFF5B5B5B)),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}

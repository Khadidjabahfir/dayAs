import 'package:dayas/styles/colors.dart';
import 'package:flutter/material.dart'; 
Widget getSearchWidget() {
  return Container(
      width: 330 ,
      height: 40 ,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search",
          hintStyle: const TextStyle(fontSize: 16, color: Colors.grey),
          contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          filled: true,
          fillColor: Colors.white,
          suffixIcon: const Icon(Icons.search, color: Colors.black),
          focusColor: AppColors.darkGrey ,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10), 
            borderSide: BorderSide(color : AppColors.darkGrey , width: 1)
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10), 
            borderSide: BorderSide(color : AppColors.darkGrey , width: 1)
          ),
        ),
      ),
    );
}
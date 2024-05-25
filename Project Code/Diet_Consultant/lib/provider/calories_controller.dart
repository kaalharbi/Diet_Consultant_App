import 'package:flutter/material.dart';
import 'package:diet/Model/food.dart';

class CaloriesController extends ChangeNotifier {
  double percent = 0.0;
  int foodQuantity = 0;
  double some = 0.0;
  List<Food> foodlist = [
    Food(cla: 70, foodName: 'Egg', imagePath: 'assets/food/egg.png'),
    Food(cla: 90, foodName: 'Bread', imagePath: 'assets/food/bread.png'),
    Food(
      cla: 75,
      foodName: 'Brown Bread',
      imagePath: 'assets/food/reed_bread.png',
    ),
    Food(cla: 700, foodName: 'Kabsa', imagePath: 'assets/food/Kabsa.png'),
    Food(
        cla: 300,
        foodName: 'Beef Burger',
        imagePath: 'assets/food/Beef_burger.png'),
    Food(
        cla: 150,
        foodName: 'Chicken Breast',
        imagePath: 'assets/food/Chicken_breast.png'),
  ];

  List<Food> selectedFoodList = [];
  List<Food> backUpFoodList = [
    Food(cla: 70, foodName: 'Egg', imagePath: 'assets/food/egg.png'),
    Food(cla: 90, foodName: 'Bread', imagePath: 'assets/food/bread.png'),
    Food(
      cla: 75,
      foodName: 'Brown Bread',
      imagePath: 'assets/food/reed_bread.png',
    ),
    Food(cla: 700, foodName: 'Kabsa', imagePath: 'assets/food/Kabsa.png'),
    Food(
        cla: 300,
        foodName: 'Beef burger',
        imagePath: 'assets/food/Beef_burger.png'),
    Food(
        cla: 150,
        foodName: 'Chicken breast',
        imagePath: 'assets/food/Chicken_breast.png'),
  ];

  void onFoodSelected(Food food) {
    selectedFoodList.add(food);
    some += food.cla;
    percent = some / 2500; // Update percentage based on the total calories
    if (percent > 1) {
      percent = 1; // Ensure percentage does not exceed 1
    }
    notifyListeners();
  }

  void onFoodRemoved(Food food) {
    selectedFoodList.remove(food);

    some -= food.cla;
    if (some < 0) {
      some = 0; // Ensure 'some' does not fall below 0
    }
    percent = some / 2500;
    percent = percent / 100;

    // Update percentage based on the total calories
    notifyListeners();
  }

  bool isFoodPresent(String foodName) {
    // Iterate through the food list
    for (var food in selectedFoodList) {
      // Check if food name and image path match
      if (food.foodName == foodName) {
        // If match found, return true
        return true;
      }
    }
    // If no match found, return false
    return false;
  }
}

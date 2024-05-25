import 'package:flutter/material.dart';
import 'package:diet/provider/data.dart';

class Controller extends ChangeNotifier {
  TextEditingController age = TextEditingController();
  TextEditingController height = TextEditingController();
  TextEditingController weight = TextEditingController();
  String sex = 'Male';

  // change the sex value
  void onChanged(String newSex) {
    sex = newSex;
    notifyListeners();
  }

  double calculateBMI() {
    double newheight = double.tryParse(height.text) ?? 0.0;
    double newweight = double.tryParse(weight.text) ?? 0.0;
    int newage = int.tryParse(age.text) ?? 0;

    if (height == 0.0 || weight == 0.0 || age == 0) {
      return 0.0;
    }
    double bmi = 0.0;
    newheight = newheight / 100;
    bmi = newweight / (newheight*newheight);
    return bmi;
  }

  String? validateHeight(String? value) {
    if (value!.isEmpty) {
      return 'Please enter height';
    }
    double? height = double.tryParse(value);
    if (height == null || height <= 0) {
      return 'Invalid height';
    }
    return null;
  }

  String? validateWeight(String? value) {
    if (value!.isEmpty) {
      return 'Please enter weight';
    }
    double? weight = double.tryParse(value);
    if (weight == null || weight <= 0) {
      return 'Invalid weight';
    }
    return null;
  }

  String? validateAge(String? value) {
    if (value!.isEmpty) {
      return 'Please enter age';
    }
    int? age = int.tryParse(value);
    if (age == null || age <= 0) {
      return 'Invalid age';
    }
    return null;
  }

  Future<Map<String, dynamic>> getDietPlanForBMI(double bmi) async {
    if (bmi < 18.5) {
      return bmiDietPlans['Underweight']!;
    } else if (bmi >= 18.5 && bmi < 25) {
      return bmiDietPlans['Normal Weight']!;
    } else if (bmi >= 25 && bmi < 30) {
      return bmiDietPlans['Overweight']!;
    } else {
      return bmiDietPlans['Obesity']!;
    }
  }
}

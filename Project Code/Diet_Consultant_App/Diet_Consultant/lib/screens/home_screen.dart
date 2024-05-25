import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:diet/provider/controller.dart';
import 'package:diet/screens/claories.dart';
import 'package:diet/screens/diet.dart';
import 'package:diet/validator/form_validator.dart';
import 'package:provider/provider.dart';

class HomeScren extends StatefulWidget {
  const HomeScren({super.key});

  @override
  State<HomeScren> createState() => _HomeScrenState();
}

class _HomeScrenState extends State<HomeScren>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => Controller(),
        child: Consumer<Controller>(
          builder: (context, controller, child) => Form(
            key: key,
            child: ListView(
              physics:
                  Platform.isAndroid ? const BouncingScrollPhysics() : null,
              children: [
                SizedBox(
                  height: size.height * 0.02,
                ),
                Center(
                  child: Image.asset(
                    'assets/logo.png',
                    width: size.width / 1.5,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                const Center(
                    child: Text(
                  'Hello There !',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                )),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      'Complete all fields with accurate info to display your diet plan!',
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    validator: controller.validateAge,
                    controller: controller.age,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        floatingLabelAlignment: FloatingLabelAlignment.start,
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        label: const Text('Age *'),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        hintText: 'age'),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    validator: controller.validateHeight,
                    keyboardType: TextInputType.number,
                    controller: controller.height,
                    decoration: InputDecoration(
                        floatingLabelAlignment: FloatingLabelAlignment.start,
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        label: const Text('Height *'),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        hintText: 'height'),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    validator: controller.validateWeight,
                    keyboardType: TextInputType.number,
                    controller: controller.weight,
                    decoration: InputDecoration(
                        floatingLabelAlignment: FloatingLabelAlignment.start,
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        label: const Text('Weight *'),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        hintText: 'weight'),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Center(
                  child: Text(
                    'Selected Gender: ${controller.sex}',
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.1,
                  width: double.infinity,
                  child: GenderSelection(),
                ),
                Align(
                  alignment: Alignment.center,
                  child: MaterialButton(
                    minWidth: size.width / 1.5,
                    height: size.height * 0.06,
                    textColor: Colors.white,
                    color: Colors.green,
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () {
                      if (isValidatedForm(key)) {
                        double bmi = controller.calculateBMI();
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                              pageBuilder: (context, s, child) =>
                                  ChangeNotifierProvider.value(
                                      value: controller,
                                      child:
                                          DietRecommendationsScreen(bmi: bmi))),
                        );
                      }
                    },
                    child: const Text('Calculate'),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Align(
                  alignment: Alignment.center,
                  child: MaterialButton(
                    minWidth: size.width / 1.7,
                    height: size.height * 0.06,
                    textColor: Colors.white,
                    color: Colors.blue,
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                            pageBuilder: (context, s, child) =>
                                ChangeNotifierProvider.value(
                                    value: controller,
                                    child: const CaloriesScren())),
                      );
                    },
                    child: SizedBox(
                      width: size.width / 1.7,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Calculate Calories'),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(Icons.calculate)
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GenderSelection extends StatelessWidget {
  GenderSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Controller>(
      builder: (context, Controller controller, child) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Radio(
            value: 'Male',
            groupValue: controller.sex,
            onChanged: (value) {
              controller.onChanged(value!);
            },
          ),
          const Text('Male'),
          const SizedBox(
            width: 40,
          ),
          Radio(
            value: 'Female',
            groupValue: controller.sex,
            onChanged: (value) {
              controller.onChanged(value!);
            },
          ),
          const Text('Female'),
        ],
      ),
    );
  }
}

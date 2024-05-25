import 'dart:io';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:diet/Model/food.dart';
import 'package:diet/provider/calories_controller.dart';
import 'package:diet/widget/counter.dart';
import 'package:provider/provider.dart';

class CaloriesScren extends StatefulWidget {
  const CaloriesScren({super.key});

  @override
  State<CaloriesScren> createState() => _CaloriesScrenState();
}

class _CaloriesScrenState extends State<CaloriesScren>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

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
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        title: const Text('Calculate Calorie'),
        centerTitle: true,
      ),
      body: ChangeNotifierProvider(
        create: (context) => CaloriesController(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: size.height * 0.45,
                child: Consumer<CaloriesController>(
                  builder: (context, value, child) => Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: Card(
                      elevation: 10,
                      child: ListView.builder(
                          physics: Platform.isAndroid
                              ? const BouncingScrollPhysics()
                              : null,
                          itemCount: value.foodlist.length,
                          itemBuilder: (context, i) {
                            Food food = value.foodlist[i];
                            return ListTile(
                              title: Text(
                                food.foodName,
                                overflow: TextOverflow.ellipsis,
                              ),
                              leading: Image.asset(
                                food.imagePath,
                                height: size.height * 0.04,
                              ),
                              trailing: value.isFoodPresent(food.foodName)
                                  ? MaterialButton(
                                      textColor: Colors.white,
                                      minWidth: 60,
                                      color: Colors.red,
                                      onPressed: () {
                                        value.onFoodRemoved(food);
                                        food.cla = value.backUpFoodList[i].cla;
                                      },
                                      child: const Text('Remove'))
                                  : Wrap(
                                      runAlignment: WrapAlignment.start,
                                      alignment: WrapAlignment.center,
                                      children: [
                                        MaterialButton(
                                          minWidth: 60,
                                          onPressed: null,
                                          child: CounterWidget(
                                            onDecrement: (qty) {
                                              food.cla =
                                                  value.backUpFoodList[i].cla;
                                              food.cla = food.cla * qty;

                                              // log(food.cla.toString());
                                            },
                                            onIncrement: (qty) {
                                              food.cla =
                                                  value.backUpFoodList[i].cla;
                                              food.cla = food.cla * qty;
                                            },
                                            initialValue: 1,
                                          ),
                                        ),
                                        MaterialButton(
                                            textColor: Colors.white,
                                            color: Colors.green,
                                            minWidth: 60,
                                            onPressed: () {
                                              value.onFoodSelected(food);
                                            },
                                            child: const Text('Add')),
                                      ],
                                    ),
                            );
                          }),
                    ),
                  ),
                )),
            const Padding(
              padding: EdgeInsets.only(left: 20, top: 20),
              child: Text(
                'Selected Food :',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Consumer<CaloriesController>(
              builder: (context, value, child) => Center(
                child: CircularPercentIndicator(
                  radius: 100.0,
                  lineWidth: 10.0,
                  percent: value.percent,
                  center: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.calculate,
                        size: 50.0,
                        color: Colors.black,
                      ),
                      Text('${value.some} kcal')
                    ],
                  ),
                  backgroundColor: Colors.grey,
                  progressColor: Colors.green,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Center(child: const Text('Daily Calories is 2500 Kcal'))
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:diet/provider/controller.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class DietRecommendationsScreen extends StatefulWidget {
  final double bmi;

  const DietRecommendationsScreen({required this.bmi});

  @override
  State<DietRecommendationsScreen> createState() =>
      _DietRecommendationsScreenState();
}

class _DietRecommendationsScreenState extends State<DietRecommendationsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  String bmiResult = '';

  @override
  void initState() {
    init();
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  init() {
    if (widget.bmi < 18.5) {
      setState(() {
        bmiResult = 'Underweight';
      });
    } else if (widget.bmi > 18.5 && widget.bmi < 24.9) {
      setState(() {
        bmiResult = 'Normal Weight';
      });
    } else if (widget.bmi > 25 && widget.bmi < 29.9) {
      setState(() {
        bmiResult = 'Overweight';
      });
    } else {
      setState(() {
        bmiResult = 'Obesity';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Controller controller = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        title: Text(bmiResult),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: controller.getDietPlanForBMI(widget.bmi),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return CategoryBmi(data: snapshot.data!);
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class CategoryBmi extends StatelessWidget {
  Map<String, dynamic> data;
  CategoryBmi({super.key, required this.data});
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return ListView(
      children: [
        SizedBox(
            height: size.height * 0.1,
            child: Card(
              color: Colors.lightBlueAccent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Goal',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Center(
                      child: Text(
                    data['goal'],
                    textAlign: TextAlign.center,
                  )),
                ],
              ),
            )),
        SizedBox(
            height: size.height * 0.1,
            child: Card(
              color: const Color.fromARGB(255, 255, 216, 229),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Meal Frequency',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Center(
                      child: Text(
                    data['mealFrequency'],
                    textAlign: TextAlign.center,
                  )),
                ],
              ),
            )),
        SizedBox(
            height: size.height * 0.1,
            child: Card(
              color: Colors.deepOrangeAccent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Nutrient Rich Foods',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Center(
                      child: Text(
                    data['nutrientRichFoods'],
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white),
                  )),
                ],
              ),
            )),
        SizedBox(
            height: size.height * 0.1,
            child: Card(
              color: Colors.teal,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Portion Sizes',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Center(
                      child: Text(
                    data['portionSizes'],
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white),
                  )),
                ],
              ),
            )),
        SizedBox(
            height: size.height * 0.1,
            child: Card(
              color: Colors.indigo,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Hydration',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Center(
                      child: Text(
                    data['hydration'],
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white),
                  )),
                ],
              ),
            )),
        const SizedBox(
          height: 10,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 10),
          child: const Text(
            'Meal Plan :',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Breakfast',
            ),
            const SizedBox(
              width: 20,
            ),
            Image.asset(
              'assets/breakfast.png',
              height: size.height * 0.04,
            ),
          ],
        ),
        Wrap(
            children: List.generate(
                data['exampleMealPlan']['Breakfast'].length,
                (i) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: size.height * 0.07,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  data['exampleMealPlan']['Breakfast'][i],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ))),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Mid-Morning Snack',
            ),
            const SizedBox(
              width: 20,
            ),
            Image.asset(
              'assets/cereal.png',
              height: size.height * 0.04,
            ),
          ],
        ),
        Wrap(
            children: List.generate(
                data['exampleMealPlan']['Mid-Morning Snack'].length,
                (i) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: size.height * 0.07,
                        decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                data['exampleMealPlan']['Mid-Morning Snack'][i],
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ))),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Lunch',
            ),
            const SizedBox(
              width: 20,
            ),
            Image.asset(
              'assets/lunch-bag.png',
              height: size.height * 0.04,
            ),
          ],
        ),
        Wrap(
            children: List.generate(
                data['exampleMealPlan']['Lunch'].length,
                (i) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: size.height * 0.07,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(20)),
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    data['exampleMealPlan']['Lunch'][i],
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ))),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Afternoon Snack',
            ),
            const SizedBox(
              width: 20,
            ),
            Image.asset(
              'assets/salad.png',
              height: size.height * 0.04,
            ),
          ],
        ),
        Wrap(
            children: List.generate(
                data['exampleMealPlan']['Afternoon Snack'].length,
                (i) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: size.height * 0.07,
                        decoration: BoxDecoration(
                            color: Colors.purpleAccent,
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                data['exampleMealPlan']['Afternoon Snack'][i],
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ))),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Dinner',
            ),
            const SizedBox(
              width: 20,
            ),
            Image.asset(
              'assets/food.png',
              height: size.height * 0.04,
            ),
          ],
        ),
        Wrap(
            children: List.generate(
                data['exampleMealPlan']['Dinner'].length,
                (i) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: size.height * 0.07,
                        decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  data['exampleMealPlan']['Dinner'][i],
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ))),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            children: [
              const Text(
                'Advice :',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 20,
              ),
              Image.asset(
                'assets/idea.png',
                height: size.height * 0.04,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Text(
            data['advice'],
            textAlign: TextAlign.justify,
          ),
        )
      ],
    );
  }
}

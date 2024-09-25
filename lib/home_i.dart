
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';





class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

TextEditingController ageController = TextEditingController();
TextEditingController ftController = TextEditingController();
TextEditingController inchController = TextEditingController();
TextEditingController weightController = TextEditingController();
double? bmi = 0.0;

class _HomeState extends State<Home> {
  bool isMaleSelected = false; // Track male button state
  bool isFemaleSelected = false; // Track female button state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.black45,
        title: const Text(
          'BMI Calculator',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 21,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                // Clear text controllers and reset BMI to 0
                ageController.clear();
                ftController.clear();
                inchController.clear();
                weightController.clear();
                bmi = 0.0;  // Reset BMI to default
              });
            },
            icon: const Icon(Icons.refresh, color: Colors.black54,),
          ),

          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert, color: Colors.black54),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        'Your age',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        width: 50,
                        child: TextField(
                          controller: ageController,
                          decoration: const InputDecoration(
                            labelText: 'Age',
                          ),
                        ),
                      ),
                      const Text(
                        'Your height',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        width: 50,
                        child: TextField(
                          controller: ftController,
                          decoration: const InputDecoration(
                            labelText: 'Ht(ft)',
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 50,
                        child: TextField(
                          controller: inchController,
                          decoration: const InputDecoration(
                            labelText: 'Ht(in)',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          const Text(
                            'Gender',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          Row(
                            children: [
                              const Text(
                                'Male',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(width: 19),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    isMaleSelected = !isMaleSelected;
                                    isFemaleSelected = false; // Deselect female if male is selected
                                  });
                                },
                                icon: const Icon(Icons.male),
                                color: isMaleSelected ? Colors.blue : Colors.grey,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Text(
                                'Female',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    isFemaleSelected = !isFemaleSelected;
                                    isMaleSelected = false; // Deselect male if female is selected
                                  });
                                },
                                icon: const Icon(Icons.female),
                                color: isFemaleSelected ? Colors.blue : Colors.grey,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(width: 5),
                      const Text(
                        'Weight',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        width: 48,
                        child: TextField(
                          controller: weightController,
                          decoration: const InputDecoration(
                            labelText: '(Kg)',
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 38,
                        child: IconButton(
                          onPressed: () {
                            double? ft = double.tryParse(ftController.text) ?? 0;
                            double? inch = double.tryParse(inchController.text) ?? 0;
                            double? meter = (ft * 12 + inch) * 0.0254;

                            double? weight = double.tryParse(weightController.text) ?? 0;
                            bmi = weight / (meter * meter);

                            setState(() {});
                          },
                          icon: const Icon(Icons.done_outline_sharp),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 200,
              child: SfRadialGauge(axes: <RadialAxis>[
                RadialAxis(
                  minimum: 0,
                  maximum: 50,
                  ranges: <GaugeRange>[
                    GaugeRange(startValue: 0, endValue: 15.9, color: Colors.yellow),
                    GaugeRange(startValue: 16, endValue: 16.9, color: Colors.yellow.shade300),
                    GaugeRange(startValue: 17, endValue: 18.4, color: Colors.yellow.shade200),
                    GaugeRange(startValue: 18.5, endValue: 24.9, color: Colors.green),
                    GaugeRange(startValue: 25, endValue: 29.9, color: Colors.red.shade200),
                    GaugeRange(startValue: 30, endValue: 34.9, color: Colors.red.shade300),
                    GaugeRange(startValue: 35, endValue: 39.9, color: Colors.red),
                    GaugeRange(startValue: 40, endValue: 150, color: Colors.red),
                  ],
                  pointers: <GaugePointer>[
                    NeedlePointer(
                      value: bmi!.toDouble(),
                      enableAnimation: true,
                      animationType: AnimationType.ease,
                      animationDuration: 1000,
                    ),
                  ],
                  annotations: <GaugeAnnotation>[
                    GaugeAnnotation(
                      widget: Text(
                        bmi!.toStringAsFixed(1).toString(),
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      angle: 90,
                      positionFactor: 0.5,

                        ),
                      ],
                    )]),
            ),

      const SizedBox(height: 25,),
       Column(
        children: [
          Padding(
            padding:  const EdgeInsets.fromLTRB(40, 5, 40, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Very Severely underweight', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16,
              color: ( bmi?.toDouble() ?? 0) > 1.0  &&
                  ( bmi?.toDouble() ?? 0) < 15.9 ? Colors.yellow.shade300 : Colors.black,)),
                    const Spacer(),
                    Text('<- 15.9',style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: ( bmi?.toDouble() ?? 0) > 1.0  &&
                          ( bmi?.toDouble() ?? 0) < 15.9 ? Colors.yellow.shade300 : Colors.black,)),

                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding:  const EdgeInsets.fromLTRB(40, 5, 40, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Severely Underweight', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16,
                      color: ( bmi?.toDouble() ?? 0) > 16.0  &&
                          ( bmi?.toDouble() ?? 0) < 16.9 ? Colors.yellow.shade300 : Colors.black,
                    ),),
                    const Spacer(),
                    Text('16.0 - 16.9',style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: ( bmi?.toDouble() ?? 0) > 16.0  &&
                          ( bmi?.toDouble() ?? 0) < 16.9 ? Colors.yellow.shade300 : Colors.black,

                    ),),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding:  const EdgeInsets.fromLTRB(40, 5, 40, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Underweight', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16,
                      color: ( bmi?.toDouble() ?? 0) > 17.0  &&
                          ( bmi?.toDouble() ?? 0) < 18.4 ? Colors.yellow.shade200 : Colors.black,
                    ),),
                    const Spacer(),
                    Text('17.0 - 18.4',style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16,
                      color: ( bmi?.toDouble() ?? 0) > 17.0  &&
                          ( bmi?.toDouble() ?? 0) < 18.4 ? Colors.yellow.shade200 : Colors.black,
                    ),),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding:  const EdgeInsets.fromLTRB(40, 5, 40, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Normal', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16,
                      color: ( bmi?.toDouble() ?? 0) > 18.5  &&
                          ( bmi?.toDouble() ?? 0) < 24.9 ? Colors.green : Colors.black,),),
                    const Spacer(),
                    Text('18.5 - 24.9',style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16,
                      color: ( bmi?.toDouble() ?? 0) > 18.5  &&
                          ( bmi?.toDouble() ?? 0) < 24.9 ? Colors.green : Colors.black,),),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding:  const EdgeInsets.fromLTRB(40, 5, 40, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Overweight', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16,
                      color: ( bmi?.toDouble() ?? 0) > 25.0  &&
                          ( bmi?.toDouble() ?? 0) < 29.9 ? Colors.red.shade200 : Colors.black,
                    ),),
                    const Spacer(),
                    Text('<25.0 - 29.9',style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16,
                      color: ( bmi?.toDouble() ?? 0) > 25.0  &&
                          ( bmi?.toDouble() ?? 0) < 29.9 ? Colors.red.shade200 : Colors.black,
                    ),),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding:  const EdgeInsets.fromLTRB(40, 5, 40, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Obese class i', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16,
                      color: ( bmi?.toDouble() ?? 0) > 30.0  &&
                          ( bmi?.toDouble() ?? 0) < 34.9 ? Colors.red.shade300 : Colors.black,
                    ),),
                    const Spacer(),
                    Text('30.0 - 34.9',style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16,
                      color: ( bmi?.toDouble() ?? 0) > 30.0  &&
                          ( bmi?.toDouble() ?? 0) < 34.9 ? Colors.red.shade300 : Colors.black,
                    ),),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding:  const EdgeInsets.fromLTRB(40, 5, 40, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Obese class ii', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16,
                      color: ( bmi?.toDouble() ?? 0) > 35.0  &&
                          ( bmi?.toDouble() ?? 0) < 39.9 ? Colors.red : Colors.black,
                    ),),
                    const Spacer(),
                    Text('35.0 - 39.9',style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16,
                      color: ( bmi?.toDouble() ?? 0) > 35.0  &&
                          ( bmi?.toDouble() ?? 0) < 39.9 ? Colors.red : Colors.black,
                    ),),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 5, 40, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Obese class iii',
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16,
                        color: ( bmi?.toDouble() ?? 0) > 45.0 ? Colors.red : Colors.black,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '>= 45.0',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: ( bmi?.toDouble() ?? 0) > 45.0 ? Colors.red : Colors.black,
                      ),
                    ),

                  ],
                ),
              ],
            ),
          ),


        ],
      ),
      ],
    ),
    ),
    );
  }
  @override
  void dispose() {
    super.dispose();

    ftController.clear();
    weightController.clear();
    inchController.clear();
    ageController.clear();
  }
}












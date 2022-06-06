import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:im_stepper/stepper.dart';
import '../model/state_management.dart';
import 'package:provider/provider.dart';

class Booking extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ref) {
    var step = ref.watch(currentStep);
    var mallWatch = ref.watch(selectedMall);

    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFF7C99AC),
      body: Column(
        children: [
          NumberStepper(
            activeStep: step - 1,
            direction: Axis.horizontal,
            enableNextPreviousButtons: false,
            enableStepTapping: false,
            numbers: const[1, 2, 3, 4],
            stepColor: Colors.black,
            activeStepColor: Colors.grey,
            numberStyle: TextStyle(color: Colors.white),
          ),
          Expanded(
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: ElevatedButton(
                        onPressed:
                            step == 1 ? null : () => context.read().state--,
                        child: Text('Previous'),
                      )),
                      SizedBox(
                        width: 30,
                      ),
                      Expanded(
                        child: ElevatedButton(
                            onPressed:
                                step == 1 ? null : () => context.read().state++,
                            child: Text('Next')),
                      ),
                    ],
                  ),
                )),
          )
        ],
      ),
    ));
  }
}

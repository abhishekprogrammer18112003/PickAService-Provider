import 'package:pick_a_service/core/utils/screen_utils.dart';

import '../../core/app_imports.dart';

enum _StepState {
  inactive,
  completed,
  current,
}

class CustomStepper extends StatelessWidget {
  const CustomStepper({
    super.key,
    required this.width,
    required this.totalSteps,
    required this.currentStep,
    required this.completedStepColor,
    required this.currentStepColor,
    required this.inactiveStepColor,
    required this.completedStepIcon,
    required this.currentStepIcon,
    required this.inactiveStepIcon,
  }) : assert(currentStep >= 0 && currentStep < totalSteps);

  final double width;
  final int totalSteps;
  final int currentStep;
  final Color completedStepColor;
  final Color currentStepColor;
  final Color inactiveStepColor;
  final IconData completedStepIcon;
  final IconData currentStepIcon;
  final IconData inactiveStepIcon;

  _StepState getStepState(int index) {
    if (index < currentStep) {
      return _StepState.completed;
    }
    if (index == currentStep) {
      return _StepState.current;
    }
    return _StepState.inactive;
  }

  Color getStepColor(_StepState stepState) {
    switch (stepState) {
      case _StepState.inactive:
        return inactiveStepColor;
      case _StepState.completed:
        return completedStepColor;
      case _StepState.current:
        return currentStepColor;
    }
  }

  Color getLineColor(_StepState stepState) {
    switch (stepState) {
      case _StepState.inactive:
        return inactiveStepColor;
      case _StepState.completed:
        return completedStepColor;
      case _StepState.current:
        return currentStepColor;
    }
  }

  IconData getStepIcon(_StepState stepState) {
    switch (stepState) {
      case _StepState.inactive:
        return inactiveStepIcon;
      case _StepState.completed:
        return completedStepIcon;
      case _StepState.current:
        return currentStepIcon;
    }
  }

  @override
  Widget build(BuildContext context) {
    final steps = <Widget>[];

    for (var i = 0; i < totalSteps; i++) {
      steps.add(buildStep(i));
      if (i < totalSteps - 1) {
        steps.add(buildLine(i));
      }
    }

    return SizedBox(
      width: width,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: steps,
      ),
    );
  }

  Widget buildStep(int index) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 12.r,
          backgroundColor: getStepColor(getStepState(index)),
          child: Icon(
            getStepIcon(getStepState(index)),
            color: AppColors.white,
            size: 18.r,
          ),
        ),
        CustomSpacers.height6,
        Text(
          'Step ${index + 1}',
          style: AppTextStyles.textStyle12w400Secondary,
        ),
      ],
    );
  }

  Widget buildLine(int index) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Divider(
                  height: 2.h,
                  thickness: 2.h,
                  color: getLineColor(getStepState(index)),
                ),
              ),
              Expanded(
                child: Divider(
                  height: 2.h,
                  thickness: 2.h,
                  color: getLineColor(getStepState(index + 1)),
                ),
              ),
            ],
          ),
          CustomSpacers.height20
        ],
      ),
    );
  }
}

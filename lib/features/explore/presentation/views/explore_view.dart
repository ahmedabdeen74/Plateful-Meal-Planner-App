import 'package:flutter/material.dart';
import 'package:meal_planner/constants.dart';
import 'package:meal_planner/features/explore/presentation/views/widgets/explore_view_body.dart';

class ExploreView extends StatelessWidget {
  const ExploreView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        hideKeyboardFromScreen(context);
      },
      child: SafeArea(child: ExploreViewBody()),
    );
  }
}

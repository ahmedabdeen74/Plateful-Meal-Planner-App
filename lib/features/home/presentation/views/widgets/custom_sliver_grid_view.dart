import 'package:flutter/material.dart';
import 'package:meal_planner/core/utility/styles.dart';
import 'package:meal_planner/features/home/data/models/meal_model/meal.dart';
import 'package:meal_planner/features/home/presentation/views/widgets/meal_card.dart';

class CustomSliverGridView extends StatelessWidget {
  const CustomSliverGridView({
    super.key,
    required this.meal,
    required this.itemCount,
  });
  final List<Meal> meal;
  final int? itemCount;
  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      itemCount: itemCount,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (context, index) {
        return MealCard(
          meal: meal[index],
          style1: Styles.textStyleMedium14,
          style2: Styles.textStyleregular12.copyWith(color: Color(0xff878787)),
          height: 120,
          right: 6,
          bottom: 4,
        );
      },
    );
  }
}

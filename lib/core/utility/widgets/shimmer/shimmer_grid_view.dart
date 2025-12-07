import 'package:flutter/material.dart';
import 'package:meal_planner/core/utility/widgets/shimmer/shimmer_meal_card.dart';

class ShimmerGridView extends StatelessWidget {
  const ShimmerGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      itemCount: 4,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (context, index) {
        return ShimmerMealCard(height: MediaQuery.sizeOf(context).height * .17);
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:meal_planner/features/explore/presentation/views/widgets/explore_view_details_body.dart';

class ExploreViewDetails extends StatelessWidget {
  const ExploreViewDetails({super.key, required this.isCategory, required this.name});
  final bool isCategory;
   final String name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Builder(
          builder: (context) => ExploreViewDetailsBody(isCategory: isCategory,name: name,),
        ),
      ),
    );
  }
}

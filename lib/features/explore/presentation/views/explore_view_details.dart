import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_planner/core/utility/di/service_locator.dart';
import 'package:meal_planner/features/explore/data/repo/explore_repo_impl.dart';
import 'package:meal_planner/features/explore/presentation/cubits/filter_cubits/fetch_filter_area_cubit.dart';
import 'package:meal_planner/features/explore/presentation/cubits/filter_cubits/fetch_filter_category_cubit.dart';
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

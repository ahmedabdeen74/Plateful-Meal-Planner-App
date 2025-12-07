import 'package:flutter/material.dart';
import 'package:meal_planner/core/utility/widgets/shimmer/shimmer_custom_search_result_item.dart';
import 'package:meal_planner/core/utility/widgets/shimmer/shimmer_search_result_item.dart';
import 'package:meal_planner/features/search/presentation/views/widgets/custom_text_field.dart';
import 'package:meal_planner/features/search/presentation/views/widgets/search_view_app_bar.dart';

class SearchMealLoading extends StatelessWidget {
  const SearchMealLoading({super.key});
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffEEEFF3),
        borderRadius: BorderRadius.circular(16),
      ),
      //  height: 300,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: List.generate(
                3,
                (_) => const ShimmerSearchResultItem(),
              ),
            ),
            SizedBox(height: 16),
            Divider(color: Color(0xffC5C6D0), thickness: 1, height: 1),
            Column(
              children: List.generate(
                5,
                (_) => const ShimmerCustomSearchResultItem(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*
SingleChildScrollView(
      child: Column(
        children: [
          SearchViewAppBar(),
          SizedBox(height: 32),
          CustomTextField(
            controller: controller,
            suffixIcon: GestureDetector(
              onTap: onTapRemove,
              child: Icon(Icons.close),
            ),
            prefixIcon: GestureDetector(
              onTap: onTapBack,
              child: Icon(Icons.arrow_back),
            ),
          ),
          Divider(color: Color(0xff757780), thickness: 1.5, height: 1),
          */

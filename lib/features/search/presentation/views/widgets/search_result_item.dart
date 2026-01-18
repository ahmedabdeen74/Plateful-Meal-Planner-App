import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_planner/core/utility/routers/app_router.dart';
import 'package:meal_planner/core/utility/styles.dart';
import 'package:meal_planner/features/home/data/models/meal_model/meal.dart';
import 'package:meal_planner/features/home/presentation/cubits/fetch_meal_details_cubit/fetch_meal_details_cubit.dart';

class SearchResultItem extends StatelessWidget {
  const SearchResultItem({super.key, required this.meal});
  final Meal meal;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<FetchMealDetailsCubit>(
          context,
        ).fetchMealDetails(id: meal.idMeal!);
        GoRouter.of(
          context,
        ).push(AppRouter.kSearchResultView, extra: meal.strMeal);
      },
      child: Text(
        meal.strMeal ?? "No Meal Name",
        style: Styles.textStyleMedium18.copyWith(color: Color(0xff1A1B21)),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_planner/core/utility/app_router.dart';
import 'package:meal_planner/core/utility/assets_generator.dart';
import 'package:meal_planner/features/home/data/models/meal_model/meal.dart';
import 'package:meal_planner/features/home/presentation/cubits/fetch_meal_details_cubit/fetch_meal_details_cubit.dart';

class CustomSearchResultItem extends StatelessWidget {
  const CustomSearchResultItem({super.key, required this.meal});
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
      child: ListTile(
        title: Text(
          meal.strMeal ?? "No Meal Name",
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
        subtitle: Text(
          meal.strArea ?? "Unknown Area",
          style: TextStyle(fontSize: 14, color: Color(0xff44464F)),
        ),
        leading: CircleAvatar(
          backgroundImage: meal.strMealThumb != null
              ? NetworkImage(meal.strMealThumb!)
              : AssetImage(Assets.imagesHome1) as ImageProvider,
          radius: 24,
        ),
      ),
    );
  }
}

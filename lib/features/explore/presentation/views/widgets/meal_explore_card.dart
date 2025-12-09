import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_planner/core/utility/styles.dart';
import 'package:meal_planner/core/utility/widgets/mealdetailsbottomsheet.dart';
import 'package:meal_planner/features/home/data/models/meal_model/meal.dart';
import 'package:meal_planner/features/home/presentation/cubits/fetch_meal_details_cubit/fetch_meal_details_cubit.dart';

class MealExploreCard extends StatelessWidget {
  const MealExploreCard({super.key, required this.meal, this.iconButton});
  final Meal meal;
  final Widget? iconButton;
  @override
  Widget build(BuildContext context) {
    final double cardWidth = MediaQuery.of(context).size.width * 0.9;
    final double cardHeight = MediaQuery.of(context).size.height * 0.46;
    return GestureDetector(
      onTap: () {
        BlocProvider.of<FetchMealDetailsCubit>(
          context,
        ).fetchMealDetails(id: meal.idMeal!);
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => const MealDetailsBottomSheet(),
        );
      },
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              meal.strMealThumb ?? "",
              fit: BoxFit.cover,
              width: cardWidth,
              height: cardHeight,
            ),
            /* Image.network(
                         widget.meals[index].strMealThumb ?? AssetsData.home1,
                          fit: BoxFit.cover,
                          width: cardWidth,
                          height: cardHeight,
                        ),*/
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xff7C7C7C).withOpacity(0.5),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        meal.strMeal ?? "",
                        style: Styles.textStyleSemibold13.copyWith(),
                      ),
                      Expanded(flex: 3, child: const SizedBox()),
                      //  icon,
                      iconButton ?? SizedBox(),
                      /*IconButton(
                        onPressed: () {
                          //  print("Clicked on ${meal.strMeal}");
                          //  print("Clicked on ${meal.idMeal}");
                          //  print("Clicked on ${meal.strMealThumb}");
                          //  print("Clicked on ${meal.strMealThumb}");
                          //  print("Clicked on ${meal.idMeal}");
                          //  print("Clicked on ${meal.strMeal}");
                          //  print("Clicked on ${meal.strMealThumb}");
                          //  print("Clicked on ${meal.strMealThumb}");
                        }, //  print("Clicked on ${meal.idMeal
                        icon: Icon(Icons.favorite, color: Colors.red),
                      ),*/
                    ],
                  ),
                  //  const SizedBox(height: 4),
                  /* Text(
                    meal.strArea??"",
                    style: Styles.textStyleLight12.copyWith(color: Colors.white),
                  ),*/
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

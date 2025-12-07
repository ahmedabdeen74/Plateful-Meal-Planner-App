import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_planner/config/app_helper/app_padding.dart';
import 'package:meal_planner/core/utility/styles.dart';
import 'package:meal_planner/core/utility/widgets/mealdetailsbottomsheet.dart';
import 'package:meal_planner/features/home/data/models/meal_model/meal.dart';
import 'package:meal_planner/features/home/presentation/view_models/fetch_meal_details_cubit/fetch_meal_details_cubit.dart';

class MealCard extends StatelessWidget {
  const MealCard({
    super.key,
    required this.height,
    this.bottom = AppPadding.tinySmallPadding,
    this.right = 14,
    this.style1 = Styles.textStyleMedium18,
    required this.style2,
    required this.meal,
    this.showIngredientsCountInsteadOfArea = false,
  });

  final double height;
  final double? bottom;
  final double? right;
  final TextStyle? style1;
  final TextStyle style2;
  final Meal meal;
  final bool showIngredientsCountInsteadOfArea;

  @override
  Widget build(BuildContext context) {
    const String defaultImageUrl = 'https://via.placeholder.com/150';

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              if (meal.idMeal != null && meal.idMeal!.isNotEmpty) {
                BlocProvider.of<FetchMealDetailsCubit>(
                  context,
                ).fetchMealDetails(id: meal.idMeal!);
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => const MealDetailsBottomSheet(),
                );
              }
            },
            child: Stack(
              children: [
                Container(
                  height: height,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(10, 10),
                        color: Colors.grey.withOpacity(0.4),
                        blurRadius: 40,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: CachedNetworkImage(
                      imageUrl: meal.strMealThumb?.isNotEmpty == true
                          ? meal.strMealThumb!
                          : defaultImageUrl,
                      fit: BoxFit.cover,
                      /*placeholder: (context, url) =>
                          Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          Image.network(defaultImageUrl, fit: BoxFit.cover),*/
                    ),
                  ),
                ),
                Positioned(
                  bottom: bottom,
                  right: right,
                  child: IntrinsicWidth(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppPadding.soSmallPadding,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text(
                          meal.strCategory?.isNotEmpty == true
                              ? meal.strCategory!
                              : "Unknown Category",
                          textAlign: TextAlign.center,
                          style: Styles.textStyleregular12,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: AppPadding.smallPadding),
          Padding(
            padding: const EdgeInsets.only(left: AppPadding.tinySmallPadding),
            child: Text(
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              meal.strMeal?.isNotEmpty == true ? meal.strMeal! : "Unknown Meal",
              style: style1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: AppPadding.tinySmallPadding),
            child: Text(
              showIngredientsCountInsteadOfArea
                  ? "${meal.getIngredients().length} Ingredients"
                  : (meal.strArea?.isNotEmpty == true
                        ? meal.strArea!
                        : "Unknown Area"),
              style: style2,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_planner/core/utility/assets.dart';
import 'package:meal_planner/core/utility/styles.dart';
import 'package:meal_planner/core/utility/widgets/mealdetailsbottomsheet.dart';
import 'package:meal_planner/features/home/data/models/meal_model/meal.dart';
import 'package:meal_planner/features/home/presentation/cubits/fetch_meal_details_cubit/fetch_meal_details_cubit.dart';

class CustomCardSwiper extends StatefulWidget {
  const CustomCardSwiper({super.key, required this.meals, this.itemCount});
  final List<Meal> meals;
  final int? itemCount;

  @override
  State<CustomCardSwiper> createState() => _CardSwiperExampleState();
}

class _CardSwiperExampleState extends State<CustomCardSwiper> {
  int currentIndex = 0;

 
  Widget getImageWidget(String? imagePath, double width, double height) {
    const String defaultImageUrl = 'https://via.placeholder.com/150';
    const String defaultAssetImage = AssetsData.home1;

    if (imagePath == null || imagePath.isEmpty) {
      return Image.asset(
        defaultAssetImage,
        width: width,
        height: height,
        fit: BoxFit.cover,
      );
    }
    if (imagePath.startsWith('http')) {
      return CachedNetworkImage(
        imageUrl: imagePath,
        width: width,
        height: height,
        fit: BoxFit.cover,
        placeholder: (context, url) =>
            Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => Image.asset(
          defaultAssetImage,
          width: width,
          height: height,
          fit: BoxFit.cover,
        ),
      );
    } else if (imagePath.startsWith('assets/')) {
      return Image.asset(
        imagePath,
        width: width,
        height: height,
        fit: BoxFit.cover,
      );
    } else {
      return Image.asset(
        defaultAssetImage,
        width: width,
        height: height,
        fit: BoxFit.cover,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double cardWidth = MediaQuery.of(context).size.width * 0.8;
    final double cardHeight = MediaQuery.of(context).size.height * 0.48;

    return Center(
      child: GestureDetector(
        onTap: () {
          if (widget.meals[currentIndex].idMeal?.isNotEmpty == true) {
            BlocProvider.of<FetchMealDetailsCubit>(
              context,
            ).fetchMealDetails(id: widget.meals[currentIndex].idMeal!);
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) => const MealDetailsBottomSheet(),
            );
          }
        },
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Swiper(
              itemCount: widget.meals.length,
              layout: SwiperLayout.STACK,
              itemWidth: cardWidth,
              itemHeight: cardHeight,
              onIndexChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: getImageWidget(
                        widget.meals[index].strMealThumb,
                        cardWidth,
                        cardHeight,
                      ),
                    ),
                    if (index == currentIndex)
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
                              Text(
                                widget.meals[index].strMeal?.isNotEmpty == true
                                    ? widget.meals[index].strMeal!
                                    : "Unknown Meal",
                                style: Styles.textStyleSemibold13,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                widget.meals[index].strArea?.isNotEmpty == true
                                    ? widget.meals[index].strArea!
                                    : "Unknown Area",
                                style: Styles.textStyleLight12.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

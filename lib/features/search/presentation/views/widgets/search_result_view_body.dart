import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_planner/core/utility/assets.dart';
import 'package:meal_planner/core/utility/helper/function.dart';
import 'package:meal_planner/core/utility/styles.dart' show Styles;
import 'package:meal_planner/core/utility/widgets/shimmer/shimmer_card_swiper.dart';
import 'package:meal_planner/core/utility/widgets/shimmer/shimmer_grid_view.dart';
import 'package:meal_planner/core/utility/widgets/shimmer/shimmer_meal_card.dart';
import 'package:meal_planner/features/home/presentation/view_models/fetch_meal_details_cubit/fetch_meal_details_cubit.dart';
import 'package:meal_planner/features/home/presentation/view_models/fetch_meals_cubit/fetch_meals_cubit.dart';
import 'package:meal_planner/features/home/presentation/views/widgets/custom_card_swiper.dart';
import 'package:meal_planner/features/home/presentation/views/widgets/custom_sliver_grid_view.dart';
import 'package:meal_planner/features/home/presentation/views/widgets/meal_card.dart';
import 'package:meal_planner/features/search/presentation/view_models/cubit/search_meals_cubit.dart';
import 'package:meal_planner/features/search/presentation/views/widgets/custom_text_field.dart';
import 'package:meal_planner/features/search/presentation/views/widgets/search_view_app_bar.dart';

class SearchResultViewBody extends StatefulWidget {
  const SearchResultViewBody({super.key, required this.mealName});
  final String mealName;
  @override
  State<SearchResultViewBody> createState() => _SearchResultViewBodyState();
}

class _SearchResultViewBodyState extends State<SearchResultViewBody> {
  final TextEditingController controller = TextEditingController();
  bool isSearch = false;
  bool isIconClose = true;
  @override
  void initState() {
    super.initState();
    controller.text = widget.mealName;
    saveMealToHistory(widget.mealName.trim());

    // نحدد هل هيبحث ولا لأ بناءً على القيمة المبدئية
    // isSearch = widget.mealName.trim().isNotEmpty;
    //isIconClose = isSearch;

    // if (isSearch) {
    //context.read<SearchMealsCubit>().fetchMealsByName(
    //   mealName: widget.mealName,
    //);

    BlocProvider.of<FetchMealsCubit>(context).fetchMeals(count: 8);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
          sliver: SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Image.asset(AssetsData.backButton),
                ),
                SizedBox(height: 16),
                SearchViewAppBar(),
                SizedBox(height: 16),
                CustomTextField(
                  onChanged: (value) {
                    setState(() {
                      isSearch = value.trim().isNotEmpty;
                      isIconClose = value.trim().isNotEmpty;
                    });

                    if (value.trim().isEmpty) {
                      context.read<SearchMealsCubit>().reset();
                    } else {
                      context.read<SearchMealsCubit>().fetchMealsByName(
                        mealName: value,
                      );
                    }
                  },
                  controller: controller,
                  suffixIcon: isIconClose
                      ? GestureDetector(
                          onTap: () {
                            final previousText = controller.text
                                .trim(); // Store text before clear
                            controller.clear(); // clear

                            setState(() {
                              isIconClose = false;

                              // use text before clear
                              if (previousText == widget.mealName.trim()) {
                                isSearch = false;
                              } else {
                                isSearch = true; // clear now
                              }
                            });
                          },
                          child: Icon(Icons.close),
                        )
                      : null,
                ),

                /*  suffixIcon: GestureDetector(
                    onTap: () {
                      controller.clear();
                      setState(() {
                        isSearch = false;
                      });
                    },
                    child: Icon(Icons.close),
                  ),*/
                SizedBox(height: 16),
                Text("Search Results", style: Styles.textStyleMedium18),
              ],
            ),
          ),
        ),
        ...(isSearch
            ? [
                BlocBuilder<SearchMealsCubit, SearchMealsState>(
                  builder: (context, state) {
                    if (state is SearchMealsLoading) {
                      return SliverToBoxAdapter(
                        child: Center(child: ShimmerCardSwiper()),
                      );
                    } else if (state is SearchMealsFailure) {
                      return SliverToBoxAdapter(
                        child: Center(
                          child: Text(
                            state.errMessage,
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      );
                    } else if (state is SearchMealsSuccess) {
                      return SliverList(
                        delegate: SliverChildListDelegate.fixed([
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomCardSwiper(meals: state.meals),
                                SizedBox(height: 16),
                                Text(
                                  "Suggested Meals",
                                  style: Styles.textStyleMedium18,
                                ),
                                SizedBox(height: 16),
                              ],
                            ),
                          ),
                        ]),
                      );
                    }
                    return SliverToBoxAdapter(child: SizedBox.shrink());
                  },
                ),
                BlocBuilder<FetchMealsCubit, FetchMealsState>(
                  builder: (context, state) {
                    if (state.status == FetchMealsStatus.loading) {
                      return SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        sliver: ShimmerGridView(),
                      );
                    } else if (state.status == FetchMealsStatus.loaded) {
                      return SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        sliver: CustomSliverGridView(
                          meal: state.meals!,
                          itemCount: state.meals!.length,
                        ),
                      );
                    } else if (state.status == FetchMealsStatus.error) {
                      return SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Center(
                            child: Text(
                              state.errorMessage ?? 'An error occurred',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ),
                      );
                    }

                    return SliverToBoxAdapter(child: SizedBox.shrink());
                  },
                ),
              ]
            : [
                BlocBuilder<FetchMealDetailsCubit, FetchMealDetailsState>(
                  builder: (context, state) {
                    if (state.status == FetchMealDetailsStatus.loading) {
                      return SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
                          child: ShimmerMealCard(
                            height: MediaQuery.sizeOf(context).height * .35,
                          ),
                        ),
                      );
                    } else if (state .status == FetchMealDetailsStatus.error) {
                      return SliverToBoxAdapter(
                        child: Center(
                          child: Text(
                            state.errorMessage?? 'An error occurred',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      );
                    } else if (state.status == FetchMealDetailsStatus.loaded) {
                      return SliverList(
                        delegate: SliverChildListDelegate.fixed([
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MealCard(
                                  meal: state.meal!,
                                  height:
                                      MediaQuery.sizeOf(context).height * .35,
                                  style2: Styles.textStyleLight13.copyWith(
                                    color: Color(0xff4E4E4E),
                                  ),
                                ),
                                SizedBox(height: 16),
                                Text(
                                  "Suggested Meals",
                                  style: Styles.textStyleMedium18,
                                ),
                                SizedBox(height: 16),
                              ],
                            ),
                          ),
                        ]),
                      );
                    }
                    return SliverToBoxAdapter(child: SizedBox.shrink());
                  },
                ),
                BlocBuilder<FetchMealsCubit, FetchMealsState>(
                  builder: (context, state) {
                    if (state.status == FetchMealsStatus.loading) {
                      return SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        sliver: ShimmerGridView(),
                      );
                    } else if (state.status == FetchMealsStatus.loaded) {
                      return SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        sliver: CustomSliverGridView(
                          meal: state.meals!,
                          itemCount: state.meals!.length,
                        ),
                      );
                    } else if (state.status == FetchMealsStatus.error) {
                      return SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Center(
                            child: Text(
                              state.errorMessage?? 'An error occurred',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ),
                      );
                    }

                    return SliverToBoxAdapter(child: SizedBox.shrink());
                  },
                ),
              ]),
      ],
    );
  }
}

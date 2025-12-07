import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_planner/config/app_helper/app_gaps.dart';
import 'package:meal_planner/config/app_helper/app_padding.dart';
import 'package:meal_planner/core/utility/styles.dart';
import 'package:meal_planner/core/utility/widgets/shimmer/shimmer_home_view.dart';
import 'package:meal_planner/features/home/presentation/view_models/fetch_meals_cubit/fetch_meals_cubit.dart';
import 'package:meal_planner/features/home/presentation/views/widgets/custom_app_bar.dart';
import 'package:meal_planner/features/home/presentation/views/widgets/custom_card_swiper.dart';
import 'package:meal_planner/features/home/presentation/views/widgets/custom_sliver_grid_view.dart';
import 'package:meal_planner/features/home/presentation/views/widgets/meal_card.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  Future<void> _refreshData() async {
    await BlocProvider.of<FetchMealsCubit>(context).fetchMeals(count: 8);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchMealsCubit, FetchMealsState>(
      builder: (context, state) {
        if (state.status == FetchMealsStatus.loading) {
          return ShimmerHomeView();
        } else if (state.status == FetchMealsStatus.error) {
          return Center(child: Text("Error: ${state.errorMessage}"));
        } else if (state.status == FetchMealsStatus.loaded) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppPadding.defaultPadding24,
                vertical: AppPadding.defaultPadding16,
              ),
              child: RefreshIndicator(
                key: _refreshIndicatorKey,
                onRefresh: _refreshData,
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(child: CustomAppBar()),
                    SliverToBoxAdapter(child: AppGaps.defaultGap),
                    SliverToBoxAdapter(
                      child: Text(
                        "Today’s Meal",
                        style: Styles.textStyleBold24.copyWith(
                          color: Color(0xff232323),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Text(
                        "Picked for you today",
                        style: Styles.textStyleLight16.copyWith(
                          color: Color(0xff232323),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(child: AppGaps.defaultGap),
                    SliverToBoxAdapter(
                      child: MealCard(
                        meal: state.meals![6],
                        height: MediaQuery.sizeOf(context).height * .35,
                        style2: Styles.textStyleLight13.copyWith(
                          color: Color(0xff4E4E4E),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(child: AppGaps.defaultGap),

                    SliverToBoxAdapter(
                      child: Text(
                        "Daily Selection",
                        style: Styles.textStyleSemibold21.copyWith(
                          color: Color(0xff000000),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Text(
                        "Random meals to explore",
                        style: Styles.textStyleLight13.copyWith(
                          color: Color(0xff232323),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(child: AppGaps.smallGap),
                    SliverToBoxAdapter(
                      child: CustomCardSwiper(
                        meals: state.meals!,
                        itemCount: state.meals!.length,
                      ),
                    ),
                    SliverToBoxAdapter(child: AppGaps.bigGap),
                    SliverToBoxAdapter(
                      child: Text(
                        "Meal to Prepare",
                        style: Styles.textStyleBold24.copyWith(
                          color: Color(0xff232323),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Text(
                        "Today from your calendar",
                        style: Styles.textStyleLight13.copyWith(
                          color: Color(0xff232323),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(child: AppGaps.defaultGap),
                    SliverToBoxAdapter(
                      child: MealCard(
                        meal: state.meals![3],
                        height: MediaQuery.sizeOf(context).height * .35,
                        style2: Styles.textStyleLight13.copyWith(
                          color: Color(0xff4E4E4E),
                        ),
                        showIngredientsCountInsteadOfArea: true,
                      ),
                    ),

                    SliverToBoxAdapter(child: SizedBox(height: 16)),
                    SliverToBoxAdapter(
                      child: Text(
                        "Greek",
                        style: Styles.textStyleSemibold21.copyWith(
                          color: Color(0xff000000),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Text(
                        "Suggested cuisine",
                        style: Styles.textStyleLight13.copyWith(
                          color: Color(0xff232323),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(child: AppGaps.defaultGap),
                    CustomSliverGridView(
                      itemCount: state.meals!.length,
                      meal: state.meals!,
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}

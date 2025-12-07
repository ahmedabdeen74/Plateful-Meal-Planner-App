import 'package:flutter/material.dart';
import 'package:meal_planner/core/utility/styles.dart';
import 'package:meal_planner/core/utility/widgets/shimmer/shimmer_card_swiper.dart';
import 'package:meal_planner/core/utility/widgets/shimmer/shimmer_grid_view.dart';
import 'package:meal_planner/core/utility/widgets/shimmer/shimmer_meal_card.dart';
import 'package:meal_planner/features/home/presentation/views/widgets/custom_app_bar.dart';

class ShimmerHomeView extends StatefulWidget {
  const ShimmerHomeView({super.key});

  @override
  State<ShimmerHomeView> createState() => _ShimmerHomeViewState();
}

class _ShimmerHomeViewState extends State<ShimmerHomeView> {
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refreshKey.currentState?.show();
    });
  }

  Future<void> _handleRefresh() async {
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: RefreshIndicator(
          key: _refreshKey,
          onRefresh: _handleRefresh,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(child: CustomAppBar()),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
              SliverToBoxAdapter(
                child: Text(
                  "Today’s Meal",
                  style: Styles.textStyleBold24.copyWith(
                    color: const Color(0xff232323),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Text(
                  "Picked for you today",
                  style: Styles.textStyleLight16.copyWith(
                    color: const Color(0xff232323),
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
              SliverToBoxAdapter(
                child: ShimmerMealCard(
                  height: MediaQuery.sizeOf(context).height * .35,
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
              SliverToBoxAdapter(
                child: Text(
                  "Greek",
                  style: Styles.textStyleSemibold21.copyWith(
                    color: const Color(0xff000000),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Text(
                  "Suggested cuisine",
                  style: Styles.textStyleLight13.copyWith(
                    color: const Color(0xff232323),
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
              const ShimmerGridView(),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
              SliverToBoxAdapter(
                child: Text(
                  "Daily Selection",
                  style: Styles.textStyleSemibold21.copyWith(
                    color: const Color(0xff000000),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Text(
                  "Random meals to explore",
                  style: Styles.textStyleLight13.copyWith(
                    color: const Color(0xff232323),
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 8)),
              SliverToBoxAdapter(
                child: SizedBox(height: 250, child: const ShimmerCardSwiper()),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
              SliverToBoxAdapter(
                child: Text(
                  "Meal to Prepare",
                  style: Styles.textStyleBold24.copyWith(
                    color: const Color(0xff232323),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Text(
                  "Today from your calendar",
                  style: Styles.textStyleLight13.copyWith(
                    color: const Color(0xff232323),
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
              SliverToBoxAdapter(
                child: ShimmerMealCard(
                  height: MediaQuery.sizeOf(context).height * .35,
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
            ],
          ),
        ),
      ),
    );
  }
}

/*
import 'package:flutter/material.dart';
import 'package:meal_planner/core/utility/styles.dart';
import 'package:meal_planner/core/utility/widgets/shimmer_card_swiper.dart';
import 'package:meal_planner/core/utility/widgets/shimmer_grid_view.dart';
import 'package:meal_planner/core/utility/widgets/shimmer_meal_card.dart';
import 'package:meal_planner/features/home/presentation/views/widgets/custom_app_bar.dart';

class ShimmerHomeView extends StatelessWidget {
  const ShimmerHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: CustomAppBar()),
            SliverToBoxAdapter(child: SizedBox(height: 16)),
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
            SliverToBoxAdapter(child: SizedBox(height: 16)),
            SliverToBoxAdapter(
              child: ShimmerMealCard(
                height: MediaQuery.sizeOf(context).height * .35,
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
            SliverToBoxAdapter(child: SizedBox(height: 16)),
            ShimmerGridView(),
            SliverToBoxAdapter(child: SizedBox(height: 16)),
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
            SliverToBoxAdapter(child: SizedBox(height: 8)),
            SliverToBoxAdapter(child: Expanded(child: ShimmerCardSwiper())),
            SliverToBoxAdapter(child: SizedBox(height: 24)),
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
            SliverToBoxAdapter(child: SizedBox(height: 16)),
            SliverToBoxAdapter(
              child: ShimmerMealCard(
                height: MediaQuery.sizeOf(context).height * .35,
              ) /* MealCard(
                      meal: state.meals[3],
                      height: MediaQuery.sizeOf(context).height * .35,
                      style2: Styles.textStyleLight13.copyWith(
                        color: Color(0xff4E4E4E),
                      ),
                    ),*/,
            ),
            SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        ),
      ),
    );
  }
}
*/

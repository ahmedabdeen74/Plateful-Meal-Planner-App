import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_planner/features/explore/presentation/cubits/filter_cubits/fetch_filter_area_cubit.dart';
import 'package:meal_planner/features/explore/presentation/cubits/filter_cubits/fetch_filter_category_cubit.dart'
    show
        FetchFilterCategoryCubit,
        FetchFilterCategoryState,
        FetchFilterCategoryLoading,
        FetchFilterCategoryFailure,
        FetchFilterCategorySuccess;
import 'package:meal_planner/features/explore/presentation/views/widgets/explore_view_details_app_bar.dart';
import 'package:meal_planner/features/explore/presentation/views/widgets/list_view_meal_explore_card.dart';

class ExploreViewDetailsBody extends StatefulWidget {
  const ExploreViewDetailsBody({
    super.key,
    required this.isCategory,
    required this.name,
  });

  final bool isCategory;
  final String name;

  @override
  State<ExploreViewDetailsBody> createState() => _ExploreViewDetailsBodyState();
}

class _ExploreViewDetailsBodyState extends State<ExploreViewDetailsBody> {
  @override
  void initState() {
    super.initState();
    if (widget.isCategory) {
      context.read<FetchFilterCategoryCubit>().fetchFilterCategory(
        category: widget.name,
      );
    } else {
      context.read<FetchFilterAreaCubit>().fetchFilterArea(area: widget.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: ExploreViewDetailsAppBar(
              name: widget.name,
              isCategory: widget.isCategory,
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 32)),
          widget.isCategory
              ? BlocBuilder<FetchFilterCategoryCubit, FetchFilterCategoryState>(
                  builder: (context, state) {
                    if (state is FetchFilterCategorySuccess) {
                      return ListViewMealExploreCard(
                        meals: state.filterCategory,
                      );
                    } else if (state is FetchFilterCategoryLoading) {
                      return SliverToBoxAdapter(
                        child: Center(child: CircularProgressIndicator()),
                      );
                    } else if (state is FetchFilterCategoryFailure) {
                      return SliverToBoxAdapter(
                        child: Center(child: Text(state.errMessage)),
                      );
                    }
                    return SliverToBoxAdapter(child: SizedBox());
                  },
                )
              : BlocBuilder<FetchFilterAreaCubit, FetchFilterAreaState>(
                  builder: (context, state) {
                    if (state is FetchFilterAreaSuccess) {
                      return ListViewMealExploreCard(meals: state.filterArea);
                    } else if (state is FetchFilterAreaLoading) {
                      return SliverToBoxAdapter(
                        child: Center(child: CircularProgressIndicator()),
                      );
                    } else if (state is FetchFilterAreaFailure) {
                      return SliverToBoxAdapter(
                        child: Center(child: Text(state.errMessage)),
                      );
                    }
                    return SliverToBoxAdapter(child: SizedBox());
                  },
                ),
        ],
      ),
    );
  }
}

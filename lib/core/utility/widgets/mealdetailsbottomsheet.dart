import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_planner/core/utility/styles.dart';
import 'package:meal_planner/features/home/presentation/cubits/fetch_meal_details_cubit/fetch_meal_details_cubit.dart';
import 'package:meal_planner/features/home/presentation/views/widgets/list_view_ingrediant.dart';
import 'package:meal_planner/features/home/presentation/views/widgets/meal_details_app_bar.dart';
import 'package:meal_planner/features/home/presentation/views/widgets/meal_details_card.dart';
import 'package:meal_planner/features/home/presentation/views/widgets/video_instraction.dart';

class MealDetailsBottomSheet extends StatefulWidget {
  const MealDetailsBottomSheet({super.key});

  @override
  State<MealDetailsBottomSheet> createState() => _MealDetailsBottomSheetState();
}

class _MealDetailsBottomSheetState extends State<MealDetailsBottomSheet> {
  final DraggableScrollableController _draggableController =
      DraggableScrollableController();

  bool showAppBar = false;

  @override
  void initState() {
    super.initState();
    _draggableController.addListener(() {
      final extent = _draggableController.size;
      setState(() {
        showAppBar = extent > 0.6;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchMealDetailsCubit, FetchMealDetailsState>(
      builder: (context, state) {
        if (state.status == FetchMealDetailsStatus.loaded) {
          return DraggableScrollableSheet(
            controller: _draggableController,
            expand: true,
            initialChildSize: 0.85,
            minChildSize: 0.5,
            maxChildSize: 0.96,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                child: Column(
                  children: [
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 8, bottom: 8),
                        child: Container(
                          width: 50,
                          height: 5,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                        ),
                      ),
                    ),
                    if (showAppBar) MealDetailsAppBar(meal: state.meal!),
                    Expanded(
                      child: CustomScrollView(
                        controller: scrollController,
                        slivers: [
                          if (showAppBar)
                            //    const SliverToBoxAdapter(child: MealDetailsAppBar()),
                            const SliverToBoxAdapter(
                              child: SizedBox(height: 16),
                            ),
                          SliverToBoxAdapter(
                            child: MealDetailsCard(meal: state.meal!),
                          ),
                          const SliverToBoxAdapter(child: SizedBox(height: 8)),
                          ListViewIngrediant(meal: state.meal!),
                          const SliverToBoxAdapter(child: SizedBox(height: 16)),
                          const SliverToBoxAdapter(
                            child: Padding(
                              padding: EdgeInsets.only(left: 12),
                              child: Text(
                                "Recipe Video",
                                style: Styles.textStyleSemibold21,
                              ),
                            ),
                          ),
                          const SliverToBoxAdapter(child: SizedBox(height: 8)),
                          SliverToBoxAdapter(
                            child: VideoInstraction(meal: state.meal!),
                          ),
                          const SliverToBoxAdapter(child: SizedBox(height: 24)),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        } else if (state.status == FetchMealDetailsStatus.loading) {
          return Text("");
        } else if (state.status == FetchMealDetailsStatus.error) {
          return Center(child: Text("Error: ${state.errorMessage}"));
        }
        return const SizedBox.shrink();
      },
    );
  }
}

/*
class MealDetailsBottomSheet extends StatelessWidget {
  const MealDetailsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 1.0,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
          child: CustomScrollView(
            controller: scrollController,
            slivers: const [
              SliverToBoxAdapter(child: MealDetailsAppBar()),
              SliverToBoxAdapter(child: SizedBox(height: 16)),
              SliverToBoxAdapter(child: MealDetailsCard()),
              SliverToBoxAdapter(child: SizedBox(height: 8)),
              ListViewIngrediant(),
              SliverToBoxAdapter(child: SizedBox(height: 16)),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: Text(
                    "Recipe Video",
                    style: Styles.textStyleSemibold21,
                  ),
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 8)),
              SliverToBoxAdapter(child: VideoInstraction()),
              SliverToBoxAdapter(child: SizedBox(height: 24)),
            ],
          ),
        );
      },
    );
  }
}
*/

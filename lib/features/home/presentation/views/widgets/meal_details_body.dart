
/*
class MealDetailsBody extends StatelessWidget {
  const MealDetailsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchMealDetailsCubit, FetchMealDetailsState>(
      builder: (context, state) {
        if (state is FetchMealDetailsSuccess) {
          return SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                  child: MealDetailsAppBar(),
                ),
                // SizedBox(height: 16),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      bottom: 16,
                    ),
                    child: CustomScrollView(
                      slivers: [
                        // SliverToBoxAdapter(child: MealDetailsAppBar()),
                        SliverToBoxAdapter(child: SizedBox(height: 16)),
                        SliverToBoxAdapter(child: MealDetailsCard(meal: state.meal,)),
                        SliverToBoxAdapter(child: SizedBox(height: 8)),
                        ListViewIngrediant(meal: state.meal,),
                        SliverToBoxAdapter(child: SizedBox(height: 16)),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Text(
                              "Recipe Video",
                              style: Styles.textStyleSemibold21,
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(child: SizedBox(height: 8)),
                        SliverToBoxAdapter(child: VideoInstraction(meal: state.meal,)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (state is FetchMealDetailsLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is FetchMealDetailsFailure) {
          return Center(child: Text("Error: ${state.errorMessage}"));
        }
        return SizedBox.shrink();
      },
    );
  }
}
*/

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_planner/core/utility/area_assets.dart';
import 'package:meal_planner/core/utility/assets_category.dart';
import 'package:meal_planner/core/utility/routers/app_router.dart';
import 'package:meal_planner/core/utility/widgets/shimmer/shimmer_custom_search_result_item.dart';
import 'package:meal_planner/features/explore/presentation/river_pod/explore_repo_provider.dart';
import 'package:meal_planner/features/explore/presentation/river_pod/fetch_area/fetch_area_state.dart';
import 'package:meal_planner/features/explore/presentation/river_pod/fetch_category/fetch_category_notifie.dart';
import 'package:meal_planner/features/explore/presentation/river_pod/fetch_category/fetch_category_state.dart';
import 'package:meal_planner/features/search/presentation/views/widgets/custom_text_field.dart';

class ExploreViewBody extends ConsumerStatefulWidget {
  const ExploreViewBody({super.key});

  @override
  ConsumerState<ExploreViewBody> createState() => _ExploreViewBodyState();
}

class _ExploreViewBodyState extends ConsumerState<ExploreViewBody> {
  TextEditingController _controller = TextEditingController();
  String searchQuery = '';

  int selectedIndex = 0; // 0 = Categories, 1 = Cuisines
  final Map<String, String> areaImages = {
    "American": AssetsArea.american,
    "British": AssetsArea.british,
    "Canadian": AssetsArea.canada,
    "Chinese": AssetsArea.china,
    "Croatian": AssetsArea.croatia,
    "Dutch": AssetsArea.holanda,
    "Egyptian": AssetsArea.egypt,
    "Filipino": AssetsArea.philippines,
    "French": AssetsArea.france,
    "Greek": AssetsArea.greek,
    "Indian": AssetsArea.india,
    "Irish": AssetsArea.irlanda,
    "Italian": AssetsArea.italy,
    "Jamaican": AssetsArea.jamaica,
    "Japanese": AssetsArea.japan,
    "Kenyan": AssetsArea.kenya,
    "Malaysian": AssetsArea.malaysia,
    "Mexican": AssetsArea.mexico,
    "Moroccan": AssetsArea.morocco,
    "Polish": AssetsArea.poland,
    "Portuguese": AssetsArea.portugal,
    "Russian": AssetsArea.russia,
    "Spanish": AssetsArea.spain,
    "Thai": AssetsArea.thailand,
    "Tunisian": AssetsArea.tunisia,
    "Turkish": AssetsArea.turkey,
    "Ukrainian": AssetsArea.ukraine,
    "Uruguayan": AssetsArea.uruguay,
    "Vietnamese": AssetsArea.malaysia,
  };
  final Map<String, String> categoryImages = {
    "Beef": AssetsCategory.beef,
    "Breakfast": AssetsCategory.breakfast,
    "Chicken": AssetsCategory.chicken,
    "Dessert": AssetsCategory.dessert,
    "Goat": AssetsCategory.goat,
    "Lamb": AssetsCategory.lamb,
    "Miscellaneous": AssetsCategory.miscellaneous,
    "Pasta": AssetsCategory.pasta,
    "Pork": AssetsCategory.pork,
    "Seafood": AssetsCategory.seafood,
    "Side": AssetsCategory.side,
    "Starter": AssetsCategory.starter,
    "Vegan": AssetsCategory.vegan,
    "Vegetarian": AssetsCategory.vegetarian,
  };

  /* final List<String> categories = [
    "Breakfast",
    "Starter",
    "Dessert",
    "Lunch",
    "Side",
    "Vegan",
    "Breakfast",
    "Starter",
    "Dessert",
    "Lunch",
    "Side",
    "Vegan",
  ];

  final List<String> cuisines = [
    "Italian",
    "Mexican",
    "Chinese",
    "Indian",
    "Thai",
    "French",
    "Italian",
    "Mexican",
    "Chinese",
    "Indian",
    "Thai",
    "French",
  ];
  */
  @override
  void initState() {
    Future.microtask(() {
      ref.read(fetchCategoryProvider.notifier).fetchCategory();
      ref.read(fetchAreaProvider.notifier).fetchArea();
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                // Tabs (Categories / Cuisines)
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = 0;
                          });
                        },
                        child: Column(
                          children: [
                            Text(
                              "Categories",
                              style: TextStyle(
                                color: selectedIndex == 0
                                    ? Colors.blue
                                    : Colors.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            if (selectedIndex == 0)
                              Container(
                                height: 2,
                                color: Colors.blue,
                                margin: const EdgeInsets.only(top: 4),
                              ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = 1;
                          });
                        },
                        child: Column(
                          children: [
                            Text(
                              "Cuisines",
                              style: TextStyle(
                                color: selectedIndex == 1
                                    ? Colors.blue
                                    : Colors.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            if (selectedIndex == 1)
                              Container(
                                height: 2,
                                color: Colors.blue,
                                margin: const EdgeInsets.only(top: 4),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                CustomTextField(
                  controller: _controller,
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                ),
                const SizedBox(height: 32),

                selectedIndex == 0
                    ? Consumer(
                        builder: (context, ref, child) {
                          final state = ref.watch(fetchCategoryProvider);

                          if (state is FetchCategoryLoading) {
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: 8,
                              itemBuilder: (context, index) =>
                                  ShimmerCustomSearchResultItem(),
                            );
                          } else if (state is FetchCategoryFailure) {
                            return Center(child: Text(state.message));
                          } else if (state is FetchCategorySuccess) {
                            final categories = state.categories
                                .where(
                                  (item) =>
                                      categoryImages.containsKey(
                                        item.strCategory,
                                      ) &&
                                      (item.strCategory?.toLowerCase().contains(
                                            searchQuery.toLowerCase(),
                                          ) ??
                                          false),
                                )
                                .toList();

                            return ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: categories.length,
                              itemBuilder: (context, index) {
                                final item = categories[index];
                                final name = item.strCategory!;
                                final img = categoryImages[name]!;

                                return GestureDetector(
                                  onTap: () {
                                    AppRouter.to(AppRouter.kExploreViewDetails,
                                        arguments: {
                                          'isCategory': true,
                                          'name': name,
                                        });
                                  },
                                  child: ListTile(
                                    leading: ClipOval(
                                      child: Image.asset(
                                        img,
                                        width: 40,
                                        height: 40,
                                      ),
                                    ),
                                    title: Text(name),
                                  ),
                                );
                              },
                            );
                          }

                          return SizedBox.shrink();
                        },
                      )
                    : Consumer(
                        builder: (context, ref, _) {
                          final state = ref.watch(fetchAreaProvider);

                          if (state is FetchAreaLoading) {
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: 8,
                              itemBuilder: (context, index) =>
                                  ShimmerCustomSearchResultItem(),
                            );
                          } else if (state is FetchAreaFailure) {
                            return Center(child: Text(state.errMessage));
                          } else if (state is FetchAreaSuccess) {
                            final areas = state.areas
                                .where(
                                  (item) =>
                                      item.strArea?.toLowerCase() !=
                                          'unknown' &&
                                      (item.strArea?.toLowerCase().contains(
                                            searchQuery.toLowerCase(),
                                          ) ??
                                          false),
                                )
                                .toList();

                            return areas.isEmpty
                                ? Center(
                                    child: Text(
                                      'No cuisines match your search.',
                                    ),
                                  )
                                : ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: areas.length,
                                    itemBuilder: (context, index) {
                                      final item = areas[index];
                                      final areaName =
                                          item.strArea ?? "Unknown";
                                      final imagePath =
                                          areaImages[areaName] ??
                                          'assets/areas/default.png';

                                      return GestureDetector(
                                        onTap: () {
                                          AppRouter.to(AppRouter.kExploreViewDetails,
                                        arguments: {
                                          'isCategory': true,
                                          'name': item.strArea!,
                                        });
                                         
                                        },
                                        child: ListTile(
                                          leading: ClipOval(
                                            child: Image.asset(
                                              imagePath,
                                              width: 40,
                                              height: 40,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          title: Text(areaName),
                                        ),
                                      );
                                    },
                                  );
                          } else {
                            return SizedBox.shrink();
                          }
                        },
                      ),
              ],
            ),
          ),
        ],
      ),
    );
    // Content based on selected tab
  }
}

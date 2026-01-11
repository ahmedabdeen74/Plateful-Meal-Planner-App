import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:meal_planner/constants.dart';
import 'package:meal_planner/core/utility/routers/app_router.dart';
import 'package:meal_planner/features/auth/data/auth_service.dart';
import 'package:meal_planner/features/calendar/presentation/views/calendar_view.dart';
import 'package:meal_planner/features/explore/presentation/views/explore_view.dart';
import 'package:meal_planner/features/favourite/presentation/views/favourite_view.dart';
import 'package:meal_planner/features/home/presentation/views/widgets/home_view_body.dart';
import 'package:meal_planner/features/search/presentation/views/search_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int currentIndex = 0;
  final AuthService _authService = AuthService();

  final List<Widget> screens = [
    HomeViewBody(),
    SearchView(),
    ExploreView(),
    FavouriteView(),
    CalendarView(),
  ];

  void _onTabChange(int index, BuildContext context) async {
    if (index == 3 || index == 4) {
      // Favourite or Calendar
      final user = await _authService.getCurrentUser();
      if (user == null) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: kAlertColor,
            title: Text('Sign In Required'),
            content: Text('You need to sign in to access this feature.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                 AppRouter.pop();
                  AppRouter.to(AppRouter.kLoginView);
                  // Navigator.pop(context);
                  // GoRouter.of(context).push(AppRouter.kLoginView);
                },
                child: Text('Sign In'),
              ),
            ],
          ),
        );
        return;
      }
    }
    setState(() => currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
        child: GNav(
          backgroundColor: Colors.white,
          color: Colors.grey[600],
          activeColor: Colors.white,
          tabBackgroundColor: Colors.deepOrange,
          gap: 0,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          selectedIndex: currentIndex,
          onTabChange: (index) => _onTabChange(index, context),
          tabs: const [
            GButton(icon: Icons.home, text: 'Home'),
            GButton(icon: Icons.search, text: 'Search'),
            GButton(icon: Icons.explore, text: 'Explore'),
            GButton(icon: Icons.favorite, text: 'Favourite'),
            GButton(icon: Icons.calendar_month, text: 'Calendar'),
          ],
        ),
      ),
    );
  }
}

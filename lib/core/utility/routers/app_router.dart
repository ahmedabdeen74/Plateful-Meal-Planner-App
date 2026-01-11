import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_planner/core/utility/di/service_locator.dart';
import 'package:meal_planner/core/utility/routers/unknown_router.dart';
import 'package:meal_planner/features/auth/auth_view.dart';
import 'package:meal_planner/features/auth/presentation/views/sign_in_view.dart';
import 'package:meal_planner/features/auth/presentation/views/sign_up_view.dart';
import 'package:meal_planner/features/calendar/presentation/views/calendar_view.dart';
import 'package:meal_planner/features/explore/data/repo/explore_repo_impl.dart';
import 'package:meal_planner/features/explore/presentation/cubits/filter_cubits/fetch_filter_area_cubit.dart';
import 'package:meal_planner/features/explore/presentation/cubits/filter_cubits/fetch_filter_category_cubit.dart';
import 'package:meal_planner/features/explore/presentation/views/explore_view.dart';
import 'package:meal_planner/features/explore/presentation/views/explore_view_details.dart';
import 'package:meal_planner/features/favourite/presentation/views/favourite_view.dart';
import 'package:meal_planner/features/home/presentation/views/home_view.dart';
import 'package:meal_planner/features/search/presentation/views/search_result_view.dart';
import 'package:meal_planner/features/search/presentation/views/search_view.dart';
import 'package:meal_planner/features/splash/presentation/views/splash_view.dart';

class AppRouter {
  ///[navigatorKey] is the global NavigatorState key
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static const kAuthView = "/auth_view";
  static const kLoginView = "/login_view";
  static const kSignupView = "/signup_view";
  static const kHomeView = "/home_view";
  static const kSearchView = "/search_view";
  static const kMealDetails = "/meal_view";
  static const kFavouriteView = "/fav_view";
  static const kCalendarView = "/calendar_view";
  static const kExploreView = "/explore_view";
  static const kSettingsView = "/settings_view";
  static const kSearchResultView = "/search_result_view";
  static const kExploreViewDetails = "/explore_details_view";

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Splash
      case '/':
        return MaterialPageRoute(
          builder: (_) => const SplashView(),
          settings: settings,
        );

      // Auth
      case kAuthView:
        return MaterialPageRoute(
          builder: (_) => const AuthView(),
          settings: settings,
        );
      case kLoginView:
        return MaterialPageRoute(
          builder: (_) => const SignInView(),
          settings: settings,
        );
      case kSignupView:
        return MaterialPageRoute(
          builder: (_) => const SignUpView(),
          settings: settings,
        );

      // Home
      case kHomeView:
        return MaterialPageRoute(
          builder: (_) => const HomeView(),
          settings: settings,
        );

      // Calendar
      case kCalendarView:
        return MaterialPageRoute(
          builder: (_) => const CalendarView(),
          settings: settings,
        );

      // Favourite
      case kFavouriteView:
        return MaterialPageRoute(
          builder: (_) => const FavouriteView(),
          settings: settings,
        );

      // Explore
      case kExploreView:
        return MaterialPageRoute(
          builder: (_) => const ExploreView(),
          settings: settings,
        );

      // Search
      case kSearchView:
        return MaterialPageRoute(
          builder: (_) => const SearchView(),
          settings: settings,
        );

      // Search Result
      case kSearchResultView:
        final mealName = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => SearchResultView(mealName: mealName),
          settings: settings,
        );

      // Explore Details
      case kExploreViewDetails:
        final extra = settings.arguments as Map<String, dynamic>;
        final isCategory = extra['isCategory'] as bool;
        final name = extra['name'] as String;

        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) =>
                    FetchFilterCategoryCubit(getIt<ExploreRepoImpl>()),
              ),
              BlocProvider(
                create: (_) => FetchFilterAreaCubit(getIt<ExploreRepoImpl>()),
              ),
            ],
            child: ExploreViewDetails(isCategory: isCategory, name: name),
          ),
          settings: settings,
        );

      default:
        return unknownRoute;
    }
  }

  static Route get unknownRoute =>
      MaterialPageRoute(builder: (_) => const UnknownRoute());

  static Future<Object?>? to(String route, {Object? arguments}) async {
    return await navigatorKey.currentState?.pushNamed(
      route,
      arguments: arguments,
    );
  }

  static Future<Object?>? toReplacement(String route, {Object? arguments}) {
    return navigatorKey.currentState?.pushReplacementNamed(
      route,
      arguments: arguments,
    );
  }

  static Future<Object?>? toAndRemoveUntil(
    String route, {
    Object? arguments,
  }) async {
    return await navigatorKey.currentState?.pushNamedAndRemoveUntil(
      route,
      (route) => false,
      arguments: arguments,
    );
  }

  static void pop([Object? result]) {
    navigatorKey.currentState?.pop(result);
  }
}

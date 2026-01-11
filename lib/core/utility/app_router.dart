import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_planner/core/utility/di/service_locator.dart';
import 'package:meal_planner/features/auth/auth_view.dart';
import 'package:meal_planner/features/auth/presentation/views/sign_in_view.dart';
import 'package:meal_planner/features/auth/presentation/views/sign_up_view.dart';
import 'package:meal_planner/features/calendar/presentation/views/calendar_view.dart';
import 'package:meal_planner/features/explore/data/repo/explore_repo_impl.dart';
import 'package:meal_planner/features/explore/presentation/cubits/filter_cubits/fetch_filter_area_cubit.dart' show FetchFilterAreaCubit;
import 'package:meal_planner/features/explore/presentation/cubits/filter_cubits/fetch_filter_category_cubit.dart';
import 'package:meal_planner/features/explore/presentation/views/explore_view.dart';
import 'package:meal_planner/features/explore/presentation/views/explore_view_details.dart';
import 'package:meal_planner/features/favourite/presentation/views/favourite_view.dart';
import 'package:meal_planner/features/home/presentation/views/home_view.dart';
import 'package:meal_planner/features/search/presentation/views/search_result_view.dart';
import 'package:meal_planner/features/search/presentation/views/search_view.dart';
import 'package:meal_planner/features/splash/presentation/views/splash_view.dart';
/*
class AppRouter {
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

  static final router = GoRouter(
    routes: [
      GoRoute(
      path: kAuthView,
      builder: (context, state) => const AuthView(),
    ),
    GoRoute(
      path: kSignupView,
      builder: (context, state) => const SignUpView(),
    ),
    GoRoute(
      path: kLoginView,
      builder: (context, state) => const SignInView(),
    ),
      GoRoute(path: '/', builder: (context, state) => const SplashView()),
      GoRoute(path: kHomeView, builder: (context, state) => const HomeView()),
      GoRoute(
        path: kCalendarView,
        builder: (context, state) => const CalendarView(),
      ),
      GoRoute(
        path: kFavouriteView,
        builder: (context, state) => const FavouriteView(),
      ),
      GoRoute(
        path: kExploreView,
        builder: (context, state) => const ExploreView(),
      ),
      GoRoute(
        path: kSearchView,
        builder: (context, state) => const SearchView(),
      ),
      GoRoute(
        path: kSearchResultView,
        builder: (context, state) {
          final mealName = state.extra as String;
          return SearchResultView(mealName: mealName);
        },
      ),
      GoRoute(
  path: kExploreViewDetails,
  builder: (context, state) {
    final extra = state.extra as Map<String, dynamic>;
    final isCategory = extra['isCategory'] as bool;
    final name = extra['name'] as String;

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => FetchFilterCategoryCubit(getIt<ExploreRepoImpl>())),
        BlocProvider(create: (_) => FetchFilterAreaCubit(getIt<ExploreRepoImpl>())),
      ],
      child: ExploreViewDetails(
        isCategory: isCategory,
        name: name,
      ),
    );
  },
),

     /* GoRoute(
        path: kExploreViewDetails,
        builder: (context, state) {
          final isCategory = state.extra as bool;
          return ExploreViewDetails(isCategory: isCategory);
        },
      ),*/
    ],
    
  );
}

/*
    GoRoute(
      path: kAuthView,
      builder: (context, state) => const AuthView(),
    ),
    GoRoute(
      path: kSignupView,
      builder: (context, state) => const SignupView(),
    ),
    GoRoute(
      path: kLoginView,
      builder: (context, state) => const LoginView(),
    ),
    GoRoute(
      path: kMealDetails,
      builder: (context, state) => const MealDetailsView(),
    ),
    GoRoute(
      path: kCalendarView,
      builder: (context, state) => const CalendarView(),
    ),
    GoRoute(
      path: kFavouriteView,
      builder: (context, state) => const FavouriteView(),
    ),
    GoRoute(
      path: kExploreView,
      builder: (context, state) => const ExploreView(),
    ),
    GoRoute(
      path: kSettingsView,
      builder: (context, state) => const SettingsView(),
    ),
  ]);
}
*/
}
*/

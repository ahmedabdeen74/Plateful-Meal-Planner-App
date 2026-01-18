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

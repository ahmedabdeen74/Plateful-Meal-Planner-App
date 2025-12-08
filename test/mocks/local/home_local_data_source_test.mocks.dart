import 'package:flutter_test/flutter_test.dart';
import 'package:meal_planner/features/home/data/data_sources/local/home_local_data_source.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:hive/hive.dart';
import 'package:meal_planner/constants.dart';
import 'package:meal_planner/features/home/data/models/meal_model/meal.dart';
import 'home_local_data_source_test.mocks.mocks.dart';

@GenerateMocks([Box])
void main() {
  late MockBox<Meal> mockMealsBox;
  late MockBox<Meal> mockMealDetailsBox;
  late HomeLocalDataSourceImpl dataSource;

  setUp(() {
    mockMealsBox = MockBox<Meal>();
    mockMealDetailsBox = MockBox<Meal>();

    // Stub Hive.box()
    when(Hive.box<Meal>(kCacheMeal)).thenReturn(mockMealsBox);
    when(Hive.box<Meal>(kCacheMealDetails)).thenReturn(mockMealDetailsBox);

    dataSource = HomeLocalDataSourceImpl();
  });

  group("HomeLocalDataSourceImpl Tests", () {
    test('fetchMeals returns list of meals', () {
      // Arrange
      final meal = Meal(idMeal: "1", strMeal: "Pasta");
      when(mockMealsBox.values).thenReturn([meal]);

      // Act
      final result = dataSource.fetchMeals();

      // Assert
      expect(result, isA<List<Meal>>());
      expect(result.length, 1);
      expect(result.first.strMeal, "Pasta");
    });

    test('fetchMealDetails returns meal by ID', () {
      // Arrange
      final meal = Meal(idMeal: "10", strMeal: "Pizza");
      when(mockMealDetailsBox.get("10")).thenReturn(meal);

      // Act
      final result = dataSource.fetchMealDetails("10");

      // Assert
      expect(result, isNotNull);
      expect(result!.strMeal, "Pizza");
    });

    test('saveMeals saves list of meals (calls put correct times)', () async {
      // Arrange
      final meals = [
        Meal(idMeal: "1", strMeal: "Chicken"),
        Meal(idMeal: "2", strMeal: "Beef"),
      ];

      // Act
      await dataSource.saveMeals(meals);

      // Assert
      verify(mockMealsBox.put("1", meals[0])).called(1);
      verify(mockMealsBox.put("2", meals[1])).called(1);
    });

    test('saveMeal saves single meal', () async {
      // Arrange
      final meal = Meal(idMeal: "55", strMeal: "Salad");

      // Act
      await dataSource.saveMeal(meal);

      // Assert
      verify(mockMealDetailsBox.put("55", meal)).called(1);
    });
  });
}

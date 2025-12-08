import 'package:flutter_test/flutter_test.dart';
import 'package:meal_planner/features/home/data/models/meal_model/meal.dart';
import 'package:meal_planner/features/home/data/models/meal_model/meal_model.dart';

void main() {

  group("MealModel Parsing Tests", () {

    test("fromJson should parse JSON correctly", () {
      final json = {
        "meals": [
          {
            "idMeal": "1234",
            "strMeal": "Pizza",
            "strArea": "Italian",
            "strMealThumb": "https://example.com/pizza.jpg",
          },
          {
            "idMeal": "5678",
            "strMeal": "Burger",
            "strArea": "American",
            "strMealThumb": "https://example.com/burger.jpg",
          }
        ]
      };

      final model = MealModel.fromJson(json);

      expect(model.meals, isNotNull);
      expect(model.meals!.length, 2);
      expect(model.meals![0].strMeal, "Pizza");
      expect(model.meals![1].strArea, "American");
    });

    test("toJson should convert model back to JSON properly", () {
      final meals = [
        Meal(
          idMeal: "1234",
          strMeal: "Pizza",
          strArea: "Italian",
          strMealThumb: "https://example.com/pizza.jpg",
        ),
      ];

      final model = MealModel(meals: meals);
      final json = model.toJson();

      expect(json["meals"], isA<List>());
      expect(json["meals"][0]["strMeal"], "Pizza");
      expect(json["meals"][0]["idMeal"], "1234");
    });

    test("Equatable props should work correctly", () {
      final model1 = MealModel(meals: [
        Meal(idMeal: "1", strMeal: "A"),
      ]);

      final model2 = MealModel(meals: [
        Meal(idMeal: "1", strMeal: "A"),
      ]);

      expect(model1, equals(model2));
    });

  });
}

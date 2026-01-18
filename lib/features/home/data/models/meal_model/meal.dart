import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
part 'meal.g.dart';
@HiveType(typeId: 0)
class Meal extends HiveObject with EquatableMixin {
  @HiveField(0)
  final String? idMeal;
  @HiveField(1)
  final String? strMeal;
  @HiveField(2)
  final dynamic strMealAlternate;
  @HiveField(3)
  final String? strCategory;
  @HiveField(4)
  final String? strArea;
  @HiveField(5)
  final String? strInstructions;
  @HiveField(6)
  final String? strMealThumb;
  @HiveField(7)
  final String? strTags;
  @HiveField(8)
  final String? strYoutube;
  @HiveField(9)
  final String? strIngredient1;
  @HiveField(10)
  final String? strIngredient2;
  @HiveField(11)
  final String? strIngredient3;
  @HiveField(12)
  final String? strIngredient4;
  @HiveField(13)
  final String? strIngredient5;
  @HiveField(14)
  final String? strIngredient6;
  @HiveField(15)
  final String? strIngredient7;
  @HiveField(16)
  final String? strIngredient8;
  @HiveField(17)
  final String? strIngredient9;
  @HiveField(18)
  final String? strIngredient10;
  @HiveField(19)
  final String? strIngredient11;
  @HiveField(20)
  final String? strIngredient12;
  @HiveField(21)
  final String? strIngredient13;
  @HiveField(22)
  final String? strIngredient14;
  @HiveField(23)
  final String? strIngredient15;
  @HiveField(24)
  final String? strIngredient16;
  @HiveField(25)
  final String? strIngredient17;
  @HiveField(26)
  final String? strIngredient18;
  @HiveField(27)
  final String? strIngredient19;
  @HiveField(28)
  final String? strIngredient20;
  @HiveField(29)
  final String? strMeasure1;
  @HiveField(30)
  final String? strMeasure2;
  @HiveField(31)
  final String? strMeasure3;
  @HiveField(32)
  final String? strMeasure4;
  @HiveField(33)
  final String? strMeasure5;
  @HiveField(34)
  final String? strMeasure6;
  @HiveField(35)
  final String? strMeasure7;
  @HiveField(36)
  final String? strMeasure8;
  @HiveField(37)
  final String? strMeasure9;
  @HiveField(38)
  final String? strMeasure10;
  @HiveField(39)
  final String? strMeasure11;
  @HiveField(40)
  final String? strMeasure12;
  @HiveField(41)
  final String? strMeasure13;
  @HiveField(42)
  final String? strMeasure14;
  @HiveField(43)
  final String? strMeasure15;
  @HiveField(44)
  final String? strMeasure16;
  @HiveField(45)
  final String? strMeasure17;
  @HiveField(46)
  final String? strMeasure18;
  @HiveField(47)
  final String? strMeasure19;
  @HiveField(48)
  final String? strMeasure20;
  @HiveField(49)
  final String? strSource;
  @HiveField(50)
  final dynamic strImageSource;
  @HiveField(51)
  final dynamic strCreativeCommonsConfirmed;
  @HiveField(52)
  final dynamic dateModified;

   Meal({
    this.idMeal,
    this.strMeal,
    this.strMealAlternate,
    this.strCategory,
    this.strArea,
    this.strInstructions,
    this.strMealThumb,
    this.strTags,
    this.strYoutube,
    this.strIngredient1,
    this.strIngredient2,
    this.strIngredient3,
    this.strIngredient4,
    this.strIngredient5,
    this.strIngredient6,
    this.strIngredient7,
    this.strIngredient8,
    this.strIngredient9,
    this.strIngredient10,
    this.strIngredient11,
    this.strIngredient12,
    this.strIngredient13,
    this.strIngredient14,
    this.strIngredient15,
    this.strIngredient16,
    this.strIngredient17,
    this.strIngredient18,
    this.strIngredient19,
    this.strIngredient20,
    this.strMeasure1,
    this.strMeasure2,
    this.strMeasure3,
    this.strMeasure4,
    this.strMeasure5,
    this.strMeasure6,
    this.strMeasure7,
    this.strMeasure8,
    this.strMeasure9,
    this.strMeasure10,
    this.strMeasure11,
    this.strMeasure12,
    this.strMeasure13,
    this.strMeasure14,
    this.strMeasure15,
    this.strMeasure16,
    this.strMeasure17,
    this.strMeasure18,
    this.strMeasure19,
    this.strMeasure20,
    this.strSource,
    this.strImageSource,
    this.strCreativeCommonsConfirmed,
    this.dateModified,
  });

  factory Meal.fromJson(Map<String, dynamic> json) => Meal(
    idMeal: json['idMeal'] as String?,
    strMeal: json['strMeal'] as String?,
    strMealAlternate: json['strMealAlternate'] as dynamic,
    strCategory: json['strCategory'] as String?,
    strArea: json['strArea'] as String?,
    strInstructions: json['strInstructions'] as String?,
    strMealThumb: json['strMealThumb'] as String?,
    strTags: json['strTags'] as String?,
    strYoutube: json['strYoutube'] as String?,
    strIngredient1: json['strIngredient1'] as String?,
    strIngredient2: json['strIngredient2'] as String?,
    strIngredient3: json['strIngredient3'] as String?,
    strIngredient4: json['strIngredient4'] as String?,
    strIngredient5: json['strIngredient5'] as String?,
    strIngredient6: json['strIngredient6'] as String?,
    strIngredient7: json['strIngredient7'] as String?,
    strIngredient8: json['strIngredient8'] as String?,
    strIngredient9: json['strIngredient9'] as String?,
    strIngredient10: json['strIngredient10'] as String?,
    strIngredient11: json['strIngredient11'] as String?,
    strIngredient12: json['strIngredient12'] as String?,
    strIngredient13: json['strIngredient13'] as String?,
    strIngredient14: json['strIngredient14'] as String?,
    strIngredient15: json['strIngredient15'] as String?,
    strIngredient16: json['strIngredient16'] as String?,
    strIngredient17: json['strIngredient17'] as String?,
    strIngredient18: json['strIngredient18'] as String?,
    strIngredient19: json['strIngredient19'] as String?,
    strIngredient20: json['strIngredient20'] as String?,
    strMeasure1: json['strMeasure1'] as String?,
    strMeasure2: json['strMeasure2'] as String?,
    strMeasure3: json['strMeasure3'] as String?,
    strMeasure4: json['strMeasure4'] as String?,
    strMeasure5: json['strMeasure5'] as String?,
    strMeasure6: json['strMeasure6'] as String?,
    strMeasure7: json['strMeasure7'] as String?,
    strMeasure8: json['strMeasure8'] as String?,
    strMeasure9: json['strMeasure9'] as String?,
    strMeasure10: json['strMeasure10'] as String?,
    strMeasure11: json['strMeasure11'] as String?,
    strMeasure12: json['strMeasure12'] as String?,
    strMeasure13: json['strMeasure13'] as String?,
    strMeasure14: json['strMeasure14'] as String?,
    strMeasure15: json['strMeasure15'] as String?,
    strMeasure16: json['strMeasure16'] as String?,
    strMeasure17: json['strMeasure17'] as String?,
    strMeasure18: json['strMeasure18'] as String?,
    strMeasure19: json['strMeasure19'] as String?,
    strMeasure20: json['strMeasure20'] as String?,
    strSource: json['strSource'] as String?,
    strImageSource: json['strImageSource'] as dynamic,
    strCreativeCommonsConfirmed: json['strCreativeCommonsConfirmed'] as dynamic,
    dateModified: json['dateModified'] as dynamic,
  );

  Map<String, dynamic> toJson() => {
    'idMeal': idMeal,
    'strMeal': strMeal,
    'strMealAlternate': strMealAlternate,
    'strCategory': strCategory,
    'strArea': strArea,
    'strInstructions': strInstructions,
    'strMealThumb': strMealThumb,
    'strTags': strTags,
    'strYoutube': strYoutube,
    'strIngredient1': strIngredient1,
    'strIngredient2': strIngredient2,
    'strIngredient3': strIngredient3,
    'strIngredient4': strIngredient4,
    'strIngredient5': strIngredient5,
    'strIngredient6': strIngredient6,
    'strIngredient7': strIngredient7,
    'strIngredient8': strIngredient8,
    'strIngredient9': strIngredient9,
    'strIngredient10': strIngredient10,
    'strIngredient11': strIngredient11,
    'strIngredient12': strIngredient12,
    'strIngredient13': strIngredient13,
    'strIngredient14': strIngredient14,
    'strIngredient15': strIngredient15,
    'strIngredient16': strIngredient16,
    'strIngredient17': strIngredient17,
    'strIngredient18': strIngredient18,
    'strIngredient19': strIngredient19,
    'strIngredient20': strIngredient20,
    'strMeasure1': strMeasure1,
    'strMeasure2': strMeasure2,
    'strMeasure3': strMeasure3,
    'strMeasure4': strMeasure4,
    'strMeasure5': strMeasure5,
    'strMeasure6': strMeasure6,
    'strMeasure7': strMeasure7,
    'strMeasure8': strMeasure8,
    'strMeasure9': strMeasure9,
    'strMeasure10': strMeasure10,
    'strMeasure11': strMeasure11,
    'strMeasure12': strMeasure12,
    'strMeasure13': strMeasure13,
    'strMeasure14': strMeasure14,
    'strMeasure15': strMeasure15,
    'strMeasure16': strMeasure16,
    'strMeasure17': strMeasure17,
    'strMeasure18': strMeasure18,
    'strMeasure19': strMeasure19,
    'strMeasure20': strMeasure20,
    'strSource': strSource,
    'strImageSource': strImageSource,
    'strCreativeCommonsConfirmed': strCreativeCommonsConfirmed,
    'dateModified': dateModified,
  };

  @override
  List<Object?> get props {
    return [
      idMeal,
      strMeal,
      strMealAlternate,
      strCategory,
      strArea,
      strInstructions,
      strMealThumb,
      strTags,
      strYoutube,
      strIngredient1,
      strIngredient2,
      strIngredient3,
      strIngredient4,
      strIngredient5,
      strIngredient6,
      strIngredient7,
      strIngredient8,
      strIngredient9,
      strIngredient10,
      strIngredient11,
      strIngredient12,
      strIngredient13,
      strIngredient14,
      strIngredient15,
      strIngredient16,
      strIngredient17,
      strIngredient18,
      strIngredient19,
      strIngredient20,
      strMeasure1,
      strMeasure2,
      strMeasure3,
      strMeasure4,
      strMeasure5,
      strMeasure6,
      strMeasure7,
      strMeasure8,
      strMeasure9,
      strMeasure10,
      strMeasure11,
      strMeasure12,
      strMeasure13,
      strMeasure14,
      strMeasure15,
      strMeasure16,
      strMeasure17,
      strMeasure18,
      strMeasure19,
      strMeasure20,
      strSource,
      strImageSource,
      strCreativeCommonsConfirmed,
      dateModified,
    ];
  }
}

extension MealExtension on Meal {
  List<String> getIngredients() {
    return [
      strIngredient1,
      strIngredient2,
      strIngredient3,
      strIngredient4,
      strIngredient5,
      strIngredient6,
      strIngredient7,
      strIngredient8,
      strIngredient9,
      strIngredient10,
      strIngredient11,
      strIngredient12,
      strIngredient13,
      strIngredient14,
      strIngredient15,
      strIngredient16,
      strIngredient17,
      strIngredient18,
      strIngredient19,
      strIngredient20,
    ].where((item) => item != null && item.isNotEmpty).map((e) => e!).toList();
  }

  List<String> getMeasures() {
    return [
      strMeasure1,
      strMeasure2,
      strMeasure3,
      strMeasure4,
      strMeasure5,
      strMeasure6,
      strMeasure7,
      strMeasure8,
      strMeasure9,
      strMeasure10,
      strMeasure11,
      strMeasure12,
      strMeasure13,
      strMeasure14,
      strMeasure15,
      strMeasure16,
      strMeasure17,
      strMeasure18,
      strMeasure19,
      strMeasure20,
    ].where((item) => item != null && item.isNotEmpty).map((e) => e!).toList();
  }
}

/*
extension MealExtensions on Meal {
  List<Map<String, String>> get ingredientsWithMeasures {
    final ingredients = <Map<String, String>>[];

    for (int i = 1; i <= 20; i++) {
      final ingredient = this.toJson()['strIngredient$i'];
      final measure = this.toJson()['strMeasure$i'];

      if (ingredient != null &&
          ingredient.toString().trim().isNotEmpty &&
          ingredient.toString().toLowerCase() != "null") {
        ingredients.add({
          'ingredient': ingredient.toString(),
          'measure': measure?.toString() ?? '',
        });
      }
    }

    return ingredients;
  }
}
*/

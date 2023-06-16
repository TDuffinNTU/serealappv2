import 'package:freezed_annotation/freezed_annotation.dart';

part 'meal.freezed.dart';
part 'meal.g.dart';

@freezed
class Meal with _$Meal {
  const factory Meal({
    required bool complete,
    required String name,
    required String? note,
  }) = _Meal;

  factory Meal.fromJson(Map<String, dynamic> json) => _$MealFromJson(json);

  factory Meal.defaults(String name) => Meal(
        complete: false,
        name: name,
        note: '',
      );
}

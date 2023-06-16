class Meal {
  const Meal({
    required this.complete,
    required this.name,
    required this.note,
  });

  static Meal create(String name) => Meal(
        complete: false,
        name: name,
        note: '',
      );

  final bool complete;
  final String name;
  final String? note;
}

class Todo {
  const Todo({
    required this.name,
    required this.complete,
  });

  static Todo create(String name) => Todo(
        complete: false,
        name: name,
      );

  final String name;
  final bool complete;
}

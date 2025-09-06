import 'package:objectbox/objectbox.dart';

@Entity()
class SerealTheme {
  SerealTheme({
    this.id = 0,
    this.isDark = false,
    required this.seedColor,
  });

  @Id()
  int id;

  bool isDark;
  int seedColor;
}

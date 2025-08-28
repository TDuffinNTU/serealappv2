import 'package:objectbox/objectbox.dart';

@Entity()
class SerealTheme {
  SerealTheme({
    this.isDark = false,
    required this.seedColor,
  });

  @Id()
  int id = 1;

  bool isDark;
  int seedColor;
}

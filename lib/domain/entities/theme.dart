import 'package:objectbox/objectbox.dart';

@Entity()
class Theme {
  Theme({
    this.isDark = false,
    required this.seedColor,
  });

  @Id()
  int id = 0;

  bool isDark;
  int seedColor;
}

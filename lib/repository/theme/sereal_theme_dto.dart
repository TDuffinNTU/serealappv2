import 'package:objectbox/objectbox.dart';

@Entity()
class SerealThemeDto {
  SerealThemeDto({
    required this.color,
    required this.mode,
    this.id = 1,
  });

  @Id()
  int id = 1;

  final int color;
  final int mode;

  @override
  String toString() {
    return 'SerealThemeDto: {Color: $color, ThemeMode: $mode}';
  }
}

import 'package:flutter/widgets.dart';
import 'package:serealappv2/repository/theme/theme_dto.dart' as dto;
import 'package:serealappv2/services/theme/sereal_theme_model.dart' as model;
import 'package:serealappv2/utils/brightness_extensions.dart';

dto.SerealTheme toDto(model.SerealTheme m) => dto.SerealTheme(
      seedColor: m.seedColor.toARGB32(),
      isDark: m.brightness.isDark,
    );

model.SerealTheme fromDto(dto.SerealTheme d) => model.SerealTheme(
      seedColor: Color(d.seedColor),
      brightness: d.isDark ? Brightness.dark : Brightness.light,
    );

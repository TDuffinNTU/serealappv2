import 'package:flutter/material.dart';

class SerealScaffold extends StatelessWidget {
  const SerealScaffold({
    super.key,
    required this.appBarActions,
    required this.title,
    required this.body,
    this.bottomNavigationBar,
  });

  final List<Widget>? appBarActions;
  final Widget? bottomNavigationBar;
  final String title;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        actions: appBarActions == null ? null : appBarActions!,
        title: Text(title),
      ),
      body: body,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}

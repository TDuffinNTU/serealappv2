import 'package:flutter/material.dart';

class SerealScaffold extends StatelessWidget {
  const SerealScaffold({
    super.key,
    required this.appBarAction,
    required this.title,
    required this.body,
    this.bottomNavigationBar,
  });

  final Widget? appBarAction;
  final Widget? bottomNavigationBar;
  final String title;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: appBarAction == null ? null : [appBarAction!],
        title: Text(title),
      ),
      body: body,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}

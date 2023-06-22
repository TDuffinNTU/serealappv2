import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SerealNavigationBar extends StatefulWidget {
  const SerealNavigationBar({
    super.key,
    required this.onTabSelected,
    required this.initialTab,
  });

  final Function(int) onTabSelected;
  final int initialTab;

  @override
  State<SerealNavigationBar> createState() => _SerealNavigationBarState();
}

class _SerealNavigationBarState extends State<SerealNavigationBar> {
  int selectedTab = 0;

  void selectTab(int tab) {
    widget.onTabSelected(tab);
    setState(() {
      selectedTab = tab;
    });
  }

  @override
  void initState() {
    super.initState();
    selectedTab = widget.initialTab;
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          label: 'Notes',
          icon: Icon(Icons.sticky_note_2),
        ),
        BottomNavigationBarItem(
          label: 'Today',
          icon: Icon(Icons.calendar_month),
        ),
        BottomNavigationBarItem(
          label: 'History',
          icon: Icon(Icons.history),
        ),
      ],
      onTap: selectTab,
      currentIndex: selectedTab,
    );
  }
}

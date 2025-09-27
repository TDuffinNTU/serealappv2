import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SerealNavigationBar extends StatefulWidget {
  const SerealNavigationBar({
    required this.onTabSelected,
    required this.initialTab,
    super.key,
  });

  final void Function(int) onTabSelected;
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
    return AnnotatedRegion<SystemUiOverlayStyle>(
      // Makes the bottom nav bar transparent so we dont have to see its ugly face.
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.black.withValues(alpha: 0),
      ),
      child: NavigationBar(
        destinations: const [
          NavigationDestination(
            label: 'Notes',
            icon: Icon(Icons.sticky_note_2),
          ),
          NavigationDestination(
            label: 'Today',
            icon: Icon(Icons.calendar_month),
          ),
          NavigationDestination(
            label: 'History',
            icon: Icon(Icons.history),
          ),
        ],
        onDestinationSelected: selectTab,
        selectedIndex: selectedTab,
      ),
    );
  }
}

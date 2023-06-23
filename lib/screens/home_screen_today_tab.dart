import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

class HomeScreenTodayTab extends StatelessWidget {
  const HomeScreenTodayTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FlutterCarousel(
        items: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Placeholder(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Placeholder(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Placeholder(),
          )
        ],
        options: CarouselOptions(
          initialPage: 1,
          enlargeCenterPage: true,
          floatingIndicator: false,
          slideIndicator: CircularSlideIndicator(
            // TODO pick better colours?
            currentIndicatorColor: Theme.of(context).primaryColorDark,
            indicatorBackgroundColor: Theme.of(context).primaryColorLight,
          ),
        ),
      ),
    );
  }
}

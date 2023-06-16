import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:jiffy/jiffy.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sereal',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepPurple,
      ),
      darkTheme: ThemeData.dark(
        useMaterial3: true,
      ),
      themeMode: ThemeMode.light,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  DateTime selectedDate = DateTime.now();
  int todayIndex = 2;
  List<String> pages = ['0', '1', Jiffy.now().MMMMEEEEd, '3', '4'];
  CarouselController controller = CarouselController();

  void moveToDate(int index) {
    setState(() {
      selectedDate = Jiffy.now().add(days: index - todayIndex).dateTime;
      if (index == 0) addAtStart();
    });
  }

  Future<void> addAtStart() async {
    await Future.delayed(const Duration(milliseconds: 300));
    todayIndex++;
    pages = [Jiffy.now().add(days: -todayIndex).MMMMEEEEd, ...pages];
    controller.jumpToPage(1);
  }

  void addAtEnd() {
    setState(() {
      pages.add(Jiffy.now().add(days: pages.length - todayIndex).MMMMEEEEd);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: Text(widget.title),
        actions: [
          IconButton(
            // TODO toggle theme.
            onPressed: () {},
            icon: const Icon(
              Icons.wb_sunny_outlined,
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              Jiffy.parseFromDateTime(selectedDate)
                      .isSame(Jiffy.now(), unit: Unit.day)
                  ? 'Today'
                  : Jiffy.parseFromDateTime(selectedDate).MMMMEEEEd,
            ),
            FlutterCarousel(
              items: List.generate(
                  pages.length,
                  (index) => Padding(
                        padding: const EdgeInsets.all(16),
                        child: Card(
                          child: Center(
                            child: Text(
                              pages[index],
                            ),
                          ),
                        ),
                      )),
              options: CarouselOptions(
                initialPage: todayIndex,
                onPageChanged: (index, _) => moveToDate(index),
                enlargeStrategy: CenterPageEnlargeStrategy.scale,
                controller: controller,
                showIndicator: false,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addAtEnd,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

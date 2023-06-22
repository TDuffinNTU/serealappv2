import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serealappv2/screens/home_screen.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sereal',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blueAccent,
      ),
      darkTheme: ThemeData.dark(
        useMaterial3: true,
      ),
      themeMode: ThemeMode.light,
      home: const HomeScreen(),
    );
  }
}

// class MyHomePage extends ConsumerStatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   ConsumerState<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends ConsumerState<MyHomePage> {
//   int? index;

//   Future<void> addRecord() async {
//     // today's index
//     int index = ref.read(logsServiceProvider.notifier).todayIndex!;

//     // create log
//     DailyLog newLog = DailyLog.defaults(
//       date: DateTime.now().add(
//         Duration(
//             days: index +
//                 ref
//                     .read(logsServiceProvider)
//                     .whenData((value) => value.length)
//                     .value!),
//       ),
//     );

//     ref.read(logsServiceProvider.notifier).createOrUpdateLog(newLog);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final logsAsync = ref.watch(logsServiceProvider);
//     final logsNotifier = ref.read(logsServiceProvider.notifier);

//     return Scaffold(
//       drawer: Drawer(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               TextButton(
//                 child: Text('Clear database'),
//                 onPressed: () {
//                   logsNotifier.clearAllLogs();
//                   index = null;
//                   ref.invalidate(logsServiceProvider);
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//       appBar: AppBar(
//         elevation: 10,
//         title: Text(widget.title),
//         actions: [
//           IconButton(
//             // TODO toggle theme.
//             onPressed: () {},
//             icon: const Icon(
//               Icons.wb_sunny_outlined,
//             ),
//           )
//         ],
//       ),
//       body: Center(
//         child: logsAsync.when(
//           error: (error, stacktrace) => Text(
//             'ERROR: ${error}, ${stacktrace}',
//           ),
//           loading: () => SpinKitRotatingCircle(
//             color: Colors.deepPurpleAccent,
//           ),
//           data: (logs) => Column(
//             children: [
//               Text(logs[index ?? logsNotifier.todayIndex ?? 0].id),
//               FlutterCarousel(
//                 items: List.generate(
//                   logs.length,
//                   (i) => Card(
//                     child: Text(
//                       logs[i].date.toString(),
//                     ),
//                   ),
//                 ),
//                 options: CarouselOptions(
//                   initialPage: logsNotifier.todayIndex ?? 0,
//                   onPageChanged: (newIndex, _) =>
//                       setState(() => index = newIndex),
//                   enlargeStrategy: CenterPageEnlargeStrategy.scale,
//                   showIndicator: false,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: !ref.watch(logsServiceProvider).isLoading ? addRecord : null,
//         tooltip: 'Add',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

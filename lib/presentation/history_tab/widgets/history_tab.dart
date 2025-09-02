// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:serealappv2/presentation/theme/utils/sizing.dart' as sizing;
// import 'package:serealappv2/presentation/common/widgets/tonal_button_danger.dart';

// class HistoryTab extends ConsumerWidget {
//   const HistoryTab({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: sizing.screenPadding),
//       child: Center(
//         child: ref.watch(filteredLogsProvider(filter: null)).when(
//               data: (data) => ListView(
//                   padding: EdgeInsets.symmetric(vertical: sizing.screenPadding),
//                   children: [
//                     Align(
//                       alignment: Alignment.topLeft,
//                       child: TonalButtonDanger(
//                         onPressed: () => ref.read(databaseClearRecordsProvider),
//                         icon: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           spacing: sizing.s,
//                           children: [
//                             Icon(Icons.delete_forever_outlined),
//                             Text('Delete all'),
//                           ],
//                         ),
//                       ),
//                     ),
//                     ...data.map(
//                       (log) => Card(
//                         child: Padding(
//                           padding: EdgeInsets.all(sizing.s),
//                           child: Column(
//                             spacing: sizing.s,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Align(
//                                 alignment: Alignment.topRight,
//                                 child: TonalButtonDanger(
//                                   onPressed: () =>
//                                       ref.read(databaseDeleteRecordProvider(id: log.id)),
//                                   icon: Icon(Icons.delete_outline),
//                                 ),
//                               ),
//                               Text(log.id),
//                               Text(log.date.toString()),
//                               Text(log.meals.toString()),
//                               Text(log.snacks.toString()),
//                               Text(log.todos.toString()),
//                               Text(log.note.toString()),
//                             ],
//                           ),
//                         ),
//                       ),
//                     )
//                   ]),
//               error: (Object error, StackTrace stackTrace) => null,
//               loading: () => CircularProgressIndicator(),
//             ),
//       ),
//     );
//   }
// }

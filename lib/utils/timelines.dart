// // Flutter Packages
// import 'package:json_diff/json_diff.dart';

// // JSON DIFF
// Map<String, dynamic> computeTimelineChanges(
//   Map<String, dynamic> oldJson,
//   Map<String, dynamic> newJson,
// ) {
//   final differ = JsonDiffer.fromJson(oldJson, newJson);

//   DiffNode diff = differ.diff();

//   Map<String, dynamic> differences = {};

//   differences.addAll(computeDiffNode(diff));

//   return differences;
// }

// Map<String, dynamic> computeDiffNode(DiffNode diff) {
//   Map<String, dynamic> differences = {};
//   //
//   List<Object?> added = [], removed = [];

//   // For Maps (Dict, JSON, whatever you wanna call it), they dont change the fields
//   diff.forEachChanged(
//     (key, value) {
//       // If the Same number of added items is equals to the removed items
//       // Like Added 3 and Removed 3 from an array of lenght 3 it would count here as Changed
//       // Not Removed 3 and Added 3. That is unwanted behavior (I guess?, maybe?, for now?)
//       if (key is int) {
//         if (value.last != null) added.add(value.last);
//         if (value.first != null) removed.add(value.first);
//       }

//       if (key is String) {
//         differences.addAll({
//           key: {
//             "__old": value.first,
//             "__new": value.last,
//           }
//         });
//       }
//     },
//   );

//   // For List -> Added
//   if (diff.hasAdded) {
//     diff.added.forEach((key, value) => value != null ? added.add(value) : null);
//   }
//   // For List -> Removed
//   if (diff.hasRemoved) {
//     diff.removed.forEach((key, value) => value != null ? removed.add(value) : null);
//   }

//   if (added.isNotEmpty) differences.addAll({"added": added});
//   if (removed.isNotEmpty) differences.addAll({"removed": removed});

//   // Recursive
//   diff.node.forEach((key, value) {
//     differences.addAll({"$key": computeDiffNode(value)});
//   });

//   return differences;
// }

// List refactorToMatchFront(Map<String, dynamic> objectArray) {
//   List refactored = [];

//   objectArray["added"]?.forEach((value) => refactored.add(["+", value]));
//   objectArray["removed"]?.forEach((value) => refactored.add(["-", value]));

//   return refactored;
// }

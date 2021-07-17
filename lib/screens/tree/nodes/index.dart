import 'package:capturing/store.dart';
import 'package:capturing/screens/tree/nodes/editing.dart';
import 'package:capturing/screens/tree/nodes/nonEditing.dart';

// TODO:
// if editingStructure:
// add to table:
// - rows
// - fields
// and add fields

List<Map> buildNodes() {
  if (editingStructure) return buildNodesEditing();
  return buildNodesNonEditing();
}

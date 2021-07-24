import 'package:capturing/store.dart';
import 'package:capturing/screens/tree/nodes/editing.dart';
import 'package:capturing/screens/tree/nodes/nonEditing.dart';

List<Map> buildNodes() {
  if (editingStructure) return buildNodesEditing();
  return buildNodesNonEditing();
}

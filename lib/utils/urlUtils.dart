import 'package:validators/validators.dart' as validator;

bool isFieldsUrl(List<String> url) {
  if (!url.contains('/fields/')) return false;

  int lastFieldsFolderIndex = url.lastIndexOf('/fields/');
  int childIndex = lastFieldsFolderIndex + 1;
  bool hasChild = url.length > childIndex;
  String? child = hasChild ? url[childIndex] : null;
  bool hasUuidChild = child != null ? validator.isUUID(child) : false;
  if (hasUuidChild) return true;
  return false;
}

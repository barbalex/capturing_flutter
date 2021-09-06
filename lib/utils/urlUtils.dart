import 'package:validators/validators.dart' as validator;
import 'package:capturing/models/store.dart';
import 'package:isar/isar.dart';
import 'package:capturing/isar.g.dart';
import 'package:get/get.dart';

bool isFieldsUrl(List<String>? url) {
  if (url == null) return false;
  if (!url.contains('/fields/')) return false;

  int lastFieldsFolderIndex = url.lastIndexOf('/fields/');
  int childIndex = lastFieldsFolderIndex + 1;
  bool hasChild = url.length > childIndex;
  String? child = hasChild ? url[childIndex] : null;
  bool hasUuidChild = child != null ? validator.isUUID(child) : false;
  if (hasUuidChild) return true;
  return false;
}

void persistUrl(List<String> url) async {
  final Isar isar = Get.find<Isar>();
  // write url to isar
  Store? store;
  try {
    store = await isar.stores.get(1);
  } catch (e) {
    print(e);
  }
  if (store != null && store.url != url) {
    await isar.writeTxn((_) async {
      store?.url = url;
      await isar.stores.put(store as Store);
    });
  }
}

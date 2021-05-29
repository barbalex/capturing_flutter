List<String>? pgArrayToListOfStrings(dynamic val) {
  // Somehow tables.label_fields seems to arrive as one of two versions:
  // 1. a String '{val}'
  // 2. an array ['val']
  // I have NO IDEA why. And why revisions seem to behave differently...
  if (val == null) return null;
  var returnValue;
  try {
    returnValue = List<String>.from(val);
  } catch (e) {
    try {
      val.replaceAll('{', '');
      val.replaceAll('}', '');
      returnValue = val.split(',');
    } catch (e) {}
  }
  return returnValue;
}

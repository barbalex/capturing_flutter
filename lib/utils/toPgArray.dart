String? toPgArray(List? array) {
  if (array == null) return null;
  return '{${array.join(',')}}';
}

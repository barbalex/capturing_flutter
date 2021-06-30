import 'package:intl/intl.dart';
import 'package:proj4dart/proj4dart.dart' as proj4;
import 'package:proj4dart/proj4dart.dart';

Point transform4326To2056({
  required double lat,
  required double lng,
}) {
  proj4.Projection projection2056 =
      proj4.Projection.get('EPSG:2056') as proj4.Projection;
  var point4326 = proj4.Point(x: lng, y: lat);
  var proj4326 = proj4.Projection.get('EPSG:4326')!;
  var point2056 = proj4326.transform(projection2056, point4326);
  return point2056;
}

Point transform4326To5243({
  required double lat,
  required double lng,
}) {
  proj4.Projection projection5243 =
      proj4.Projection.get('EPSG:5243') as proj4.Projection;
  var point4326 = proj4.Point(x: lng, y: lat);
  var proj4326 = proj4.Projection.get('EPSG:4326')!;
  var point5243 = proj4326.transform(projection5243, point4326);
  return point5243;
}

String locationByCrs({
  required double lat,
  required double lng,
  String? crs,
}) {
  switch (crs) {
    case '2056':
      return location2056(lat: lat, lng: lng);
    case '5243':
      return location5243(lat: lat, lng: lng);
    default:
      return location4326(lat: lat, lng: lng);
  }
}

String location4326({
  required double lat,
  required double lng,
}) {
  return '${lat.toStringAsFixed(5)} / ${lng.toStringAsFixed(5)}';
}

String location2056({
  required double lat,
  required double lng,
}) {
  proj4.Point p = transform4326To2056(lat: lat, lng: lng);
  return '${NumberFormat.decimalPattern('de_CH').format(p.x.toInt())} / ${NumberFormat.decimalPattern('de_CH').format(p.y.toInt())}';
}

String location5243({
  required double lat,
  required double lng,
}) {
  proj4.Point p = transform4326To5243(lat: lat, lng: lng);
  return '${NumberFormat.decimalPattern('de').format(p.x.toInt())} / ${NumberFormat.decimalPattern('de').format(p.y.toInt())}';
}

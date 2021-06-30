import 'package:intl/intl.dart';
import 'package:proj4dart/proj4dart.dart' as proj4;
import 'package:proj4dart/proj4dart.dart';

Point transform4326To2056({
  required double lat,
  required double lng,
}) {
  proj4.Projection projection2056 = proj4.Projection.add(
    'EPSG:2056',
    '+proj=somerc +lat_0=46.95240555555556 +lon_0=7.439583333333333 +k_0=1 +x_0=2600000 +y_0=1200000 +ellps=bessel +towgs84=674.374,15.056,405.346,0,0,0,0 +units=m +no_defs',
  );
  var point4326 = proj4.Point(x: lng, y: lat);
  var proj4326 = proj4.Projection.get('EPSG:4326')!;
  var point2056 = proj4326.transform(projection2056, point4326);
  return point2056;
}

String location4326({
  required double lat,
  required double lng,
}) {
  proj4.Point p = transform4326To2056(lat: lat, lng: lng);
  return '${lat.toStringAsFixed(5)}, ${lng.toStringAsFixed(5)}';
}

String location2056({
  required double lat,
  required double lng,
}) {
  proj4.Point p = transform4326To2056(lat: lat, lng: lng);
  return '${p.x.toInt()}, ${NumberFormat.decimalPattern('gsw').format(p.y.toInt())}';
}

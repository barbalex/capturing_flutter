import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class PopupWidget extends StatefulWidget {
  final Marker marker;

  PopupWidget(this.marker, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PopupWidgetState(marker);
}

class _PopupWidgetState extends State<PopupWidget> {
  final Marker _marker;

  final List<IconData> _icons = [
    Icons.star_border,
    Icons.star_half,
    Icons.star
  ];
  int _currentIcon = 0;

  _PopupWidgetState(this._marker);

  @override
  Widget build(BuildContext context) {
    print('popup rendering, marker: $_marker');
    return Card(
      child: InkWell(
        onTap: () => setState(() {
          _currentIcon = (_currentIcon + 1) % _icons.length;
        }),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 20, right: 10),
              child: Icon(_icons[_currentIcon]),
            ),
            _cardDescription(context),
          ],
        ),
      ),
    );
  }

  Widget _cardDescription(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      // TODO:
      // from point coordinates fetch row
      // and present it
      // including a link to it's form
      child: Container(
        constraints: BoxConstraints(minWidth: 100, maxWidth: 200),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Popup for a marker!',
              overflow: TextOverflow.fade,
              softWrap: false,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14.0,
              ),
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 4.0)),
            Text(
              'Position: ${_marker.point.latitude}, ${_marker.point.longitude}',
              style: TextStyle(fontSize: 12.0),
            ),
            Text(
              'Marker size: ${_marker.width}, ${_marker.height}',
              style: TextStyle(fontSize: 12.0),
            ),
          ],
        ),
      ),
    );
  }
}

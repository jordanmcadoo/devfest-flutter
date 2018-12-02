// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'custom_theme.dart' as Theme;
import 'not_hotdog.dart' as HotdogApp;

const double _kMinFlingVelocity = 800.0;

class Photo {
  Photo({
    this.assetName,
    this.title,
  });

  final String assetName;
  final String title;

  String get tag => assetName; // Assuming that all asset names are unique.

  bool get isValid => assetName != null && title != null;
}

class GridPhotoViewer extends StatefulWidget {
  const GridPhotoViewer({ Key key, this.photo }) : super(key: key);

  final Photo photo;

  @override
  _GridPhotoViewerState createState() => _GridPhotoViewerState();
}

class _GridTitleText extends StatelessWidget {
  const _GridTitleText(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.centerLeft,
      child: Text(text),
    );
  }
}

class _GridPhotoViewerState extends State<GridPhotoViewer> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _flingAnimation;
  Offset _offset = Offset.zero;
  double _scale = 1.0;
  Offset _normalizedOffset;
  double _previousScale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this)
      ..addListener(_handleFlingAnimation);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // The maximum offset value is 0,0. If the size of this renderer's box is w,h
  // then the minimum offset value is w - _scale * w, h - _scale * h.
  Offset _clampOffset(Offset offset) {
    final Size size = context.size;
    final Offset minOffset = Offset(size.width, size.height) * (1.0 - _scale);
    return Offset(offset.dx.clamp(minOffset.dx, 0.0), offset.dy.clamp(minOffset.dy, 0.0));
  }

  void _handleFlingAnimation() {
    setState(() {
      _offset = _flingAnimation.value;
    });
  }

  void _handleOnScaleStart(ScaleStartDetails details) {
    setState(() {
      _previousScale = _scale;
      _normalizedOffset = (details.focalPoint - _offset) / _scale;
      // The fling animation stops if an input gesture starts.
      _controller.stop();
    });
  }

  void _handleOnScaleUpdate(ScaleUpdateDetails details) {
    setState(() {
      _scale = (_previousScale * details.scale).clamp(1.0, 4.0);
      // Ensure that image location under the focal point stays in the same place despite scaling.
      _offset = _clampOffset(details.focalPoint - _normalizedOffset * _scale);
    });
  }

  void _handleOnScaleEnd(ScaleEndDetails details) {
    final double magnitude = details.velocity.pixelsPerSecond.distance;
    if (magnitude < _kMinFlingVelocity)
      return;
    final Offset direction = details.velocity.pixelsPerSecond / magnitude;
    final double distance = (Offset.zero & context.size).shortestSide;
    _flingAnimation = _controller.drive(Tween<Offset>(
        begin: _offset,
        end: _clampOffset(_offset + direction * distance)
    ));
    _controller
      ..value = 0.0
      ..fling(velocity: magnitude / 1000.0);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onScaleStart: _handleOnScaleStart,
      onScaleUpdate: _handleOnScaleUpdate,
      onScaleEnd: _handleOnScaleEnd,
      child: ClipRect(
        child: Transform(
          transform: Matrix4.identity()
            ..translate(_offset.dx, _offset.dy)
            ..scale(_scale),
          child: Image.asset(
            widget.photo.assetName,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class GridDemoPhotoItem extends StatelessWidget {
  GridDemoPhotoItem({
    Key key,
    @required this.photo,
  }) : assert(photo != null && photo.isValid),
        super(key: key);

  final Photo photo;
// MARK - when photo tapped
  void showPhoto(BuildContext context) {
    Navigator.push(context, MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return HotdogApp.NotHotdog();
        }
    ));
  }

  @override
  Widget build(BuildContext context) {
    final Widget image = GestureDetector(
        onTap: () { showPhoto(context); },
        child: Hero(
            key: Key(photo.assetName),
            tag: photo.tag,
            child: Image.asset(
              photo.assetName,
              fit: BoxFit.cover,
            )
        )
    );
    return GridTile(
      footer: GestureDetector(
        onTap: () { showPhoto(context); },
        child: GridTileBar(
          backgroundColor: Colors.black45,
          title: _GridTitleText(photo.title),
        ),
      ),
      child: image,
    );
  }
}

class GridListDemo extends StatefulWidget {
  const GridListDemo({ Key key }) : super(key: key);

  static const String routeName = '/material/grid-list';

  @override
  GridListDemoState createState() => GridListDemoState();
}

class GridListDemoState extends State<GridListDemo> {
  List<Photo> photos = <Photo>[
    Photo(
      assetName: 'assets/nothotdog.png',
      title: 'Not Hotdog',
    ),
    Photo(
      assetName: 'assets/stars.png',
      title: 'Star Map',
    ),
    Photo(
      assetName: 'assets/phone.png',
      title: 'call me, maybe?',
    ),
    Photo(
      assetName: 'assets/potion.png',
      title: 'Potion Recipes',
    ),
    Photo(
      assetName: 'assets/meow.png',
      title: 'meow',
    ),
    Photo(
      assetName: 'assets/notjackie.png',
      title: 'Not Jackie Chan',
    ),
    Photo(
      assetName: 'assets/spellbook.png',
      title: 'Spellbook',
    ),
    Photo(
      assetName: 'assets/witchhat.png',
      title: 'idk',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      backgroundColor: Theme.CustomColors.lightPink[500],
      body: Column(
        children: <Widget>[
          Expanded(
            child: SafeArea(
              top: false,
              bottom: false,
              child: GridView.count(
                crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 20.0,
                padding: const EdgeInsets.all(20.0),
                childAspectRatio: (orientation == Orientation.portrait) ? 1.0 : 1.3,
                children: photos.map<Widget>((Photo photo) {
                  return GridDemoPhotoItem(
                      photo: photo,
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
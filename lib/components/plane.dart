import 'dart:ui';

import 'package:box2d_flame/box2d.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_tap_plane/flame/custom-body-component.dart';

import '../utils.dart';

class Plane extends CustomBodyComponent {
  static const VELOCITY = 30.0;
  static const SPRITE_WIDTH = 88;
  static const SPRITE_HEIGHT = 73;

  ImagesLoader images = new ImagesLoader();
  double height;
  double width;

  Plane(box2d) : super(box2d) {
    _loadImages();

    height = tileSize;
    width = SPRITE_WIDTH * height / SPRITE_HEIGHT;

    final shape = new CircleShape();
    shape.radius = height / 2;
    final fixtureDef = new FixtureDef();
    fixtureDef.shape = shape;
    fixtureDef.restitution = 0.0;
    fixtureDef.friction = 0.01;
    fixtureDef.density = 0.03;

    final bodyDef = new BodyDef();
    bodyDef.position = new Vector2(-(viewport.width / 4), 0);
    bodyDef.bullet = true;
    bodyDef.type = BodyType.DYNAMIC;

    this.body = world.createBody(bodyDef)
      ..createFixtureFromFixtureDef(fixtureDef);
  }

  void _loadImages() {
    images.load('plane-1', 'plane/plane-1.png');
    images.load('plane-2', 'plane/plane-2.png');
    images.load('plane-3', 'plane/plane-3.png');
  }

  void onTap() {
    Vector2 force = new Vector2(0, VELOCITY)..scale(175);
    body.applyLinearImpulse(force, center, true);
  }

  @override
  void update(double t) {
  }

  @override
  void renderCircle(Canvas canvas, Offset center, double radius) {
    if (images.isLoading) return;

    paintImage(
      canvas: canvas,
      rect: new Rect.fromCircle(center: center, radius: radius),
      image: images.get('plane-1'),
      fit: BoxFit.fill,
    );
  }
}
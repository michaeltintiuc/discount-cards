import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:discount_cards/models/layout_type.dart';

Box<T> getBox<T>(String name) => Hive.box<T>(name);

IconData getFavIcon(bool? isFav) =>
    isFav == true ? Icons.favorite : Icons.favorite_outline;

int bool2int(bool? b) => b == true ? 1 : 0;

const _orientationSizes = {
  Orientation.portrait: {
    LayoutType.grid: 2,
    LayoutType.smallGrid: 5,
    LayoutType.list: 16,
  },
  Orientation.landscape: {
    LayoutType.grid: 4,
    LayoutType.smallGrid: 10,
    LayoutType.list: 32,
  }
};

double layoutThumbnailSize(BuildContext context, LayoutType layout) {
  final mediaQueryData = MediaQuery.of(context);
  final screenWidth =
      mediaQueryData.size.width * mediaQueryData.devicePixelRatio;

  final size = _orientationSizes[mediaQueryData.orientation]?[layout];
  return size != null ? screenWidth / size : 0;
}

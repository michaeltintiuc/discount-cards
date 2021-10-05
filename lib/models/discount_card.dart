import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:discount_cards/routes.dart';
import 'package:discount_cards/models/layout_type.dart';

part 'discount_card.g.dart';

@HiveType(typeId: 1)
class DiscountCard extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final List<String> _images;

  @HiveField(2)
  bool _isFavorite;

  @HiveField(3)
  final Map<LayoutType, String> _thumbnails;

  DiscountCard(
    this.name,
    this._images,
    this._isFavorite,
    this._thumbnails,
  );

  static const boxName = 'discount_cards';

  static Box<DiscountCard> getBox() =>
      Hive.box<DiscountCard>(DiscountCard.boxName);

  List<String> get images => _images;
  bool get isFavorite => _isFavorite;
  String get listThumbnail => _thumbnails[LayoutType.list]!;
  String get gridThumbnail => _thumbnails[LayoutType.grid]!;

  Future<void> toggleFavorite() {
    _isFavorite = !_isFavorite;
    return save();
  }

  static void toCreateRoute(BuildContext context) =>
      Navigator.pushNamed(context, '/create');

  void toViewRoute(BuildContext context) =>
      Navigator.pushNamed(context, '/view', arguments: RouteArguments(this));

  void toEditRoute(BuildContext context) =>
      Navigator.pushNamed(context, '/edit', arguments: RouteArguments(this));

  @override
  Future<List<FileSystemEntity>> delete() {
    super.delete();
    return cleanUp();
  }

  Future<List<FileSystemEntity>> cleanUp([List<String>? filter]) {
    final List<Future<FileSystemEntity>> deletes = [];
    (images + _thumbnails.values.toList()).forEach((image) {
      if (filter != null && filter.contains(image)) {
        return;
      }
      deletes.add(File(image).delete());
    });
    return Future.wait(deletes);
  }

  @override
  String toString() => name;
}

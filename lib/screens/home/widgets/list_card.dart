import 'dart:io';

import 'package:flutter/material.dart';

import 'package:discount_cards/screens/home/widgets/layout_card.dart';
import 'package:discount_cards/models/discount_card.dart';
import 'package:discount_cards/models/layout_type.dart';
import 'package:discount_cards/utils/index.dart';

class ListCard extends LayoutCard {
  final DiscountCard item;

  const ListCard(this.item) : super(item);

  Widget buildCard(context) {
    final size = layoutThumbnailSize(context, LayoutType.list);
    return Card(
        child: ListTile(
            contentPadding: const EdgeInsets.all(10),
            title: Text(item.name),
            leading: Container(
                width: size,
                height: size,
                child: FittedBox(
                    fit: BoxFit.cover,
                    clipBehavior: Clip.hardEdge,
                    child: Image.file(File(item.listThumbnail)))),
            trailing: IconButton(
                icon: Icon(getFavIcon(item.isFavorite), color: Colors.red),
                onPressed: () => item.toggleFavorite()),
            onTap: () => item.toViewRoute(context)));
  }
}

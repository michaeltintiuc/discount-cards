import 'dart:io';

import 'package:flutter/material.dart';

import 'package:discount_cards/screens/home/widgets/layout_card.dart';
import 'package:discount_cards/models/discount_card.dart';
import 'package:discount_cards/utils/index.dart';

class GridCard extends LayoutCard {
  final DiscountCard item;

  const GridCard(this.item) : super(item);

  Widget buildCard(context) => GridTile(
        key: ValueKey(item.key),
        header: GridTileBar(
          title: Text(item.name, style: TextStyle(color: Colors.black)),
          backgroundColor: Color.fromARGB(200, 255, 255, 255),
          leading: IconButton(
              icon: Icon(getFavIcon(item.isFavorite), color: Colors.red),
              onPressed: item.toggleFavorite),
        ),
        child: InkResponse(
            child: Card(
                child: FittedBox(
                    fit: BoxFit.cover,
                    child: Image.file(File(item.gridThumbnail)),
                    clipBehavior: Clip.hardEdge),
                margin: EdgeInsets.all(0)),
            onTap: () => item.toViewRoute(context)),
      );
}

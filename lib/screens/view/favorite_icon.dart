import 'package:flutter/material.dart';
import 'package:discount_cards/models/discount_card.dart';
import 'package:discount_cards/utils/index.dart';

class FavoriteIcon extends StatefulWidget {
  final DiscountCard item;
  const FavoriteIcon(this.item, {Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _FavoriteIconState();
}

class _FavoriteIconState extends State<FavoriteIcon> {
  late bool isFavorite;

  @override
  initState() {
    isFavorite = widget.item.isFavorite;
    super.initState();
  }

  @override
  Widget build(BuildContext context) => IconButton(
      icon: Icon(getFavIcon(isFavorite), color: Colors.red),
      onPressed: () {
        widget.item.toggleFavorite();
        setState(() => (isFavorite = widget.item.isFavorite));
      });
}

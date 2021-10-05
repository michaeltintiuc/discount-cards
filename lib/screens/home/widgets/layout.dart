import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:discount_cards/screens/home/widgets/list_card.dart';
import 'package:discount_cards/screens/home/widgets/grid_card.dart';
import 'package:discount_cards/screens/home/widgets/layout_card.dart';
import 'package:discount_cards/models/layout_type.dart';
import 'package:discount_cards/models/discount_card.dart';
import 'package:discount_cards/utils/index.dart';

class Layout extends StatelessWidget {
  final LayoutType layout;
  final String? search;

  Layout(this.layout, {Key? key, this.search}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      ValueListenableBuilder<Box<DiscountCard>>(
          valueListenable: DiscountCard.getBox().listenable(),
          builder: (context, box, widget) {
            if (box.isEmpty) {
              return const Center(child: const Text('No discount cards found'));
            }

            List<LayoutCard> cards = [];
            final boxSorted = (search != null
                    ? box.values.where((item) => item.name.contains(search!))
                    : box.values)
                .toList()
              ..sort((item1, item2) {
                var diff = bool2int(item2.isFavorite)
                    .compareTo(bool2int(item1.isFavorite));
                return diff == 0 ? item2.key.compareTo(item1.key) : diff;
              });

            if (layout == LayoutType.list) {
              boxSorted.forEach((item) => cards.add(ListCard(item)));
              return ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: cards.length,
                itemBuilder: (context, index) => cards[index],
              );
            } else if (layout == LayoutType.grid) {
              boxSorted.forEach((item) => cards.add(GridCard(item)));
              return GridView.builder(
                padding: const EdgeInsets.all(10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? 2
                          : 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: cards.length,
                itemBuilder: (context, index) => cards[index],
              );
            }

            return SizedBox.shrink();
          });
}

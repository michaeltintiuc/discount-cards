import 'package:flutter/material.dart';

import 'package:discount_cards/screens/home/widgets/layout.dart';
import 'package:discount_cards/screens/home/widgets/search_delegate.dart';
import 'package:discount_cards/models/discount_card.dart';
import 'package:discount_cards/models/layout_type.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  LayoutType _layout = LayoutType.list;

  get _layoutIcon {
    if (_layout == LayoutType.list) {
      return Icons.grid_view_rounded;
    } else if (_layout == LayoutType.grid) {
      return Icons.list;
    }
  }

  void _switchLayout() {
    setState(() {
      if (_layout == LayoutType.list) {
        _layout = LayoutType.grid;
      } else if (_layout == LayoutType.grid) {
        _layout = LayoutType.list;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Discount cards'), actions: [
        IconButton(
            icon: Icon(Icons.search),
            onPressed: () =>
                showSearch(context: context, delegate: HomeSearchDelegate())),
        IconButton(icon: Icon(_layoutIcon), onPressed: _switchLayout)
      ]),
      body: Layout(_layout),
      floatingActionButton: FloatingActionButton(
        onPressed: () => DiscountCard.toCreateRoute(context),
        tooltip: 'Create new',
        child: const Icon(Icons.add),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:discount_cards/screens/home/widgets/layout.dart';
import 'package:discount_cards/models/layout_type.dart';

class HomeSearchDelegate extends SearchDelegate {
  late Layout _cache;

  @override
  buildActions(BuildContext context) =>
      [IconButton(onPressed: () => query = '', icon: const Icon(Icons.clear))];

  @override
  buildLeading(BuildContext context) => IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back));

  @override
  buildResults(BuildContext context) => _cache;

  @override
  buildSuggestions(BuildContext context) =>
      _cache = Layout(LayoutType.list, search: query);
}

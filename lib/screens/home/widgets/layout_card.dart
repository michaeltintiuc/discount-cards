import 'package:flutter/material.dart';
import 'package:discount_cards/models/discount_card.dart';

abstract class LayoutCard extends StatelessWidget {
  final DiscountCard item;

  const LayoutCard(this.item) : super();

  Widget buildCard(BuildContext context);

  TextButton _buildAction(BuildContext context, String text, bool value) =>
      TextButton(
          onPressed: () => Navigator.of(context).pop(value),
          child: Text(text),
          style: TextButton.styleFrom(
              primary: value
                  ? Theme.of(context).colorScheme.error
                  : Theme.of(context).colorScheme.primary));

  @override
  Widget build(context) => Dismissible(
      key: ValueKey(item.key),
      onDismissed: (_) => item.delete(),
      background: Container(color: Colors.red),
      confirmDismiss: (dir) async => await showDialog(
          context: context,
          builder: (context) =>
              AlertDialog(title: Text('Delete ${item.name}?'), actions: [
                _buildAction(context, 'DELETE', true),
                _buildAction(context, 'CANCEL', false),
              ])),
      child: buildCard(context));
}

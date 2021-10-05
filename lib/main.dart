import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:discount_cards/screens/home/home.dart';
import 'package:discount_cards/screens/create/create.dart';
import 'package:discount_cards/screens/view/view.dart';

import 'package:discount_cards/models/discount_card.dart';
import 'package:discount_cards/models/layout_type.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(DiscountCardAdapter());
  Hive.registerAdapter(LayoutTypeAdapter());
  await Hive.openBox<DiscountCard>(DiscountCard.boxName);
  runApp(DiscountCardsApp());
}

class DiscountCardsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Discount Cards',
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        routes: {
          '/': (context) => Home(),
          '/create': (context) => Create(),
          '/edit': (context) => Create(),
          '/view': (context) => View(),
        });
  }
}

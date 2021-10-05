import 'package:hive/hive.dart';

part 'layout_type.g.dart';

@HiveType(typeId: 2)
enum LayoutType {
  @HiveField(0)
  grid,
  @HiveField(1)
  list,
  @HiveField(2)
  smallGrid,
}

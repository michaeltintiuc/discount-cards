// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'layout_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LayoutTypeAdapter extends TypeAdapter<LayoutType> {
  @override
  final int typeId = 2;

  @override
  LayoutType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return LayoutType.grid;
      case 1:
        return LayoutType.list;
      case 2:
        return LayoutType.smallGrid;
      default:
        return LayoutType.grid;
    }
  }

  @override
  void write(BinaryWriter writer, LayoutType obj) {
    switch (obj) {
      case LayoutType.grid:
        writer.writeByte(0);
        break;
      case LayoutType.list:
        writer.writeByte(1);
        break;
      case LayoutType.smallGrid:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LayoutTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

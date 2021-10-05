// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discount_card.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DiscountCardAdapter extends TypeAdapter<DiscountCard> {
  @override
  final int typeId = 1;

  @override
  DiscountCard read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DiscountCard(
      fields[0] as String,
      (fields[1] as List).cast<String>(),
      fields[2] as bool,
      (fields[3] as Map).cast<LayoutType, String>(),
    );
  }

  @override
  void write(BinaryWriter writer, DiscountCard obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj._images)
      ..writeByte(2)
      ..write(obj._isFavorite)
      ..writeByte(3)
      ..write(obj._thumbnails);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DiscountCardAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

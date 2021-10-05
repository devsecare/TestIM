part of 'cartbox.dart';

class CartAdapter extends TypeAdapter<CartBox> {
  @override
  CartBox read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CartBox(
      fields[0] as int,
      fields[1] as int,
      fields[2] as String,
      fields[3] as String,
      fields[4] as String,
      fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, CartBox obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.quntity)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.price)
      ..writeByte(4)
      ..write(obj.urlImage)
      ..writeByte(5)
      ..write(obj.sample);
  }

  @override
  int get typeId => 0;
}

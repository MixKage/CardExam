// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CardAdapter extends TypeAdapter<Card> {
  @override
  final int typeId = 2;

  @override
  Card read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Card(
      id: fields[0] as int,
      name: fields[1] as String,
      universe: fields[2] as String,
      direction: fields[3] as String,
      course: fields[4] as int,
      description: fields[5] as String,
      creatorId: fields[6] as int,
      rating: fields[7] as double,
      dateExam: fields[8] as DateTime,
      isVisible: fields[9] as bool,
      questionAnswers: (fields[10] as List).cast<QuestionAnswer>(),
    );
  }

  @override
  void write(BinaryWriter writer, Card obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.universe)
      ..writeByte(3)
      ..write(obj.direction)
      ..writeByte(4)
      ..write(obj.course)
      ..writeByte(5)
      ..write(obj.description)
      ..writeByte(6)
      ..write(obj.creatorId)
      ..writeByte(7)
      ..write(obj.rating)
      ..writeByte(8)
      ..write(obj.dateExam)
      ..writeByte(9)
      ..write(obj.isVisible)
      ..writeByte(10)
      ..write(obj.questionAnswers);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CardAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

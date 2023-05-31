// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'questionanswer.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuestionAnswerAdapter extends TypeAdapter<QuestionAnswer> {
  @override
  final int typeId = 1;

  @override
  QuestionAnswer read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuestionAnswer(
      id: fields[0] as int,
      question: fields[1] as String,
      answers: (fields[2] as List).cast<String>(),
      goodAnswersId: fields[3] == null ? -1 : fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, QuestionAnswer obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.question)
      ..writeByte(2)
      ..write(obj.answers)
      ..writeByte(3)
      ..write(obj.goodAnswersId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestionAnswerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

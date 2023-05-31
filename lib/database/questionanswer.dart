import 'package:hive_flutter/hive_flutter.dart';

part 'questionanswer.g.dart';

@HiveType(typeId: 1)
class QuestionAnswer {
  QuestionAnswer({
    required this.id,
    required this.question,
    required this.answers,
    required this.goodAnswersId,
  });

  @HiveField(0)
  late int id;

  @HiveField(1)
  late String question;

  @HiveField(2)
  late List<String> answers;

  @HiveField(3, defaultValue: -1)
  late int goodAnswersId;
}

import 'package:cardexam/database/questionanswer.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'card.g.dart';

@HiveType(typeId: 2)
class Card {
  Card({
    required this.id,
    required this.name,
    required this.universe,
    required this.direction,
    required this.course,
    required this.description,
    required this.creatorId,
    required this.rating,
    required this.dateExam,
    required this.isVisible,
    required this.questionAnswers,
  });
  // Id карточки
  @HiveField(0)
  int id;
  // Название карточки
  @HiveField(1)
  final String name;
  // Название университета
  @HiveField(2)
  final String universe;
  // Направление
  @HiveField(3)
  final String direction;
  // Курс
  @HiveField(4)
  final int course;
  // Описание
  @HiveField(5)
  final String description;
  // Создатель карточки
  @HiveField(6)
  final int creatorId;
  // Рейтинг карточки
  @HiveField(7)
  final double rating;
  // Дата экзамена
  @HiveField(8)
  final DateTime dateExam;
  // Видна ли карточка в общем доступе
  @HiveField(9)
  final bool isVisible;
  // Список вопрос-ответов
  @HiveField(10)
  final List<QuestionAnswer> questionAnswers;
}

import 'dart:convert';

import 'package:cardexam/models/create_user.dart';
import 'package:cardexam/models/question_helpers.dart';
import 'package:cardexam/utilities/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class InternetService {
  InternetService._();

  static InternetService instance = InternetService._();

  factory InternetService() => instance;

  final dio = Dio();

  Future<bool> isLiveServer() async {
    try {
      final response = await dio.get('$url/Server/ping');
      return response.statusCode == 200;
    } on DioError {
      return false;
    }
  }

  Future<int> getMinimalVersionApp() async {
    try {
      final response = await dio.get('$url/Server/minimal_version');
      return response.data;
    } on DioError {
      return -1;
    }
  }

  Future<List<QuestionHelper>> getQuestionHelper() async {
    try {
      final response = await dio.get('$url/Server/questions_help');
      final List<QuestionHelper> questions = <QuestionHelper>[];

      for (int i = 0; i < response.data.length; i++) {
        questions.add(
          QuestionHelper(
            (response.data[i] as Map<String, dynamic>)['question'].toString(),
            (response.data[i] as Map<String, dynamic>)['answer'].toString(),
          ),
        );
      }

      return questions;
    } on DioError {
      return List.empty();
      // throw Exception('Не удалось получить список вспомогательных вопросов');
    }
  }

  Future<List<String>> getUniverses() async {
    try {
      final response = await dio.get('$url/Server/universes');
      return (response.data as List).cast<String>();
    } on DioError {
      return List.empty();
      // throw Exception('Не удалось получить список ВУЗов');
    }
  }

  Future<void> createNewUser({
    required String mail,
    required String username,
    required String password,
    required String universe,
    required String course,
    bool https = false,
    bool notRepeat = false,
  }) async {
    final User newUser = User(
      mail,
      username,
      password,
      universe,
      int.parse(course),
    );
    final String jsonString = jsonEncode(newUser);
    try {
      final String uri = https ? urls : url;
      final response = await dio.post(
        '$uri/User',
        data: jsonString,
        options: Options(
          contentType: Headers.jsonContentType,
          headers: {'accept': '*/*'},
        ),
      );
      debugPrint('User created');
    } on DioError catch (e) {
      if (e.message.contains('[307]')) {
        try {
          // createNewUser(
          //   mail: mail,
          //   username: username,
          //   password: password,
          //   universe: universe,
          //   course: course,
          //   https: true,
          //   notRepeat: true,
          // );

          final response = await dio.post(
            '$urls/User',
            data: jsonString,
            options: Options(
              contentType: Headers.jsonContentType,
              headers: {'accept': '*/*'},
            ),
          );
        } on DioError catch (e) {
          throw Exception(e.response.toString());
        }
      } else {
        debugPrint(e.response.toString());
        throw Exception(e.response.toString());
      }
    }
  }
}

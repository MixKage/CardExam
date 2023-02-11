import 'dart:convert';

import 'package:cardexam/models/create_user.dart';
import 'package:cardexam/models/question_helpers.dart';
import 'package:cardexam/security/security.dart';
import 'package:cardexam/utilities/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class InternetService {
  InternetService._();

  static InternetService instance = InternetService._();

  factory InternetService() => instance;

  String uri = url;
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

  Future<dynamic> executeRequest(Future Function() func) async {
    int tryExecute = 0;
    bool repeatAuth = false;
    while (true) {
      try {
        return await func();
      } on DioError catch (e) {
        tryExecute++;
        if (tryExecute > 4) {
          rethrow;
        }
        if (e.error.toString().contains('307')) {
          debugPrint('ERROR: redirect');
          uri = uri == url ? urls : url;
        } else if (e.error.toString().contains('401')) {
          debugPrint('ERROR: Auth');
          if (!repeatAuth) {
            await loginUser();
            repeatAuth = true;
            debugPrint('ERROR: Repeat Auth');
            // return func();
          } else {
            debugPrint('ERROR: Repeat Auth 2');
            throw Exception('Неверный логин или пароль');
          }
        } else {
          rethrow;
        }
      }
    }
  }

  Future<bool> checkAuth() async {
    try {
      final response = await dio.get(
        '$uri/Login/chek_auth',
        options: Options(
          contentType: Headers.jsonContentType,
          headers: {
            'accept': '*/*',
            'Authorization':
                'Bearer ${SecurityStorage.instance.getSecret(SecretInfo.jwt)}'
          },
        ),
      );
      return response.data;
    } on DioError catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<void> loginUser() async {
    final response = await dio.post(
      '$uri/Login',
      data: jsonEncode({
        'loginOrEmail':
            await SecurityStorage.instance.getSecret(SecretInfo.loginOrEmail),
        'password':
            await SecurityStorage.instance.getSecret(SecretInfo.password),
      }),
    );
    if (response.statusCode == 200) {
      await SecurityStorage.instance
          .setSecret(SecretInfo.jwt, response.data.toString());
    } else {
      throw Exception('Не удалось войти');
    }
  }

  Future<void> createNewUser({
    required String mail,
    required String username,
    required String password,
    required String universe,
    required String course,
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
      await dio.post(
        '$uri/User',
        data: jsonString,
        options: Options(
          contentType: Headers.jsonContentType,
          headers: {'accept': '*/*'},
        ),
      );

      SecurityStorage.instance.setSecret(SecretInfo.loginOrEmail, username);
      SecurityStorage.instance.setSecret(SecretInfo.password, password);
    } on DioError {
      rethrow;
    }
  }
}

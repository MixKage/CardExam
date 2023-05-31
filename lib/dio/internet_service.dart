import 'dart:convert';

import 'package:cardexam/models/create_user.dart';
import 'package:cardexam/models/notify_model.dart';
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
      final response = await dio.get('$url/v1/server/ping');
      return response.statusCode == 200;
    } on DioError {
      return false;
    }
  }

  Future<int> getMinimalVersionApp() async {
    try {
      final response = await dio.get('$url/v1/server/minimal_version');
      return response.data["MinimalVersionMobileApp"];
    } on DioError {
      return -1;
    }
  }

  Future<List<QuestionHelper>> getQuestionHelper() async {
    try {
      final response = await dio.get('$url/v1/server/questions_help');
      final List<QuestionHelper> questions = <QuestionHelper>[];
      for (int i = 0; i < response.data["questions"].length; i++) {
        questions.add(
          QuestionHelper(
            (response.data["questions"][i] as Map<String, dynamic>)['Question'].toString(),
            (response.data["questions"][i] as Map<String, dynamic>)['Answer'].toString(),
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
      final response = await dio.get('$url/v1/server/universities');
      return (response.data["universities"] as List).cast<String>();
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
        '$uri/v1/login/chek_auth',
        options: Options(
          contentType: Headers.jsonContentType,
          headers: {
            'accept': '*/*',
            'Authorization':
                'Bearer ${await SecurityStorage.instance.getSecret(SecretInfo.jwt)}'
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
    try {
      final response = await dio.post(
        '$uri/v1/server/signin',
        data: jsonEncode({
          'Email':
          await SecurityStorage.instance.getSecret(SecretInfo.loginOrEmail),
          'Password':
          await SecurityStorage.instance.getSecret(SecretInfo.password),
        }),
        options: Options(
          contentType: Headers.jsonContentType,
          headers: {'accept': '*/*'},
        ),
      );
      if (response.statusCode == 200) {
        await SecurityStorage.instance
            .setSecret(SecretInfo.jwt, jsonDecode(response.data)['token'].toString());
      } else {
        throw Exception('Не удалось войти');
      }
    }
    on DioError catch (e){
      debugPrint(e.toString());
      rethrow;
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
        '$uri/v1/server/signup',
        data: jsonString,
        options: Options(
          contentType: Headers.jsonContentType,
          headers: {'accept': '*/*'},
        ),
      );

      SecurityStorage.instance.setSecret(SecretInfo.loginOrEmail, username);
      SecurityStorage.instance.setSecret(SecretInfo.password, password);
    } on DioError catch (e){
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<List<NotifyModel>> getNotify() async {
    try {
      var response = await dio.get(
        '$uri/Notify',
        options: Options(
          contentType: Headers.jsonContentType,
          headers: {
            'accept': '*/*',
            'Authorization':
                'Bearer ${await SecurityStorage.instance.getSecret(SecretInfo.jwt)}'
          },
        ),
      );

      final List<NotifyModel> notifies = <NotifyModel>[];

      for (int i = 0; i < response.data.length; i++) {
        final DateTime dateTime = DateTime.parse(
          (response.data[i] as Map<String, dynamic>)['dateNotify'].toString(),
        );
        final String date = '${dateTime.day} ${getMonth(dateTime.month)}';
        notifies.add(
          NotifyModel(
            (response.data[i] as Map<String, dynamic>)['textNotify'].toString(),
            date,
          ),
        );
      }
      return notifies;
    } on DioError {
      rethrow;
    }
  }

  String getMonth(int index) {
    switch (index) {
      case 1:
        return 'января';
      case 2:
        return 'февраля';
      case 3:
        return 'марта';
      case 4:
        return 'апреля';
      case 5:
        return 'мая';
      case 6:
        return 'июня';
      case 7:
        return 'июля';
      case 8:
        return 'августа';
      case 9:
        return 'сентября';
      case 10:
        return 'октября';
      case 11:
        return 'ноября';
      case 12:
        return 'декабря';
    }
    return 'ошибка';
  }
}

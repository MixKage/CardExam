import 'package:cardexam/utilities/constants.dart';
import 'package:dio/dio.dart';

Future<bool> isLiveServer() async {
  try {
    final dio = Dio();
    final response = await dio.get('$url/Server/ping');
    return response.statusCode == 200;
  } on DioError {
    return false;
  }
}

Future<int> getMinimalVersionApp() async {
  try {
    final dio = Dio();
    final responce = await dio.get('$url/Server/minimal_version');
    return responce.data;
  } on DioError {
    return -1;
  }
}

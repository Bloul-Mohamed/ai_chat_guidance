import 'package:ai_chat_guidance/core/constants/api_constants_endpoint.dart';
import 'package:ai_chat_guidance/core/helpers/shared_prefences.dart';
import 'package:ai_chat_guidance/features/authentication/data/models/login_request_body.dart';
import 'package:ai_chat_guidance/features/authentication/data/models/login_response_body.dart';
import 'package:dio/dio.dart';

class ApiLoginService {
  late final Dio _dio;

  ApiLoginService() {
    _dio = Dio();
    _setupDio();
  }

  void _setupDio() {
    _dio.options = BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    // Add interceptors for better error handling
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print('Request: ${options.method} ${options.path}');
          handler.next(options);
        },
        onResponse: (response, handler) {
          print('Response: ${response.statusCode} ${response.data}');
          handler.next(response);
        },
        onError: (error, handler) {
          print('Error: ${error.message}');
          handler.next(error);
        },
      ),
    );
  }

  Future<LoginResponseBody> login(LoginRequestBody requestBody) async {
    try {
      final response = await _dio.post(
        ApiConstants.loginEndpoint,
        data: requestBody.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        await SharedPrefHelper.setData("token", response.data['token']);
        await SharedPrefHelper.setData("uuid", response.data['uuid']);

        return LoginResponseBody.fromJson(response.data);
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: 'Login failed with status: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      print('DioException: ${e.message}');

      if (e.response == null) {
        throw Exception(
          'Invalid credentials. Please check your registration number or password.',
        );
      } else {
        // Network error
        throw Exception(
          'Network error. Please check your internet connection.',
        );
      }
    } catch (e) {
      print('Unexpected error: $e');
      throw Exception('An unexpected error occurred. Please try again.');
    }
  }
}

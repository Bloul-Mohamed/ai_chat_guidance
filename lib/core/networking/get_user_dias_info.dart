import 'package:ai_chat_guidance/core/constants/api_constants_endpoint.dart';
import 'package:ai_chat_guidance/core/helpers/shared_prefences.dart';
import 'package:ai_chat_guidance/features/authentication/data/models/user_info.dart';
import 'package:dio/dio.dart';

class ApiDiasUserService {
  late final Dio _dio;

  ApiDiasUserService() {
    _dio = Dio();
  }

  Future<void> _setupDio() async {
    final token = await SharedPrefHelper.getString("token") ?? "";
    _dio.options = BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': '$token',
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

  Future<UserInfo> userDiaInfo() async {
    try {
      // Setup Dio configuration before making the request
      await _setupDio();

      // Changed from ApiConstants.loginEndpoint to empty string
      // since the full URL is already set in baseUrl
      final uuid = await SharedPrefHelper.getString("uuid") ?? "";
      final response = await _dio.get(ApiConstants.userDiasInfoEndpoint(uuid));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<dynamic> data = response.data;
        final info = data.map((e) => UserInfo.fromJson(e)).first;
        // Log the fetched user information

        /*if (info.isNotEmpty) {
          // Save the user information to shared preferences
          final userDiaInfoCurrentYear = info.first.toJson();
          // for evrey key in userDiaInfoCurrentYear save with value in shard preferences
          for (var key in userDiaInfoCurrentYear.keys) {
            await SharedPrefHelper.setData(key, userDiaInfoCurrentYear[key]);
          }
        }*/
        return info;
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message:
              'Failed to fetch user dias info with status: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      print('DioException: ${e.message}');

      if (e.response == null) {
        throw Exception(
          'Network error. Please check your internet connection.',
        );
      } else {
        throw Exception(
          'Failed to fetch user information. Status: ${e.response?.statusCode}',
        );
      }
    } catch (e) {
      print('Unexpected error: $e');
      throw Exception('An unexpected error occurred. Please try again.');
    }
  }
}

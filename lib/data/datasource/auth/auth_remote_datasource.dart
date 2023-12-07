import 'package:flutter_cbt/data/datasource/auth/auth_local_datasource.dart';
import 'package:flutter_cbt/data/models/request/auth/login_request_model.dart';
import 'package:flutter_cbt/data/models/request/auth/register_request_model.dart';
import 'package:flutter_cbt/data/models/response/auth/auth_response_model.dart';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';

import '../../../core/constants/variables.dart';

class AuthDatasource {
  Future<Either<String, AuthResponseModel>> register(
      RegisterRequestModel registerRequestModel) async {
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/register'),
      body: registerRequestModel.toJson(),
      headers: {
        'Content-Type': 'applicatin/json',
      },
    );

    if (response.statusCode == 200) {
      return Right(AuthResponseModel.fromJson(response.body));
    } else {
      return const Left('Register Gagal');
    }
  }

  Future<Either<String, AuthResponseModel>> login(
      LoginRequestModel loginRequestModel) async {
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/login'),
      body: loginRequestModel.toJson(),
      headers: {
        'Content-Type': 'applicatin/json',
      },
    );

    if (response.statusCode == 200) {
      return Right(AuthResponseModel.fromJson(response.body));
    } else {
      return const Left('Login Gagal');
    }
  }

  Future<Either<String, String>> logout() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/logout'),
      headers: {
        'Content-Type': 'applicatin/json',
        'Authorization': 'Bearer ${authData.accessToken}',
      },
    );

    if (response.statusCode == 200) {
      return const Right('Logout Berhasil');
    } else {
      return const Left('Logout Gagal');
    }
  }
}

import 'package:dartz/dartz.dart';
import 'package:flutter_cbt/core/constants/variables.dart';
import 'package:flutter_cbt/data/datasource/auth/auth_local_datasource.dart';
import 'package:flutter_cbt/data/models/response/ujian/ujian_response_model.dart';
import 'package:http/http.dart' as http;

class UjianRemoteDatasource {
  Future<Either<String, UjianResponseModel>> getUjianByKategori(
      String kategori) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.get(
        Uri.parse('${Variables.baseUrl}/api/get-soal-ujian?kategori=$kategori'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${authData.accessToken}',
        });

    if (response.statusCode == 200) {
      return Right(UjianResponseModel.fromJson(response.body));
    } else {
      return const Left('Get Ujian Gagal');
    }
  }

  Future<Either<String, String>> createUjian() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http
        .post(Uri.parse('${Variables.baseUrl}/api/create-ujian'), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authData.accessToken}',
    });

    if (response.statusCode == 200) {
      return const Right('Create Ujian Berhasil');
    } else {
      return const Left('Create Ujian Gagal');
    }
  }
}

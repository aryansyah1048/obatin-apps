import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../constant/constant.dart';

class AuthService {
  Future<Map<String, dynamic>> submitDonatur({
    required String nama,
    required String telepon,
    required String email,
    File? ktpImage,
  }) async {
    final uri = Uri.parse('$baseURL/api/donatur');

    var request = http.MultipartRequest('POST', uri)
      ..fields['name'] = nama
      ..fields['phone'] = telepon
      ..fields['email'] = email;

    if (ktpImage != null) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'ktp', // Pastikan field ini sesuai dengan backend
          ktpImage.path,
        ),
      );
    }

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 201 || response.statusCode == 200) {
        return {
          'success': true,
          'message': 'Berhasil submit donatur',
          'data': jsonDecode(response.body),
        };
      } else {
        return {
          'success': false,
          'message': 'Gagal submit: ${response.statusCode}',
          'data': jsonDecode(response.body),
        };
      }
    } catch (e) {
      debugPrint('Error submitDonatur: $e');
      return {'success': false, 'message': 'Terjadi kesalahan', 'data': null};
    }
  }
}

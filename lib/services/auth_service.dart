import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import '../constant/constant.dart';

class AuthService {
  static Future<Map<String, dynamic>?> submitDonatur({
    required String nama,
    required String telepon,
    required String email,
    Uint8List? ktpBytes,
  }) async {
    final url = Uri.parse('$baseURL/api/donatur');

    String? ktpBase64;
    if (ktpBytes != null) {
      ktpBase64 = base64Encode(ktpBytes);
    }

    final body = jsonEncode({
      'nama': nama,
      'telepon': telepon,
      'email': email,
      'ktp_image': ktpBase64,
    });

    try {
      final response = await http
          .post(url, headers: {'Content-Type': 'application/json'}, body: body)
          .timeout(const Duration(seconds: 30));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        return responseData; // kembalikan data donatur, termasuk email
      } else {
        print('Gagal submit: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error saat submit: $e');
      return null;
    }
  }

  static Future<Map<String, dynamic>?> verifyOtp({
    required String email,
    required String otp,
  }) async {
    final url = Uri.parse('$baseURL/api/verify-otp');

    final body = jsonEncode({'email': email, 'otp': otp});

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print(
          'Verifikasi OTP gagal: ${response.statusCode} - ${response.body}',
        );
        return null;
      }
    } catch (e) {
      print('Error saat verifikasi OTP: $e');
      return null;
    }
  }
}

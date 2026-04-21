import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthServiceApi {
  // Configuração para emulador Android local usar '10.0.2.2'. 
  // Na Web usa '127.0.0.1' ou 'localhost'. Vamos suportar os dois através de localhost para a Web.
  // Como estamos testando na Flutter Web, usamos o padrão localhost:
  static const String baseUrl = 'http://127.0.0.1:3333/auth';

  /// Faz o registro no Backend. Em caso de sucesso, retorna vazio. 
  /// Em caso de falha, lança um erro formatado para o usuário ver na SnackBar.
  static Future<void> registerUser({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String phone,
    required String taxId,
  }) async {
    final url = Uri.parse('$baseUrl/register');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'firstName': firstName,
          'lastName': lastName,
          'email': email,
          'password': password,
          'phone': phone,
          'taxId': taxId,
        }),
      );

      // Status 201 = Created (Sucesso!)
      if (response.statusCode == 201) {
        return; 
      }

      // Trata erros informados via JSON pelo backend
      final body = jsonDecode(response.body);
      
      if (response.statusCode == 400 || response.statusCode == 409) {
        throw Exception(body['error'] ?? 'Dados inválidos ou e-mail já em uso.');
      } else {
        throw Exception('Erro de servidor: ${response.statusCode}');
      }
    } catch (e) {
      // Se a requisição cair antes de completar (ex: erro de internet/conexao recusada)
      throw Exception(e.toString().replaceAll('Exception: ', ''));
    }
  }

  /// Recupera senha do Backend informando email ou cpf.
  static Future<void> forgotPassword({required String identifier}) async {
    final url = Uri.parse('$baseUrl/forgot-password');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'identifier': identifier}),
      );
      if (response.statusCode == 200) {
        return;
      }
      final body = jsonDecode(response.body);
      if (response.statusCode == 404 || response.statusCode == 403 || response.statusCode == 400) {
        throw Exception(body['error'] ?? 'Erro ao processar solicitação.');
      } else {
        throw Exception('Erro de servidor: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception(e.toString().replaceAll('Exception: ', ''));
    }
  }

  /// Faz o login no Backend. Se sucesso, retorna o token (String).
  static Future<String> login({required String email, required String password}) async {
    final url = Uri.parse('$baseUrl/login');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );
      
      final body = jsonDecode(response.body);
      
      if (response.statusCode == 200) {
        return body['token'] as String;
      }
      
      if (response.statusCode == 401 || response.statusCode == 403 || response.statusCode == 400 || response.statusCode == 404) {
        throw Exception(body['error'] ?? 'Erro no login.');
      } else {
        throw Exception('Erro de servidor: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception(e.toString().replaceAll('Exception: ', ''));
    }
  }

  /// Refefine a senha no Backend com token (pin).
  static Future<void> resetPassword({
    required String identifier,
    required String pin,
    required String newPassword,
  }) async {
    final url = Uri.parse('$baseUrl/reset-password');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'identifier': identifier,
          'pin': pin,
          'newPassword': newPassword,
        }),
      );
      if (response.statusCode == 200) {
        return;
      }
      final body = jsonDecode(response.body);
      if (response.statusCode == 404 || response.statusCode == 401 || response.statusCode == 400 || response.statusCode == 403) {
        throw Exception(body['error'] ?? 'Erro ao redefinir.');
      } else {
        throw Exception('Erro de servidor: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception(e.toString().replaceAll('Exception: ', ''));
    }
  }
}

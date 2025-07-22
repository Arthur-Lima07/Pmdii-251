import 'dart:convert';
import 'package:http/http.dart' as http;
import 'user.dart';

class UserService {
  static const String apiUrl = 'https://jsonplaceholder.typicode.com/users';

  static Future<List<User>> fetchUsers() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List jsonList = json.decode(response.body);
      return jsonList.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Erro ao carregar usuários');
    }
  }
}

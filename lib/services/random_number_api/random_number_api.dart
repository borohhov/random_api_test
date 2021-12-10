import 'dart:convert';

import 'package:http/http.dart' as http;

class RandomNumberApi {
  static Future<int> getRandomNumberFromApi() async {
    http.Response response = await http.get(Uri.parse('https://csrng.net/csrng/csrng.php?min=1&max=1000'));
    int randomNumber = jsonDecode(response.body)[0]["random"];
    return randomNumber;
  }
}

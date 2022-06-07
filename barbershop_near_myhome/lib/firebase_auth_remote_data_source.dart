import 'package:http/http.dart' as http;

class FirebaseAuthRemoteDataSource {
  final String url =
      'https://asia-northeast3-fir-barbershop01.cloudfunctions.net/createCustomToken01';
  Future<String> createCustomToken01(Map<String, dynamic> user) async {
    final customTokenResponse = await http.post(Uri.parse(url), body: user);

    return customTokenResponse.body;
  }
}

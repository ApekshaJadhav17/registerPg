import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Dio dio = new Dio();
  var baseURL = "https://parksmart-api.herokuapp.com/";

  createUser(String vehicle, String name, String email, String password) async {
    try {
      var response = await dio.post(
          "https://parksmart-api.herokuapp.com/api/accounts/register/",
          data: {
            "vehicle_no": vehicle,
            "fullname": name,
            "email": email,
            "password": password
          });

      if (response.statusCode == 200) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.setString('token', response.data['token']);
        print("=================CALLED API SUCCESSFULLY============");
        return response.data['token'];
      } else {
        print(response.data['error']);
        print("api not working");
      }
    } on DioError catch (e) {
      print(e);
    }
  }
}

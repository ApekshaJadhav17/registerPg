import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hrigg/screens/login.dart';
import 'package:hrigg/services/AuthService.dart';
import 'package:hrigg/widgets/CustomButton.dart';
import 'package:hrigg/widgets/FormField.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String vehicle = '';
  String name = '';
  String email = '';
  String password = '';

  bool _obscureText = true;
  bool _isLoading = false;
  String token = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLoading = false;
  }

  createUser() {
    setState(() {
      _isLoading = true;
    });
    AuthService().createUser(vehicle, name, email, password).then((value) {
      token = value;
      print(token);
      if (token != '') {
        _isLoading = false;
        Navigator.pushReplacementNamed(context, "/login");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 70),
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome,",
                      style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      "Register to Continue.",
                      style: TextStyle(fontSize: 22, fontFamily: 'Lato'),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    FormFieldWidget(
                      labelText: 'Name',
                      onChanged: (value) {
                        name = value;
                      },
                      obscureText: false,
                      keyboardType: TextInputType.name,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FormFieldWidget(
                        labelText: 'vehicle_no',
                        onChanged: (value) {
                          vehicle = value;
                        },
                        obscureText: false,
                        keyboardType: TextInputType.emailAddress),
                    SizedBox(
                      height: 20,
                    ),
                    FormFieldWidget(
                        labelText: 'Email',
                        onChanged: (value) {
                          email = value;
                        },
                        obscureText: false,
                        keyboardType: TextInputType.emailAddress),
                    SizedBox(
                      height: 20,
                    ),
                    FormFieldWidget(
                      labelText: 'Password',
                      onChanged: (value) {
                        password = value;
                      },
                      obscureText: _obscureText,
                      keyboardType: TextInputType.visiblePassword,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        icon: Icon(_obscureText
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                      text: "REGISTER",
                      onPressed: () {
                        if (password != null) {
                          createUser();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Password empty')));
                        }
                      },
                    ),
                    SizedBox(
                      height: 40,
                    ),
                  ]),
            ),
          ],
        ));
  }
}

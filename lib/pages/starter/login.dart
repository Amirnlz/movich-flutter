import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:movich/helpers/constants.dart';
import 'package:movich/pages/starter/register_page.dart';
import 'package:movich/service/authenticate/auth_service.dart';
import 'package:movich/widgets/custom_text_field.dart';
import 'package:movich/widgets/persistent_nav_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const spinkit = SpinKitChasingDots(
  color: Colors.white,
  size: 50.0,
);

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: _isLoading
                ? Container(
                    child: spinkit,
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'Oxygen',
                        ),
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        controller: _emailController,
                        widthSize: size.width * 0.8,
                        hintText: "Email",
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        controller: _passwordController,
                        widthSize: size.width * 0.8,
                        keyboardType: TextInputType.text,
                        hintText: "Password",
                        obscureText: true,
                      ),
                      const SizedBox(height: 20),
                      NeumorphicButton(
                        style: kButtonNeumorphicStyle,
                        padding: EdgeInsets.symmetric(
                          vertical: size.height * 0.02,
                          horizontal: size.width * 0.2,
                        ),
                        onPressed: () async {
                          String email = _emailController.text.trim();
                          String password = _passwordController.text.trim();
                          bool isValid = isInputsFilled(email, password);
                          if (isValid) {
                            setState(() {
                              _isLoading = true;
                            });
                            await AuthService().login(email, password);
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PersistentNavigationBar()),
                              (Route<dynamic> route) => false,
                            );
                          }
                          setState(() {
                            _isLoading = false;
                          });
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterPage(),
                            ),
                          );
                        },
                        child: const Text(
                          'Don\'t have account? Register',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

bool isInputsFilled(String email, String password) {
  return email.isNotEmpty || password.isNotEmpty;
}

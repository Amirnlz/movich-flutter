import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movich/helpers/constants.dart';
import 'package:movich/service/authenticate/auth_service.dart';
import 'package:movich/widgets/custom_text_field.dart';
import 'package:movich/widgets/persistent_nav_bar.dart';

const spinkit = SpinKitChasingDots(
  color: Colors.white,
  size: 50.0,
);

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _fullNameController = TextEditingController();

  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _isLoading = false;

  void clearTextFields() {
    _fullNameController.clear();
    _usernameController.clear();
    _emailController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: _isLoading
                ? Container(child: spinkit)
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'SignUp',
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'Oxygen',
                        ),
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        widthSize: size.width * 0.8,
                        controller: _fullNameController,
                        hintText: 'Full name',
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        widthSize: size.width * 0.8,
                        controller: _usernameController,
                        hintText: "Username",
                        keyboardType: TextInputType.name,
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
                      CustomTextField(
                        controller: _confirmPasswordController,
                        widthSize: size.width * 0.8,
                        keyboardType: TextInputType.text,
                        hintText: "Confirm Password",
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
                          String fullName = _fullNameController.text.trim();
                          String username = _usernameController.text.trim();
                          String email = _emailController.text.trim();
                          String password = _passwordController.text.trim();
                          String confirmPassword =
                              _confirmPasswordController.text.trim();
                          bool isValid = isInputFilled(fullName, username,
                              email, password, confirmPassword);
                          if (isValid) {
                            setState(() {
                              _isLoading = true;
                            });
                            await AuthService()
                                .register(email, password, username, fullName);
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
                          'SignUp',
                          style: TextStyle(
                            fontSize: 15,
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

bool isInputFilled(String fullName, String username, String email,
    String password, String confirmPassword) {
  if (fullName.isNotEmpty ||
      username.isNotEmpty ||
      email.isNotEmpty ||
      password.isNotEmpty ||
      confirmPassword.isNotEmpty) {
    return true;
  }
  return false;
}

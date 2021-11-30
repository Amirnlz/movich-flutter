import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:movich/helpers/constants.dart';
import 'package:movich/model/user/user_data.dart';
import 'package:movich/service/cloud/database_service.dart';
import 'package:movich/widgets/custom_text_field.dart';

class EditProfile extends StatelessWidget {
  EditProfile({required this.userData, Key? key}) : super(key: key);

  final UserData userData;

  late final TextEditingController _fullNameController =
      TextEditingController(text: userData.fullName);
  late final TextEditingController _emailController =
      TextEditingController(text: userData.email);
  late final TextEditingController _usernameController =
      TextEditingController(text: userData.username);
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: SizedBox(
              width: size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Edit profile',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: size.width * 0.85,
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.025),
                  const Text(
                    'Account',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  CustomTextField(
                    title: 'Full Name:',
                    width: size.width * 0.85,
                    hintText: '',
                    controller: _fullNameController,
                  ),
                  SizedBox(height: size.height * 0.01),
                  CustomTextField(
                    title: 'Username:',
                    width: size.width * 0.85,
                    controller: _usernameController,
                    hintText: '',
                  ),
                  SizedBox(height: size.height * 0.01),
                  CustomTextField(
                    title: 'Email:',
                    width: size.width * 0.85,
                    controller: _emailController,
                    hintText: '',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: size.height * 0.04),
                  Align(
                    child: SizedBox(
                      width: size.width * 0.85,
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.025),
                  const Text(
                    'Security',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  CustomTextField(
                    title: 'Change password:',
                    width: size.width * 0.85,
                    hintText: '',
                    controller: _passwordController,
                    obscureText: true,
                  ),
                  SizedBox(height: size.height * 0.01),
                  CustomTextField(
                    title: 'Coniform password:',
                    width: size.width * 0.85,
                    hintText: '',
                    controller: _confirmPasswordController,
                    obscureText: true,
                  ),
                  SizedBox(height: size.height * 0.05),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: size.width * 0.5,
                      child: NeumorphicButton(
                        onPressed: () async {
                          String fullName = _fullNameController.text;
                          String email = _emailController.text;
                          String username = _usernameController.text;
                          bool isAccountInputsValid =
                              isAccountInputFilled(fullName, username, email);
                          if (isAccountInputsValid) {
                            await DatabaseService(uid: userData.uid)
                                .updateUserData(
                              username,
                              fullName,
                              email,
                            );
                          }
                        },
                        style: kButtonNeumorphicStyle,
                        child: const Text(
                          'Save',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.08),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

bool isAccountInputFilled(
  String fullName,
  String username,
  String email,
) =>
    fullName.isNotEmpty && username.isNotEmpty && email.isNotEmpty;

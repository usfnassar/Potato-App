import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:potato_project/helper.dart';
import 'package:potato_project/model/register_model.dart';
import 'package:potato_project/screens/login_screen.dart';
import 'package:potato_project/services/register_user.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custome_button.dart';

class RegisterScreen extends StatefulWidget {
  static String id = 'RegisterScreen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late String email;

  late String password;

  late String name;

  bool isLoading = false;

  bool isPassword = true;
  var future;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        color: Colors.grey,
        progressIndicator: CircularProgressIndicator(
          color: Color(0xff006e1c),
        ),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      height: 50.0,
                    ),
                    Container(
                        width: 300.0,
                        height: 215.0,
                        child: Image.asset('assets/images/logo.png')),
                    Text(
                      'Mashro3 Ptats',
                      style: TextStyle(
                        fontFamily: 'Pacifico',
                        color: Color(0xff006e1c),
                        fontSize: 32.0,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      children: [
                        Text(
                          'Create your account',
                          style: TextStyle(
                            color: Color(0xff707070),
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    CustomTextField(
                      prefixIcon: Icons.account_circle,
                      lapel: "Name",
                      onChange: (value) {
                        name = value;
                      },
                      validator: (value) {
                        return ValidateName(value);
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    CustomTextField(
                      prefixIcon: Icons.email,
                      lapel: "Email",
                      onChange: (value) {
                        email = value;
                      },
                      validator: (value) {
                        return ValidateEmail(value);
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    CustomTextField(
                      prefixIcon: Icons.lock,
                      lapel: "Password",
                      sufIcon: IconButton(
                        onPressed: () {
                          isPassword = isPassword ? false : true;
                          setState(() {});
                        },
                        icon: Icon(isPassword
                            ? Icons.visibility
                            : Icons.visibility_off),
                        color: Colors.grey,
                      ),
                      isPassword: isPassword,
                      onChange: (value) {
                        password = value;
                      },
                      validator: (value) {
                        return ValidatePassword(value);
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    CustomButon(
                        txt: 'Register',
                        onTap: () async {
                          FocusManager.instance.primaryFocus?.unfocus();
                          if (formKey.currentState!.validate()) {
                            isLoading = true;
                            setState(() {});
                            try {
                              await Register().RegisterUser(
                                  email: email, password: password, name: name);
                              MessageToUser(
                                Message:
                                    "Account Created Successfully\n\n                   Login Now ",
                                state: MessageState.SUCCESS,
                                context: context,
                              );
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                LoginScreen.id,
                                (route) => false,
                              );
                            } on DioException catch (e) {
                              RegisterError errorData =
                                  RegisterError.fromJson(e.response!.data);
                              String? errorMessage = errorData.data!.msg;
                              MessageToUser(
                                Message: errorMessage!,
                                state: MessageState.ERROR,
                                context: context,
                              );
                            } catch (e) {
                              MessageToUser(
                                Message: e.toString(),
                                state: MessageState.ERROR,
                                context: context,
                              );
                            }
                            isLoading = false;
                            setState(() {});
                          }
                        }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('already have an account?',
                            style: TextStyle(
                              color: Colors.grey,
                            )),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: Color(0xff006e1c),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

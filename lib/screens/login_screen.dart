import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:potato_project/consts.dart';
import 'package:potato_project/helper.dart';
import 'package:potato_project/model/login_model.dart';
import 'package:potato_project/screens/registerscreen.dart';
import 'package:potato_project/services/login_user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custome_button.dart';
import 'home_page.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String email;

  late String password;

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
                          'Sign in to your account',
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
                        txt: 'Login',
                        onTap: () async {
                          FocusManager.instance.primaryFocus?.unfocus();
                          if (formKey.currentState!.validate()) {
                            isLoading = true;
                            setState(() {});
                            try {
                              // await Login().LoginUser(email: email,password: password);
                              var userData = await Login()
                                  .LoginUser(email: email, password: password);
                              bool isAdmin = userData.data!.isAdmin ?? false;
                              String token = userData.data!.token ?? " ";
                              String id = userData.data!.userId ?? " ";
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              print(isAdmin);
                              prefs.setBool(KisAdmin, isAdmin);
                              prefs.setString(KToken, token);
                              prefs.setString(KId, id);
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                HomePage.id,
                                (route) => false,
                              );
                            } on DioException catch (e) {
                              loginError errorData =
                                  loginError.fromJson(e.response!.data);
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
                        Text('Don\'t have an account?',
                            style: TextStyle(
                              color: Colors.grey,
                            )),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, RegisterScreen.id);
                          },
                          child: Text(
                            'Create account',
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

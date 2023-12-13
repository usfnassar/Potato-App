import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:potato_project/helper.dart';
import 'package:potato_project/model/users_model.dart';
import 'package:potato_project/screens/plants_data_screen.dart';
import 'package:potato_project/services/admin_delete_user.dart';
import 'package:potato_project/services/get_planet_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../consts.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  static String id = 'AdminScreen';

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  String? token;
  String? id;
  bool isLoading = false;

  void getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = await prefs.getString(KToken);
    id = await prefs.getString(KId);
    setState(() {});
  }

  @override
  void initState() {
    getToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var users = ModalRoute.of(context)!.settings.arguments as List<Users>;
    Future<void> DeleteUser({required String token, required String id}) async {
      await DeleteUserData().DeleteUser(token: token, id: id);
    }

    return ModalProgressHUD(
      inAsyncCall: isLoading,
      color: Colors.grey,
      progressIndicator: CircularProgressIndicator(
        color: Color(0xff006e1c),
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Color(0xff26333B),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            "Users",
            style: TextStyle(
              fontSize: 33.0,
              color: Color(0xff006e1c),
              shadows: <Shadow>[
                Shadow(
                  offset: Offset(1, 1.0),
                  blurRadius: 1.0,
                  color: Color.fromARGB(50, 0, 0, 0),
                ),
              ],
              fontFamily: "Pacifico",
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () async {
                  isLoading = true;
                  setState(() {});
                  try {
                    var getData = await GetPlanetData().GetData();
                    Navigator.pushNamed(context, PlantDataScreen.id,
                        arguments: [getData, id, token]);
                    isLoading = false;
                    setState(() {});
                  } on DioException catch (e) {
                    isLoading = false;
                    setState(() {});
                    print(e.response);
                    MessageToUser(
                        Message: e.toString(),
                        context: context,
                        state: MessageState.ERROR);
                  }
                },
                icon: Image.asset("assets/images/icon_edit.png"))
          ],
          elevation: 0.0,
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 15.0),
          child: Column(
            children: [
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Text(
                      'user name',
                      style: TextStyle(
                        fontFamily: "Haettenschweiler",
                        color: Color(0xff28353D),
                        fontSize: 27,
                      ),
                    ),
                    SizedBox(
                      width: 55.0,
                    ),
                    Text(
                      'scan number',
                      style: TextStyle(
                        fontFamily: "Haettenschweiler",
                        color: Color(0xff28353D),
                        fontSize: 27,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 9.0,
              ),
              Container(
                child: Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xff3E2821).withOpacity(0.16),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 26.0, horizontal: 8.0),
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemCount: users.length,
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 25.0,
                          );
                        },
                        itemBuilder: (context, index) {
                          return Container(
                            height: 57,
                            width: 359,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Color(0xff707070),
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Center(
                                  child: Row(
                                children: [
                                  Container(
                                    width: 150.0,
                                    child: Text(
                                      users[index].name!,
                                      style: TextStyle(
                                        color: Color(0xff263238),
                                        fontSize: 20.0,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 40.0,
                                  ),
                                  Text(
                                    users[index].plants!.length.toString(),
                                    style: TextStyle(
                                      color: Color(0xff263238),
                                      fontSize: 20.0,
                                    ),
                                  ),
                                  Spacer(
                                    flex: 1,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      onTap: () async {
                                        try {
                                          DeleteUser(
                                              token: token!,
                                              id: users[index].sId!);

                                          MessageToUser(
                                              Message:
                                                  "Done Delete ${users[index].name}",
                                              context: context,
                                              state: MessageState.SUCCESS);

                                          users.removeAt(index);

                                          setState(() {});
                                        } catch (e) {
                                          MessageToUser(
                                              Message: e.toString(),
                                              context: context,
                                              state: MessageState.ERROR);
                                        }
                                      },
                                      child: Container(
                                        child: SvgPicture.asset(
                                          "assets/images/delete_icon.svg",
                                          height: 25,
                                          width: 25,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:potato_project/helper.dart';
import 'package:potato_project/screens/result_archive_screen.dart';

import '../model/get_search_model.dart';

class ArchiveScreen extends StatefulWidget {
  const ArchiveScreen({Key? key}) : super(key: key);
  static String id = "ArchiveScreen";

  @override
  State<ArchiveScreen> createState() => _ArchiveScreenState();
}

class _ArchiveScreenState extends State<ArchiveScreen> {
  Image imageFromBase64String(String base64String) {
    return Image.memory(base64Decode(base64String), fit: BoxFit.fill);
  }

  Future<void> NavigateToArchiveResultPage(
      {required int index,
      required GetSearch user,
      required String userId}) async {
    isLoading = true;
    setState(() {});
    try {
      isLoading = false;
      setState(() {});
    } catch (e) {
      isLoading = false;
      setState(() {});
      MessageToUser(
          Message: e.toString(), context: context, state: MessageState.ERROR);
      print(e);
    }
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var data = ModalRoute.of(context)!.settings.arguments as List;
    GetSearch user = data[0];
    String userId = data[1];

    return ModalProgressHUD(
      inAsyncCall: isLoading,
      color: Colors.grey,
      progressIndicator: CircularProgressIndicator(
        color: Colors.green,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Color(0xff26333B),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: user.recentPlants!.length != 0
            ? Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 9.0),
                      child: Center(
                        child: Text(
                          'History',
                          style: TextStyle(
                            fontFamily: "Pacifico",
                            color: Color(0xff006e1c),
                            fontSize: 33,
                          ),
                        ),
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
                              itemCount: user.recentPlants!.length,
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: 25.0,
                                );
                              },
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, ResultArchivePage.id,
                                        arguments: [
                                          user.recentPlants![index].treatment,
                                          user.recentPlants![index].plantName,
                                          user.recentPlants![index].plantDisease
                                        ]);
                                  },
                                  child: Container(
                                    height: 250,
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
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Center(
                                          child: Row(
                                        children: [
                                          Container(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: imageFromBase64String(user
                                                  .recentPlants![index].image!),
                                            ),
                                            height: 230.0,
                                            width: 170.0,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Color(0xff707070),
                                                width: 1.0,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 30.0,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 30.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  child: Text(
                                                    user.recentPlants![index]
                                                        .plantName!,
                                                    style: TextStyle(
                                                      color: Color(0xff26333B),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20.0,
                                                    ),
                                                  ),
                                                  width: 100.0,
                                                ),
                                                SizedBox(
                                                  height: 20.0,
                                                ),
                                                Container(
                                                  child: Text(
                                                    user.recentPlants![index]
                                                        .plantDisease!,
                                                    style: TextStyle(
                                                      color: user
                                                                  .recentPlants![
                                                                      index]
                                                                  .plantDisease! ==
                                                              "healthy"
                                                          ? Colors.green
                                                          : Color(0xffDD2A37),
                                                      fontSize: 18.0,
                                                    ),
                                                  ),
                                                  width: 100.0,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )),
                                    ),
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
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/empty_archive.jpg"),
                  Text(
                    'Ups!... no planets found',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                      color: Color(0xff26333B),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

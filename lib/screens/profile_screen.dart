import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:potato_project/consts.dart';
import 'package:potato_project/helper.dart';
import 'package:potato_project/model/get_user_model.dart';
import 'package:potato_project/screens/archive_screen.dart';
import 'package:potato_project/screens/login_screen.dart';
import 'package:potato_project/services/get_recintly_scearch.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  static final String id = 'ProfileScreen';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var user = ModalRoute.of(context)!.settings.arguments as GetUserData;

    return ModalProgressHUD(
      inAsyncCall: isLoading,
      color: Colors.grey,
      progressIndicator: CircularProgressIndicator(
        color: Color(0xff006e1c),
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SizedBox(
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Positioned(
                    child: Container(
                  height: 235.0,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage('assets/images/profile_bacground.jpg'),
                    fit: BoxFit.cover,
                  )),
                )),
                Positioned(
                    left: 3.0,
                    top: 5.0,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Color(0xff26333B),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )),
                Positioned(
                    top: 200.0,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40.0)),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 1.3,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, top: 10.0, right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          // mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 27.0),
                                  child: IconButton(
                                    onPressed: () async {
                                      isLoading = true;
                                      setState(() {});
                                      try {
                                        var searchData = await GetUserSearch()
                                            .GetSearchData(id: user.user!.sId);
                                        Navigator.pushNamed(
                                            context, ArchiveScreen.id,
                                            arguments: [
                                              searchData,
                                              user.user!.sId
                                            ]);
                                        isLoading = false;
                                        setState(() {});
                                      } catch (e) {
                                        isLoading = false;
                                        setState(() {});
                                        MessageToUser(
                                            Message: e.toString(),
                                            context: context,
                                            state: MessageState.ERROR);
                                        print(e);
                                      }
                                    },
                                    icon: Icon(
                                      CupertinoIcons.archivebox_fill,
                                      color: Color(0xff253239),
                                      size: 32.0,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Icon(
                              Icons.account_circle,
                              color: Color(0xff253239),
                              size: 131.0,
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Text(
                                    "Username",
                                    style: TextStyle(
                                      color: Color(0xff5E676D),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.0,
                                    ),
                                  ),
                                ),
                                Container(
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
                                        child: Container(
                                      child: Center(
                                        child: Text(
                                          user.user!.name!,
                                          style: TextStyle(
                                            color: Color(0xff263238),
                                            fontSize: 20.0,
                                          ),
                                        ),
                                      ),
                                    )),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 21.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Text(
                                    "Email",
                                    style: TextStyle(
                                      color: Color(0xff5E676D),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.0,
                                    ),
                                  ),
                                ),
                                Container(
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
                                        child: Container(
                                      child: Center(
                                        child: Text(
                                          user.user!.email!,
                                          style: TextStyle(
                                            color: Color(0xff263238),
                                            fontSize: 20.0,
                                          ),
                                        ),
                                      ),
                                    )),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 12,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                right: 10.0,
                              ),
                              child: Container(
                                width: double.maxFinite,
                                height: 50.0,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          Color(0xffDD2A37)),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ))),
                                  onPressed: () async {
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    await prefs.remove(KToken);
                                    Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      LoginScreen.id,
                                      (route) => false,
                                    );
                                  },
                                  child: Text(
                                    ' Logout',
                                    style: TextStyle(fontSize: 22.0),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

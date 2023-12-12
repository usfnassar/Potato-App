import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:potato_project/consts.dart';
import 'package:potato_project/helper.dart';
import 'package:potato_project/model/planet_model.dart';
import 'package:potato_project/model/treatment_model.dart';
import 'package:potato_project/screens/admin_screen.dart';
import 'package:potato_project/screens/profile_screen.dart';
import 'package:potato_project/screens/result_screen.dart';
import 'package:potato_project/services/add_planet_to_history.dart';
import 'package:potato_project/services/get_user.dart';
import 'package:potato_project/services/treatment_planet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io' as io;
import '../services/admin_get_user.dart';
import '../services/predict_planet.dart';

class HomePage extends StatefulWidget {
  static String id = 'Homepage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool? isAdmin;
  String? token;
  String? id;
  XFile? image;
  PlanetModel? result;
  GetTreatmentModel? treatment;
  bool isLoading = false;

  final ImagePicker picker = ImagePicker();

  //we can upload image from camera or from gallery based on parameter
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(
        source: media, imageQuality: 50, maxHeight: 500.0, maxWidth: 500.0);
    image = img;
    setState(() {});
    if (image != null) {
      final bytes = io.File(image!.path).readAsBytesSync();
      String img64 = base64Encode(bytes);
      result = null;
      isLoading = true;
      setState(() {});
      try {
        result = await PredictPlanet().predict(im64: img64);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        id = await prefs.getString(KId);
        treatment = await GetTreatment().Treatment(
            userId: id!, plantId: result!.predictedClassLabel.id.toString());
        await AddPlanetData().AddPlanet(
            id: id,
            planetName: result!.predictedClassLabel.planetName,
            planetDisease: result!.predictedClassLabel.planetDisease,
            hasDisease: result!.predictedClassLabel.planetDisease == "healthy"
                ? false
                : true,
            plantId: result!.predictedClassLabel.id.toString(),
            image: img64);
        await Navigator.pushNamed(context, ResultPage.id,
            arguments: [treatment, result]);
        isLoading = false;
        setState(() {});
      } on DioException catch (e) {
        isLoading = false;
        setState(() {});
        MessageToUser(
            Message: e.toString(), context: context, state: MessageState.ERROR);

        print(e.toString());
      }
      setState(() {});
    } else {
      MessageToUser(Message: "Can't pick image!!", context: context);
    }
  }

  //show popup dialog
  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            content: Container(
              height: MediaQuery.of(context).size.height / 3,
              child: Column(
                children: [
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.cancel_outlined,
                            color: Color(0xffDD2A37),

                          )),
                    ],
                  ),
                  Container(
                    width: 70.0,
                    height: 70.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/choose_icon.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'Please choose media to select',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.image),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text('From Gallery'),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  ElevatedButton(
                    //if user click this button. user can upload image from camera
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.camera),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text('From Camera'),
                      ],
                    ),
                  ),
                  Spacer()
                ],
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    checkIsAdmain();
    getTokenAndId();
    super.initState();
  }

  void checkIsAdmain() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isAdmin = await prefs.getBool(KisAdmin) ?? false;
    setState(() {});
  }

  void getTokenAndId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = await prefs.getString(KToken);
    id = await prefs.getString(KId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
            automaticallyImplyLeading: false,
            elevation: 0,
            leading: IconButton(
              icon: Container(
                width: 36.0,
                height: 36.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/images/icon_registration.png'),
                  fit: BoxFit.fill,
                )),
              ),
              onPressed: () async {
                isLoading = true;
                setState(() {});
                try {
                  var UserData = await GetUserProfile().GetProfileData(id: id);
                  Navigator.pushNamed(context, ProfileScreen.id,
                      arguments: UserData);
                } catch (e) {
                  MessageToUser(
                      Message: "There An Error",
                      context: context,
                      state: MessageState.ERROR);
                }
                isLoading = false;
                setState(() {});
              },
            ),
            actions: [
              Visibility(
                visible: isAdmin ?? false,
                child: IconButton(
                    onPressed: () async {
                      isLoading = true;
                      setState(() {});
                      try {
                        var Users =
                            await GetUserData().UsersList(id: id, token: token);

                        Navigator.pushNamed(context, AdminScreen.id,
                            arguments: Users);
                      } on DioException catch (e) {
                        var errorMessage = e.response!.data['msg'];

                        MessageToUser(
                            Message: errorMessage,
                            context: context,
                            state: MessageState.ERROR);
                      } catch (e) {
                        MessageToUser(
                            Message: e.toString(),
                            context: context,
                            state: MessageState.ERROR);
                      }
                      isLoading = false;
                      setState(() {});
                    },
                    icon: Image.asset("assets/images/icon_admin.png")),
              ),
            ],
          ),
          body: CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(),
                      Column(
                        children: [
                          Image.asset("assets/images/home_logo.png"),
                          Text(
                            "Lets's get started",
                            style: TextStyle(
                                color: Color(0xff006e1c),
                                fontSize: 40.0,
                                fontFamily: "Haettenschweiler"),
                          ),
                          SizedBox(
                            height: 21.0,
                          ),
                          Text(
                            '''   Get professional plant care guidance   
                         your plants alive''',
                            style: TextStyle(
                              color: Color(0xff263238),
                              fontSize: 18.0,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Container(
                        width: 250.0,
                        height: 50.0,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ))),
                          onPressed: () async {
                            myAlert();
                          },
                          child: Text(
                            '+ Add plant',
                            style: TextStyle(fontSize: 22.0),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}

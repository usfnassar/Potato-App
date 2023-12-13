import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:potato_project/helper.dart';
import 'package:potato_project/model/treatment_model.dart';
import 'package:potato_project/services/predict_planet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io' as io;
import '../consts.dart';
import '../model/planet_model.dart';
import '../services/add_planet_to_history.dart';
import '../services/treatment_planet.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  static String id = 'previewPage';

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  XFile? LocalImage;
  PlanetModel? result;
  bool isLoading = false;
  String? id;
  GetTreatmentModel? treatment;

  final ImagePicker picker = ImagePicker();

  //we can upload image from camera or from gallery based on parameter

  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(
        source: media, imageQuality: 50, maxHeight: 190.0, maxWidth: 190.0);

    setState(() {
      LocalImage = img;
    });
    if (LocalImage != null) {
      final bytes = io.File(LocalImage!.path).readAsBytesSync();
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

        await Navigator.pushReplacementNamed(context, ResultPage.id,
            arguments: [treatment, result]);
        isLoading = false;
        setState(() {});
      } catch (e) {
        isLoading = false;
        setState(() {});
        MessageToUser(
            Message: e.toString(), context: context, state: MessageState.ERROR);
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
  Widget build(BuildContext context) {
    var data = ModalRoute.of(context)!.settings.arguments as List;
    GetTreatmentModel treatment = data[0];
    PlanetModel result = data[1];

    return ModalProgressHUD(
      inAsyncCall: isLoading,
      color: Colors.grey,
      progressIndicator: CircularProgressIndicator(
        color: Colors.green,
      ),
      child: Scaffold(
        body: SizedBox(
          width: double.maxFinite,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Positioned(
                  child: Container(
                height: 300.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/images/result_logo.jpg'),
                  fit: BoxFit.cover,
                )),
              )),
              Positioned(
                  left: 3.0,
                  top: 27.0,
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
                  top: 190.0,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40.0)),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 1.3,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                      "assets/images/planet_name_logo.svg",width: 40.0,height: 40.0,),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Text(
                                    "Plant name",
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 22.0,
                                      fontFamily: "Pacifico",

                                        shadows: <Shadow>[
                                            Shadow(
                                              offset: Offset(1, 1.0),
                                              blurRadius: 1.0,
                                              color: Color.fromARGB(50, 0, 0, 0),
                                            ),

                                          ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 4.0,
                              ),
                              Text(
                                result.predictedClassLabel.planetName,
                                style: TextStyle(
                                    color: Color(0xff263238),
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                                maxLines: 1,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                      "assets/images/disease_icon.svg",width: 40.0,height: 40.0,),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Text(
                                    "Disease Detected",
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 22.0,
                                      fontFamily: "Pacifico",

                                        shadows: <Shadow>[
                                            Shadow(
                                              offset: Offset(1, 1.0),
                                              blurRadius: 1.0,
                                              color: Color.fromARGB(50, 0, 0, 0),
                                            ),

                                          ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 4.0,
                              ),
                              Text(
                                result.predictedClassLabel.planetDisease !=
                                        "healthy"
                                    ? result.predictedClassLabel.planetDisease
                                    : "No Disease",
                                style: TextStyle(
                                  color: Color(0xffDD2A37),
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                              ),
                            ],
                          ),
                          result.predictedClassLabel.planetDisease != "healthy"
                              ? Column(
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                            "assets/images/remedy_logo.png"),
                                        SizedBox(
                                          width: 5.0,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 15.0),
                                          child: Text(
                                            "Possible remedy",
                                            style: TextStyle(
                                              color: Colors.green,
                                              fontSize: 22.0,
                                              fontFamily: "Pacifico",

                                                shadows: <Shadow>[
                                              Shadow(
                                                offset: Offset(1, 1.0),
                                                blurRadius: 1.0,
                                                color: Color.fromARGB(50, 0, 0, 0),
                                              ),

                                            ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        color:
                                            Color(0xff3E2821).withOpacity(0.16),
                                      ),
                                      width: 376,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              3,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: NotificationListener<
                                            OverscrollIndicatorNotification>(
                                          onNotification:
                                              (OverscrollIndicatorNotification
                                                  not) {
                                            not.disallowIndicator();
                                            return false;
                                          },
                                          child: SingleChildScrollView(
                                            // physics: BouncingScrollPhysics(),
                                            child: Text(
                                              treatment.data.treatment,
                                              style: TextStyle(
                                                fontSize: 20.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              20,
                                    ),
                                    Text(
                                      'Reminder',
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 22.0,
                                        fontFamily: "Pacifico",

                                          shadows: <Shadow>[
                                              Shadow(
                                                offset: Offset(1, 1.0),
                                                blurRadius: 1.0,
                                                color: Color.fromARGB(50, 0, 0, 0),
                                              ),

                                            ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 92.0),
                                      child: Text(
                                        'Care for each of your plants',
                                        style: TextStyle(
                                          color: Color(0xff263238),
                                          fontSize: 20.0,
                                          fontFamily: "Pacifico",
                                        ),
                                      ),
                                    ),
                                    Center(
                                        child: Image.asset(
                                      "assets/images/remedy_healthy_logo.png",
                                      height: 200.0,
                                    )),
                                  ],
                                ),
                          Spacer(),
                          Center(
                            child: Container(
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
                                  style: TextStyle(fontSize: 20.0),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

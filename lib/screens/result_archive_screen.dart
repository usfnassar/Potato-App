import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ResultArchivePage extends StatelessWidget {
  const ResultArchivePage({super.key});

  static String id = 'ArchiveResultPage';

  //show popup dialog
  @override
  Widget build(BuildContext context) {
    var data = ModalRoute.of(context)!.settings.arguments as List;
    String? treatment = data[0];
    String name = data[1];
    String disease = data[2];

    return Scaffold(
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
                top: 50.0,
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
                top: 260.0,
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
                                    "assets/images/planet_name_logo.svg",height: 40,width: 40,),
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
                              name,
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
                              disease != "healthy" ? disease : "No Disease",
                              style: TextStyle(
                                color: Color(0xffDD2A37),
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                            ),
                          ],
                        ),
                        disease != "healthy"
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
                                      borderRadius: BorderRadius.circular(20.0),
                                      color:
                                          Color(0xff3E2821).withOpacity(0.16),
                                    ),
                                    width: 376,
                                    height:
                                        MediaQuery.of(context).size.height / 3,
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
                                            treatment ?? "",
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
                                        MediaQuery.of(context).size.height / 20,
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
                                    padding: const EdgeInsets.only(left: 92.0),
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
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

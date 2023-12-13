import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:potato_project/helper.dart';
import 'package:potato_project/services/update_treatment.dart';
import '../model/planet_data_model.dart';
import '../services/treatment_planet.dart';

class PlantDataScreen extends StatefulWidget {
  const PlantDataScreen({super.key});

  static String id = "PlantsData";

  @override
  State<PlantDataScreen> createState() => _PlantDataScreenState();
}

class _PlantDataScreenState extends State<PlantDataScreen> {
  TextEditingController treatmentControler = TextEditingController();
  bool isLoading = false;
  bool isLoadingAlert = false;

  @override
  Widget build(BuildContext context) {
    var data = ModalRoute.of(context)!.settings.arguments as List;

    PlanetDataModel users = data[0];
    String id = data[1];
    String token = data[2];
    Future<void> showAlert(int index) async {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  title: Row(
                    children: [
                      Spacer(),
                      Text("Update Treatment"),
                      Spacer(),
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
                  content: Column(mainAxisSize: MainAxisSize.min, children: [
                    TextFormField(
                      maxLines: 8,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.grey,
                        )),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      controller: treatmentControler,
                    ),
                  ]),
                  actions: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 250.0,
                          height: 50.0,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ))),
                              onPressed: () async {
                                isLoadingAlert = true;
                                setState(() {});
                                try {
                                  await UpdateTreatment().Update(
                                      token: token,
                                      id: id,
                                      plantId: users.data[index].id.toString(),
                                      treatment: treatmentControler.text);
                                  isLoadingAlert = false;
                                  setState(() {});
                                  Navigator.of(context).pop();
                                } catch (e) {
                                  isLoadingAlert = false;
                                  setState(() {});
                                  MessageToUser(
                                      Message: e.toString(),
                                      context: context,
                                      state: MessageState.ERROR);
                                  print(e);
                                }
                              },
                              child: isLoadingAlert
                                  ? Container(
                                      width: 20.0,
                                      height: 20.0,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  : Text("Update")),
                        ),
                      ),
                    )
                  ],
                );
              },
            );
          });
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
          child: Column(
            children: [
              Text("Treatment",
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

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 9.0),
                child: Row(
                  children: [
                    Text(
                      'Name Of The Diseases',
                      style: TextStyle(
                        fontFamily: "Haettenschweiler",
                        color: Color(0xff28353D),
                        fontSize: 30,
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
                        itemCount: users.data.length,
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 25.0,
                          );
                        },
                        itemBuilder: (context, index) {
                          return Container(
                            height: 60,
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
                                    constraints: BoxConstraints(maxWidth: 260),
                                    child: Text(
                                      users.data[index].planetDisease +
                                          " (${users.data[index].planetName})",
                                      style: TextStyle(
                                        color: Color(0xff263238),
                                        fontSize: 20.0,
                                      ),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      onTap: () async {
                                        isLoading = true;
                                        setState(() {});
                                        try {
                                          var treatment = await GetTreatment()
                                              .Treatment(
                                                  userId: id,
                                                  plantId: users.data[index].id
                                                      .toString());
                                          treatmentControler.text =
                                              treatment.data.treatment;
                                          isLoading = false;
                                          setState(() {});
                                          showAlert(index);
                                        } catch (e) {
                                          isLoading = false;
                                          setState(() {});
                                          print(e);
                                        }
                                      },
                                      child: Container(
                                        child: Icon(
                                          Icons.edit,
                                          color: Color(0xff26333B),
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

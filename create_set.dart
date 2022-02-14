import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gym_app/models/Object.dart';
import 'package:gym_app/screens/Home/planlist.dart';
import 'package:gym_app/utils/constants.dart';
import "package:http/http.dart" as http;
import 'create_plan.dart';

class Create_sets extends StatefulWidget {
  final bool edit ;
  final String id ;
  final String Plan_id ;
  final String Plan_name ;
  final String name ;
  final String Totalmet ;
  final String Exercise_weight ;
  final String Exercise_rest ;
  const Create_sets({Key key,this.edit,this.Plan_id,this.name,this.id,this.Plan_name,this.Totalmet,this.Exercise_weight,this.Exercise_rest}) : super(key: key);

  @override
  _Create_sets createState() => _Create_sets();
}


class updatestate extends State<Create_sets> {
  int sets = 1;
  int rest = 30;
  int setcount = 0;
  List reps = [0];
  List weight = [0];
  int a;
  String c;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Container(
          color: Color.fromRGBO(235, 235, 235, 1),
          height: MediaQuery.of(context)
              .size
              .height *
              0.08,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Spacer(),
                  RaisedButton(
                    onPressed: (){
                      reps.clear();
                      weight.clear();
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Spacer(),
                  Container(
                      height: MediaQuery.of(context)
                          .size
                          .height *
                          0.05,
                      child: VerticalDivider(color: Colors.grey,thickness: 2.5,)),
                  Spacer(),
                  RaisedButton(
                    onPressed: () async {
                      Gplansetdata.clear();
                      for (int i=0;sets>i;i++){
                        Gplansetdata.add(Gplanset.fromJson({ "Exercise_reps":reps[i],
                          "Exercise_set":sets,
                          "Exercise_rest":rest,
                          "Exercise_weight":weight[i]}));
                      }

                      GplanExercisedata.add(GplanExercise.fromJson(
                          {"Exercise_id":this.widget.id,
                            "Exercise_name":this.widget.name,
                            "set":Gplansetdata.toList()
                          }));
                      setState(() {
                        print(GplanExercisedata.length.toString());
                        lists.add(this.widget.id);
                        exicelistnumber=lists.length;
                        print("jjjjjj");
                        print(Gplansetdata[0]);
//                        Totalmet1=Totalmet1+int.parse(this.widget.Totalmet);
                      });
                      if(this.widget.edit){
                        if(master==false){
                          var body = jsonEncode({
                            "planid":this.widget.Plan_id,
                            "plan_exercise":GplanExercisedata.toList()
                          });

                          final http.Response response = await http.put(
                              API_URL+"exercise/Plan_Exercise_add/", headers: <String, String>{
                            "Content-Type": "application/json",
                            "Authorization": "Bearer"+" "+APP_TOKEN,
                          },
                              body:body
                          );
                          var data45 = json.decode(utf8.decode(response.bodyBytes));
                          GplanExercisedata.clear();
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Create_plan(edit: true,exid:this.widget.Plan_id,excname:"null",name:this.widget.Plan_name,Totalmet: Totalmet1+int.parse(this.widget.Totalmet))));
                        }else{
                          var body = jsonEncode({
                            "planid":this.widget.Plan_id,
                           "plan_exercise":GplanExercisedata.toList()
                          });
                          final http.Response response = await http.put(
                              API_URL+"exercise/Plan_Exercise_add/", headers: <String, String>{
                            "Content-Type": "application/json",
                            "Authorization": "Bearer"+" "+APP_TOKEN,
                          },
                              body:body
                          );
                          var data45 = json.decode(utf8.decode(response.bodyBytes));
                          GplanExercisedata.clear();
                          reps.clear();
                          weight.clear();
                          Navigator.pop(context);
                          Navigator.pop(context);

                          Navigator.push(context, MaterialPageRoute(builder: (context) => Create_plan(edit: true,exid:this.widget.Plan_id,excname:"null",name:this.widget.Plan_name,Totalmet: Totalmet1+int.parse(this.widget.Totalmet))));
                        }

                      }else{
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Create_plan(edit: false,excname:this.widget.Plan_name,name:this.widget.Plan_name,Totalmet: Totalmet1+int.parse(this.widget.Totalmet),reload: 1)));
                      }
                    },
                    child: Text(
                      "Ok",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Spacer(),

                ],
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0,
        backgroundColor: Color.fromRGBO(235, 235, 235, 1),
        centerTitle: true,
        title: Text(
          this.widget.name,
          style: TextStyle(
              color: Colors.black,
              fontSize: 17,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Text(
                    "Sets",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  IconButton(
                    icon: const Icon(Icons.remove),
                    // tooltip: 'Increase volume by 10',
                    onPressed: sets == 1
                        ? null
                        : () {
                      setState(() {
                        sets--;
//                        reps.clear();
//                        weight.clear();
                      });
                    },
                  ),
                  Text(
                    sets.toString(),
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    // tooltip: 'Increase volume by 10',
                    onPressed: () {
                      setState(() {
                        sets++;
//                        reps.clear();
//                        weight.clear();
                      });
                    },
                  ),
                ],
              ),
            ),Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Text(
                    "Rest Duraion (Secs)",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  IconButton(
                    icon: const Icon(Icons.remove),
                    // tooltip: 'Increase volume by 10',
                    onPressed: rest == 30
                        ? null
                        : () {
                      setState(() {
                        rest=rest-30;
                      });
                    },
                  ),
                  Text(
                    rest.toString(),
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    // tooltip: 'Increase volume by 10',
                    onPressed: () {
                      setState(() {
                        rest=rest+30;
                      });
                    },
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.grey[400],
              thickness: 2,
            ),
            Container(
              // color: Colors.red,
              height: MediaQuery.of(context).size.height * 0.6,
              child: ListView.separated(

                  separatorBuilder: (context, index) => Divider(
                    color: Colors.white,
                    thickness: 2,
                  ),
                  itemCount: sets,
                  itemBuilder: (BuildContext context, int index) {
                    setcount = index + 1;
                    reps.add(0);
                    weight.add(0);
                    return Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                color: Colors.grey[400],
                                width: 2,
                              )
                          )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Set $setcount",
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Reps in count",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                Spacer(),
                                IconButton(
                                  icon: const Icon(Icons.remove),
                                  // tooltip: 'Increase volume by 10',
                                  onPressed: reps[index]==0?null: () {
                                    setState(() {
                                      reps[index]--;
                                    });
                                  },
                                ),
                                Text(
                                  reps[index].toString(),
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  // tooltip: 'Increase volume by 10',
                                  onPressed: () {
                                    setState(() {
                                      reps[index]++;
                                    });
                                  },
                                ),
                              ],
                            ),
                            this.widget.Exercise_weight!="0"?
                            Row(
                              children: [
                                Text(
                                  "Weight in Kgs",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                Spacer(),
                                IconButton(
                                  icon: const Icon(Icons.remove),
                                  // tooltip: 'Increase volume by 10',
                                  onPressed: weight[index]==0?null: () {
                                    setState(() {
                                      weight[index]--;
                                    });
                                  },
                                ),
                                Text(
                                  weight[index].toString(),
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  // tooltip: 'Increase volume by 10',
                                  onPressed: () {
                                    setState(() {
                                      weight[index]+=1;
                                    });
                                  },
                                ),
                              ],
                            ):Container()
                          ],
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}

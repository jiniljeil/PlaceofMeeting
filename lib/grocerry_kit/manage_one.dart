import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'db_conn.dart';
import 'model/product_model.dart';
import 'package:flutter_widgets/utils/cart_icons_icons.dart';
import 'dart:async';
import 'home_page.dart';
import 'sub_pages/home_list.dart';
import 'package:mysql_utils/mysql_utils.dart';

class ManageOne extends StatefulWidget {
  final int id;
  final int room_id;
  ManageOne({Key key, @required this.id, @required this.room_id}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ManageOneState();
  }
}

class Applicant{
  int id;
  String name;
  String MBTI;
  String job;
  String major;
  Applicant(this.id, this.name, this.MBTI, this.job, this.major);
}

class _ManageOneState extends State<ManageOne>{
  List<Applicant> applicant_list = new List<Applicant>();
  List<String> job = ['없음','학생', '전문직', '회사원', '자영업', 'CEO', '기타'];

  Future<List<Applicant>> getData(int room_id, int uid) async {

    final conn = await MySqlConnection.connect(Database.getConnection());
    print("ROOM: " + room_id.toString() );
    var results = await conn.query(
        'SELECT P.id, P.name, P.MBTI, P.job, major FROM (select room_people.ID AS id, name, MBTI, job from room_people, person_info where room_people.ID = person_info.ID and room_people.state = 1 and room_people.room_id = ?) AS P, major WHERE major.ID = P.id',
      [room_id]
    );

    for(var row in results) {
      applicant_list.add((new Applicant(row[0], row[1], (row[2] == null) ? 'None' : row[2], job[(row[3] == null) ? 0 : row[3].toInt()], (row[4] == null) ? 'None' : row[4])));
    }

    conn.close();
  }

  final Future<String> _calculation = Future<String>.delayed(
    const Duration(seconds: 3),
        () => 'Data Loaded',
  );


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData(widget.room_id, widget.id) ;
  }


  @override
  Widget build(BuildContext context) {
    int uid = widget.id;

    return Scaffold(
        appBar: _buildAppBar(context),
        body: SingleChildScrollView(
            child: DefaultTextStyle(
              style: Theme.of(context).textTheme.headline2,
              textAlign: TextAlign.center,
              child: FutureBuilder<String>(
                future: _calculation,
                builder: (BuildContext context, AsyncSnapshot<String> snapshot){
                  List<Widget> children;
                  if(snapshot.hasData){
                    if (applicant_list.length != null) {
                      children = <Widget>[
                        SizedBox(height: 15),
                        Text(
                          'Applicant',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        _showapplicant(applicant_list.length, applicant_list, uid, widget.room_id),
                      ];
                    }else{
                      children = <Widget>[
                        SizedBox(height: 15),
                        Text(
                          'Applicants',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ];
                    }

                  }else if (snapshot.hasError) {
                    children = <Widget>[
                      const Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text('Error: ${snapshot.error}'),
                      )
                    ];
                  } else {
                    children = const <Widget>[
                      Padding(padding: EdgeInsets.only(top:300)),
                      SizedBox(
                        child: CircularProgressIndicator(
                          color: Colors.green,
                        ),
                        width: 40,
                        height: 40,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 16),
                      )
                    ];
                  }
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: children,
                    ),
                  );
                },
              ),
            )
        )
    );
  }
}

Widget _showapplicant(int n, List<Applicant> mlist, int uid, int room_id){
  Future db_permit(int room_id, int uid) async {
    final conn = await MySqlConnection.connect(Database.getConnection());
    await conn.query("UPDATE room_people SET state = 2 WHERE ID = ? AND room_id = ?",[uid, room_id]);
    conn.close();
  }

  return ListView.builder(
    padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    itemCount: n,
    itemBuilder: (BuildContext context, int index) {
      return Container(
        height: 100,
        margin: EdgeInsets.only(top:10, bottom:10),
        padding: EdgeInsets.only(left: 16, right: 16),
        child: Card(
          shadowColor: Colors.blueAccent,
          elevation: 10,
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 10, top: 5, bottom: 5,),
                height: 80,
                child: Row(
                  children: <Widget> [
                    Container(
                      width: 50,
                      height: 50,
                      //TODO (image)
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.blue,
                      ),
                    ),
                    Container(
                      width: 200,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget> [
                          Container(
                            child: Text(mlist[index].name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget> [
                              Container(
                                  child: Text("MBTI: " + mlist[index].MBTI)
                              ),
                              Padding(padding: EdgeInsets.only(left: 5)),
                              Container(
                                child: Text("Job: " + mlist[index].job),
                              ),
                            ]
                          ),
                          Container(
                            child: Text("Major: "+ mlist[index].major),
                          )
                        ],
                      )
                    ),
                    Container(
                      child: TextButton(
                        child: Text("Permit", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
                        onPressed: () async {
                          print("TESTT");
                          await db_permit(room_id, mlist[index].id) ;
                        },
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blueAccent,
                      ),
                    )
                  ],
                )
              ),
            ],
          )
        )
      );
    },
//    separatorBuilder: (BuildContext context, int index) => const Divider(),
  );
}

Widget _buildAppBar(context) {
  return AppBar(
    centerTitle: true,
    brightness: Brightness.dark,
    elevation: 0,
    backgroundColor: Colors.green,
    automaticallyImplyLeading: false,
    leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white),
        onPressed:(){
          Navigator.pop(context);
        }
    ),
    title: Text(
      'Place of Meeting',
      style: TextStyle(color: Colors.white),
    ),
  );
}

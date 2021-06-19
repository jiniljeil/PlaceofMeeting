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
  ManageOne({Key key, @required this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ManageOneState();
  }
}

class Applicant{
  String name;
  int age;
  String MBTI;
  String job;
  String memo;

  Applicant(this.name, this.age, this.MBTI, this.job, this.memo);
}

List<Applicant> _list = [];
int num;

Future<int> getData(int uid) async{
  List<Applicant> temp = [];
  int n_data;
  final conn = await MySqlConnection.connect(Database.getConnection());

  var results = await conn.query(
      'select name, age, MBTI, jon, memo'
          'from room_people, person_info '
          'where room_people.ID = person_info.ID '
          'and room_people.state = 1'
  );

  conn.close();

  for(var row in results) {
    print('title: ${row[0]}, desc: ${row[1]}, count: ${row[2]}');
    Applicant m = new Applicant(row[0], row[1], row[2], row[3], row[4]);
    temp.add((m));
    //   _list.add(temp);
  }
  //   n_data = results.length;
  print(n_data);

  num = results.length;
  _list = temp;
}

final Future<String> _calculation = Future<String>.delayed(
  const Duration(seconds: 3),
      () => 'Data Loaded',
);

class _ManageOneState extends State<ManageOne>{

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
                    _showapplicant(num, _list, uid),
                  ];
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

Widget _showapplicant(int n, List<Applicant> mlist, int uid){
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(8.0, 20.0, 8.0, 8.0),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: n,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 75,
          color: index % 2 == 0 ? Colors.green : Colors.green[200],
          child: ListTile(
            leading: Icon(Icons.star, color: Colors.amberAccent),
            title: Text(
              '${mlist[index].name}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.start,
            ), //{entries[index]}'),
            subtitle: Padding(
              padding: EdgeInsets.only(top: 5),
              child: Text(''
                  '${mlist[index].MBTI}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            trailing: IconButton(
                icon: Icon(Icons.people_alt_outlined, color: Colors.white, size: 35),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ManageOne(id: uid))
                  );
                }
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
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


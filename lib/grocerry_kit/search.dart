import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

import 'db_conn.dart';



class SearchPage extends StatefulWidget {
  final int id ;
  SearchPage({Key key, @required this.id}) : super(key:key);

  @override
  State<StatefulWidget> createState() {
    return _SearchPage();
  }
}

class _SearchPage extends State<SearchPage> {
  String search_text = "";
  Map<String, int> room_info = new Map<String,int>();
  bool focus_mode = false;
  final textController = TextEditingController();
  final List<String> records =  new List<String>();
  final List<String> title = new List<String>();
  final List<int> numofp = new List<int>();

  Future db_delete_one_record(int user_id, String record) async {
    final conn = await MySqlConnection.connect(Database.getConnection());
    await conn.query("DELETE FROM search_records WHERE ID = ? AND records = ?", [user_id, record]);
    conn.close();
  }

  Future db_delete_records(int user_id) async {
    final conn = await MySqlConnection.connect(Database.getConnection());
    await conn.query("DELETE FROM search_records WHERE ID = ?", [user_id]);

    conn.close();
  }
  Future db_load_records(int user_id) async {
    final conn = await MySqlConnection.connect(Database.getConnection());

    var result = await conn.query("SELECT records FROM search_records WHERE ID = ?", [user_id]);

    for (var row in result) {
      records.add(row[0].toString());
    }
    conn.close();
  }

  Future db_search_records(int user_id, String search_record) async{
    final conn = await MySqlConnection.connect(Database.getConnection());

    await conn.query('INSERT INTO search_records(ID, records) VALUES (?, ?)', [user_id, search_record]);

    conn.close();
  }

  final Future<String> _calculation = Future<String>.delayed(
    const Duration(seconds: 2),
        () => 'Data Loaded',
  );

  Future db_search_list(TextEditingController search_term) async {
    Map<String, int> room_info = new Map<String, int>();

    final conn = await MySqlConnection.connect(Database.getConnection());

    //print('SELECT title, count FROM rooms WHERE title LIKE \'\%${search_term.text}\%\'');
    var result = await conn.query('SELECT title, count FROM rooms WHERE title LIKE ?', ['%${search_term.text}%']);

    if( result.isNotEmpty ) {
      for (var row in result) {
        room_info.addAll({row[0].toString():row[1].toInt()});
      }
    }

    conn.close();
    return room_info;
  }

  void initState() {
    super.initState();
    db_load_records(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget> [
                      Container(
                        padding: EdgeInsets.all(10.0),
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 5.0, left: 30.0, bottom: 8.0, right: 30.0),
                          child: Theme(
                            data: ThemeData(
                                primaryColor: Colors.green
                            ),
                            child: TextField(
                              controller: textController,
                              decoration: InputDecoration(
                                labelText: "Search",
                                hintText: "Search",
                                prefixIcon: Icon(Icons.search , color: Colors.green),

                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                                    borderSide: BorderSide(color: Colors.green)
                                ),

                              ),
                              onTap: () {
                                focus_mode = true;
                              },
                              onSubmitted: (String search_content) async {
                                await db_search_records(widget.id, search_text);
                              },
                              onChanged: (text) async {
                                // 검색 결과
                                search_text = text;
                                Map<String, int> result = await db_search_list(textController);
                                setState(() {
                                  title.clear(); numofp.clear();
                                  if (result.keys != null) {
                                    for (var key in result.keys) {
//                            print("KEY:"+key);
                                      title.add(key);
                                      numofp.add(result[key]);
                                      print(key + " " + result[key].toString());
                                    }
                                  }
                                });
                              },
                            ),
                          )
                      ),
//              SearchField(),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,

                        children: <Widget> [
                          TextButton (
                            child: Text("SearchList Delete",
                              style: TextStyle(color: Colors.green),
                            ),
                            onPressed: () async {
                              await db_delete_records(widget.id);
                              records.clear();
                            },
                          ),
                          Container(
                            width: 10,

                          ),
                        ],
                      ),
                      // 검색 결과 + 검색 리스트 나열
//              SearchList(room_info)
                      Expanded(
                        child: DefaultTextStyle(
                          style: Theme.of(context).textTheme.headline2,
//                  textAlign: TextAlign.center,
                          child: FutureBuilder<String>(
                            future: _calculation, // a previously-obtained Future<String> or null
                            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                              List<Widget> children;
                              if (snapshot.hasData) {
                                children = <Widget>[
                                  Expanded(
                                    child: Container(
                                      height: 450,
                                      child: (focus_mode) ? ListView.builder(
                                        padding: const EdgeInsets.all(5),
                                        itemCount: title.length,
                                        itemBuilder: (BuildContext context, int index) {
                                          return GestureDetector(
                                            child: Container(
                                              height: 70,
                                              margin: EdgeInsets.only(left: 25, right: 25, top: 10),
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(color: Colors.grey),
                                                ),

                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget> [
                                                  Container(
                                                    margin: EdgeInsets.all(10),
                                                    width: 50,
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                      color: const Color(0xff7c94b6),
                                                      /*image: const DecorationImage(
                        image:NetworkImage('http://www.sjpost.co.kr/news/photo/202007/53199_48342_4214.jpg'),
                        fit: BoxFit.cover,
                      ),*/
                                                      //                 borderRadius: BorderRadius.circular(12),
                                                    ),
                                                  ),

                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: <Widget>[
                                                      Container(
                                                          width: 220,
                                                          padding: EdgeInsets.only(left: 5, top:5),
                                                          height: 30,
                                                          child: Text('Title ${title[index]}',
                                                            style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight: FontWeight.bold,
                                                            ),
                                                          )
                                                      ),
                                                      Padding(padding: EdgeInsets.only(top: 1),),
                                                      Container(
                                                        width: 220,
                                                        height: 20,
                                                        padding: EdgeInsets.only(left: 5,),
                                                        child: Text('${numofp[index]}', style: TextStyle(fontSize: 15)),
                                                      )
                                                    ],
                                                  ),

                                                ],
                                              ),
                                            ),
                                            onTap: () async {
//                                      await db_search_records(widget.id, search_text);
                                              // TODO
                                              // move the clicked page
                                            },
                                          );
                                        },
                                      ) : ListView.builder( // Searched Records List
                                          padding: const EdgeInsets.all(5),
                                          itemCount: records.length,
                                          itemBuilder: (BuildContext context, int index) {
                                            return GestureDetector(
                                              child: Container(
                                                height: 40,
                                                margin: EdgeInsets.only(left: 50, right: 50, top: 10),
                                                child: Row(
                                                  children: <Widget>[
                                                    Container(
                                                      width: 230,
                                                      child: Text('${records[index]}', style: TextStyle(fontSize: 20)),
                                                    ),
                                                    Container(
                                                        child: Align(
                                                            alignment: Alignment.centerRight,
                                                            child: IconButton(
                                                                onPressed: () async {
                                                                  await db_delete_one_record(widget.id, '${records[index]}');
                                                                },
                                                                icon: Icon(Icons.clear)
                                                            )
                                                        )
                                                    )
                                                  ],
                                                ),
                                                decoration: BoxDecoration(
                                                  border: Border(
                                                    bottom: BorderSide(color: Colors.grey),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                      ),
                                    ),
                                  ),
                                ];
                              } else if (snapshot.hasError) {
                                children = <Widget>[
                                  const Icon(
                                    Icons.error_outline,
                                    color: Colors.red,
                                    size: 30,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 16),
                                    child: Text('Error: ${snapshot.error}'),
                                  )
                                ];
                              } else {
                                children = const <Widget>[
                                  SizedBox(
                                    child: CircularProgressIndicator(),
                                    width: 30,
                                    height: 30,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 16),
                                    child: Text('Awaiting result...', style: TextStyle(fontSize: 20)),
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
                        ),
                      )
                    ]
                )
            )
        )
    );
  }
}

Widget _buildAppBar() {
  return AppBar(
    centerTitle: true,
    brightness: Brightness.dark,
    elevation: 0,
    backgroundColor: Colors.green,
    automaticallyImplyLeading: false,
    title: Text(
      'SearchPage',
      style: TextStyle(color: Colors.white),
    ),
  );
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'model/product_model.dart';
import 'package:flutter_widgets/utils/cart_icons_icons.dart';
import 'dart:async';
import 'home_page.dart';
import 'sub_pages/home_list.dart';
import 'package:mysql_utils/mysql_utils.dart';

class ChatUsers{
  String name;
  String room_ex;
  String imageURL;
  ChatUsers({@required this.name,@required this.room_ex,@required this.imageURL});
}
/*
List<ChatUsers> getList(Results results){
  List<ChatUsers> temp = [];
  for(var row in results){
    print('host_id: ${row[0]}, room_id: ${row[1]}');
    temp.add(ChatUsers(
        name: 'name', room_ex: 'room_ex', imageURL: 'imageURL'));
  }
  return temp;
}
*/
// ignore: must_be_immutable
class ManageList extends StatefulWidget {
  final int id;
  ManageList({Key key, @required this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ManageListState();
  }
}

class Manage{
  int zz;
  int ss;

  Manage(this.zz, this.ss);
}

class _ManageListState extends State<ManageList>{
  int n;
  List<Manage> _list;

  Future<int> getData(int uid) async{
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'placeofmeeting.cjdnzbhmdp0z.us-east-1.rds.amazonaws.com',
        port: 3306,
        user: 'rootuser',
        db: 'placeofmeeting',
        password: 'databaseproject'
    ));

    final results = await conn.query(
        'select * from rooms where host_id = ?', [uid]);
    conn.close();

    for(var row in results) {
      print('Name: ${row[0]}, email: ${row[1]}');
      var temp = new Manage(row[0], row[1]);
      _list.add(temp);
    }

    n = results.length;
  }

  final Future<String> _calculation = Future<String>.delayed(
    const Duration(seconds: 1),
        () => 'Data Loaded',
  );

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
              _myList(n)
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
              Padding(padding: EdgeInsets.only(top:100)),
              SizedBox(
                child: CircularProgressIndicator(),
                width: 40,
                height: 40,
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Awaiting result...', style: TextStyle(fontSize: 30)),
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

//   body: _myList(n),

/*FutureBuilder<String>(
          future: _calculation, // a previously-obtained Future<String> or null
          builder:
      ),*/

Future _getentries(int n){

}

Widget _myList(int n){
  var entries = _getentries(n);

  return ListView.separated(
    padding: const EdgeInsets.fromLTRB(8.0, 20.0, 8.0, 8.0),
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    itemCount: 2,
    itemBuilder: (BuildContext context, int index) {
      return Container(
        height: 62,
        color: index%2==0?Colors.green:Colors.green[200],
        child: ListTile(
          leading: const Icon(Icons.star, color: Colors.amberAccent),
          title: Text('Entry '), //{entries[index]}'),
          trailing: const Icon(Icons.wysiwyg), )
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


/*
  @override
  List<ChatUsers> chatUsers = [
    ChatUsers(name: "롤", room_ex: "매일 밤 열한시", imageURL: "images/userImage1.jpeg"),
    ChatUsers(name: "오버워치", room_ex: "금요일 밤", imageURL: "images/userImage2.jpeg"),
    ChatUsers(name: "A", room_ex: "AAA", imageURL: "images/userImage3.jpeg"),
    ChatUsers(name: "B", room_ex: "BBB", imageURL: "images/userImage4.jpeg"),
    ChatUsers(name: "C", room_ex: "CCC", imageURL: "images/userImage5.jpeg"),



  Widget build(BuildContext context) {
  // final HtoMArg args = ModalRoute.of(context).settings.arguments;
  // chatUsers.add(ChatUsers(name: 'name', room_ex: 'room_ex', imageURL: 'imageURL'));
    return Scaffold (
      appBar: _buildAppBar(context),
      body: Container(
        color: const Color(0xffF4F7FA),
        child: ListView(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 16, top: 20),
                  child: Text(
                    '                       My Own Rooms',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            SizedBox(height: 50),
            _buildChatList(),
          ],
        ),
      ),
    );
  }

  Widget _buildChatList() {
    //var items = ChatUsers();
    return Container (
      height: 700,
      alignment: Alignment.topLeft,
      child: ListView.builder (
        shrinkWrap: true,
        //physics: ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: chatUsers.length, // 채팅방 수
        itemBuilder: (context, index) {
          //var data = items[index];
          return  ChatRoomList(
            name: chatUsers[index].name,
            room_ex: chatUsers[index].room_ex,
            imageUrl: chatUsers[index].imageURL,
          );
        },
      ),
    );
  }



class ChatRoomList extends StatefulWidget{
  String name; // 방제목
  String room_ex; // 방 설명
  String imageUrl; //Icon icon_name; // 아이콘이나 이미지
  // String time;
  // bool isMessageRead;
  ChatRoomList({@required this.name,@required this.room_ex,@required this.imageUrl/*,@required this.time,@required this.isMessageRead*/});
  @override
  _ManageListState createState() => _ManageListState();
}

*/
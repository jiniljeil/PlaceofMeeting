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

class _ManageListState extends State<ManageList>{

  Future<String> getData(int uid, List<ChatUsers> clist) async{
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'placeofmeeting.cjdnzbhmdp0z.us-east-1.rds.amazonaws.com',
        port: 3306,
        user: 'rootuser',
        db: 'placeofmeeting',
        password: 'databaseproject'
    ));

    final results = await conn.query(
        'select * from rooms where host_id = 8');
    conn.close();

    final Future<String> _calculation = Future<String>.delayed(
      const Duration(seconds: 2),
          () => 'Data Loaded',
    );

    clist.add(ChatUsers(name: 'name', room_ex: 'room_ex', imageURL: 'imageURL'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: _buildAppBar(context),
      body: Text("TEST")/*Container(
        padding: EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.green,
                    maxRadius: 30,
                  ),
                  SizedBox(width: 16,),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('안녕', style: TextStyle(fontSize: 16),),
                          SizedBox(height: 6,),
                          Text('ㅋㅋ',style: TextStyle(fontSize: 13,color: Colors.grey.shade600, fontWeight: FontWeight.normal),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
            */
    );
  }
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
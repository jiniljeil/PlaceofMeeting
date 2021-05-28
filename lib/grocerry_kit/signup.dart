import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:async';
import 'package:mysql1/mysql1.dart';

class SignupPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignupPageState();
  }
}



class _SignupPageState extends State<SignupPage> {
  final idController = TextEditingController();
  final pwdController = TextEditingController();
  final pwd2Controller = TextEditingController();
  final nameController = TextEditingController();
  final genderController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final _item = ['Man', 'Woman'];
  var _selected = 'Man';
  var check = 0;
  int inc = 5;

  Future main(TextEditingController id, TextEditingController pwd, TextEditingController name, String gender,
      TextEditingController email, TextEditingController pnum ) async{

    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'placeofmeeting.cjdnzbhmdp0z.us-east-1.rds.amazonaws.com',
        port: 3306,
        user: 'rootuser',
        db: 'placeofmeeting'  ,
        password: 'databaseproject'
        ));

    print('dddddddd');

    var result = await conn.query(
         'insert into login_info values (?, ?, ?, ?, ?, ?, ?)',
          [inc, gender=='Man'? 1 : 0, 000123, id.text, pwd.text, email.text, pnum.text]
    );
    print('Inserted row id=${result.insertId}');

    print('sadfsadf');
    inc++;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body:
        ListView(
          children: <Widget>[
            Container(
              height: 850,
              decoration: BoxDecoration(
                  boxShadow: [
                    new BoxShadow(
                      color: Colors.black26,
                      offset: new Offset(0.0, 2.0),
                      blurRadius: 25.0,
                    )
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(32),
                      bottomRight: Radius.circular(32))),
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(16),
                          child: FlatButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/grocerry/login');
                            },
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 16, top: 8),
                      child: Text(
                        'Welcome to Place of Meeting.',
                        style:
                            TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 16, top: 8),
                      child: Text(
                        'Let\'s get started',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.normal),
                      ),
                    ),
                    Padding(
                      padding:
                      EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                      child: TextField(
                        controller: idController,
                        style: TextStyle(fontSize: 18),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: 'ID',
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey)),
                          suffixIcon: IconButton(
                              padding: EdgeInsets.only(right: 30),
                              icon: Icon(Icons.check),
                              onPressed: () {
                                // 중복체크 쿼리
                              },
                            ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                      child: TextField(
                        controller: pwdController,
                        obscureText: true,
                        keyboardType: TextInputType.number,
                        style: TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                          hintText: 'Passward',
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey)),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                      child: TextField(
                        controller: pwd2Controller,
                        obscureText: true,
                        style: TextStyle(fontSize: 18),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Passward Reconfirm',
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey)),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                      EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                      child: TextField(
                        controller: nameController,
                        style: TextStyle(fontSize: 18),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: 'Name',
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 23, right: 16, top: 8, bottom: 8),
                        child: Row(
                          children: [
                            Text(
                              'Gender       ',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                            ),
                            DropdownButton(
                              value: _selected,
                              items: _item.map(
                                      (value){
                                    return DropdownMenuItem(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }
                              ).toList(),
                              onChanged: (value){
                                setState(() {
                                  _selected = value;
                                });
                              },
                            ),
                          ],
                        ),
                    ),
                    Padding(
                      padding:
                      EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                      child: TextField(
                        controller: emailController,
                        style: TextStyle(fontSize: 18),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'E-mail',
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey)),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                      EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                      child: TextField(
                        controller: phoneController,
                        style: TextStyle(fontSize: 18),
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          hintText: 'Phone-num',
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey)),
                        ),
                      ),
                    ),
                    Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          margin: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              color: Colors.green, shape: BoxShape.circle),
                          child: IconButton (
                            color: Colors.white,
                            onPressed: () {
                              main(idController, pwdController, nameController, _selected, emailController, phoneController);
                              Navigator.pushNamed(context, '/');
                            },
                            icon: Icon(Icons.arrow_forward),
                          ),
                        )),
                  ],
              ),
            ),
          ],
        ));
  }
}

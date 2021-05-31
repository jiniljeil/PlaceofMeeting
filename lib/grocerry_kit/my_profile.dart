import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
//          onPressed: () => Navigator.of(context).pop(),
            onPressed: () {},
          ),
          centerTitle: true,
          title: Text(
            'Profile',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green,
          actions: <Widget> [
            FlatButton(
              textColor: Colors.white,
              onPressed: () {},
              child: Text("저장"),
              shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
            )
          ],
        ),
        body: Container(
            child: Center(
              child: Column(
//            crossAxisAlignment: CrossAxisAlignment.start,
//            mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xff7c94b6),
                      /*image: const DecorationImage(
                        image: NetworkImage('http://www.sjpost.co.kr/news/photo/202007/53199_48342_4214.jpg'),
                        fit: BoxFit.cover,
                      ),*/
//                 borderRadius: BorderRadius.circular(12),
                    ),
                    height: 200,
//                margin: const EdgeInsets.only(left: 10.0, right:10.0, top: 5.0, bottom: 5.0),
                  ),

                  Expanded(child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget> [
                          Container(
                            margin: EdgeInsets.only(left: 20.0, right:20.0, top: 3.0, bottom: 3.0),
                            child: Column(
                              children: <Widget>[

                                TextField(
                                  decoration: InputDecoration(
                                      hintText: "이름",
                                      labelText: "이름",
                                      labelStyle: TextStyle(
                                        color: const Color(0xFF424242),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.green),
                                      )
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.only(left: 20.0, right:20.0, top: 3.0, bottom: 3.0),
                            child: Column(
                              children: <Widget>[

                                TextField(
                                  decoration: InputDecoration(
                                      hintText: "나이",
                                      labelText: "나이",
                                      labelStyle: TextStyle(
                                        color: const Color(0xFF424242),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.green),
                                      )
                                  ),
                                ),
                              ],
                            ),
                          ),
//
                          Container(
                            margin: EdgeInsets.only(left: 20.0, right:20.0, top: 3.0, bottom: 3.0),
                            child: Column(
                              children: <Widget>[

                                TextField(
                                  decoration: InputDecoration(
                                      hintText: "취미",
                                      labelText: "취미",
                                      labelStyle: TextStyle(
                                        color: const Color(0xFF424242),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.green),
                                      )
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.only(left: 20.0, right:20.0, top: 3.0, bottom: 3.0),
                            child: Column(
                              children: <Widget>[
                                TextField(
                                  decoration: InputDecoration(
                                      hintText: "MBTI",
                                      labelText: "MBTI",
                                      labelStyle: TextStyle(
                                        color: const Color(0xFF424242),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.green),
                                      )
                                  ),
                                ),
                              ],
                            ),
                          ),

// Scroll 처리 필요
                          Container(
                            height:400,
                            margin: EdgeInsets.only(left: 20.0, right:20.0, top: 3.0, bottom: 3.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                            ),
                            child: Column(
                              children: <Widget>[
                                Text("자기 소개",
                                  style: TextStyle(
                                    fontSize: 18
                                  )
                                ),
                                TextFormField(
                                  maxLines: 10,
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                  decoration: InputDecoration(
                                      hintText: "자신을 설명해 주세요.",
//                                      labelText: "자기 소개",
                                      labelStyle: TextStyle(
                                        fontSize: 22,
                                        color: const Color(0xFF424242),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.green),
                                      )
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]
                    ),
                  ))
                ],
              ),
            )
        )
    );
  }
}
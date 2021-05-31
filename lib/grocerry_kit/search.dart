import 'package:flutter/material.dart';
import 'package:flutter_widgets/utils/cart_icons_icons.dart';
import 'package:flutter_widgets/grocerry_kit/sub_pages/home_list.dart';
import 'package:flutter_widgets/grocerry_kit/sub_pages/cart.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchPage();
  }
}

class _SearchPage extends State<SearchPage> {

  int _index = 0 ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: _buildAppBar(),
      /*
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.shifting,
        currentIndex: 1,
        onTap: (index) {
          setState(() {
            _index = index;
          });
        },

        items: [
          BottomNavigationBarItem(
              icon: Icon(
                CartIcons.home,
              ),
              title: Text('   Store  ', style: TextStyle())),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
              ),
              title: Text('Search', style: TextStyle())),
          BottomNavigationBarItem(
              icon: Icon(
                CartIcons.favourites,
              ),
              title: Text('Favourites', style: TextStyle())),
          BottomNavigationBarItem(
              icon: Icon(
                CartIcons.account,
              ),
              title: Text(
                'My Account',
                style: TextStyle(),
              ))
        ],
      ),*/
//      body: _widgetList[_index],
      body: Container(
        child: Center(
          child: Column(
            children: <Widget> [
              Container(
                padding: EdgeInsets.all(10.0),
              ),
              SearchField(),
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              // 검색 결과 + 검색 리스트 나열
              SearchList(),
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
//    actions: <Widget>[
//      Icon(Icons.search, color: Colors.white),
//      SizedBox(
//        width: 10,
//      ),
//      Icon(Icons.notifications_none, color: Colors.white),
//      SizedBox(
//        width: 10,
//      ),
//    ],
  );
}


SearchField() {
  return Padding(
      padding: EdgeInsets.only(top: 5.0, left: 30.0, bottom: 8.0, right: 30.0),
      child: Theme(
        data: ThemeData(
            primaryColor: Colors.green
        ),
        child: TextField(
          decoration: InputDecoration(
            labelText: "Search",
            hintText: "Search",
            prefixIcon: Icon(Icons.search , color: Colors.green),

            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                borderSide: BorderSide(color: Colors.green)
            ),

          ),
          onChanged: (text){
            text = text.toLowerCase();
            // 검색 결과
//            filter = text;
//            setState(() {
//              _notesForDisplay = _notes.where((note){
//                var notetitle = note.title.toLowerCase();
//                return notetitle.contains(text);
//              }).toList();
//            });
          },
        ),
      )
  );
}

SearchList(){
  final List<String> title = <String>['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J'];
  final List<String> sub_title = <String>["산책하실분", "노래방가실분", "밥먹으실분", "축구하실분", "노래방가실분", "게임하실분", "축구하실분", "농구하실분", "게임하실분", "산책하실분"];
  return Container(
    height: 450,
    child: ListView.builder(
      padding: const EdgeInsets.all(5),
      itemCount: title.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
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
                      child: Text('${sub_title[index]}'),
                  )
                ],
              ),

            ],
          ),
        );
      },
    )
  );
}
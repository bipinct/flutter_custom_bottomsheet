

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;
import 'dart:io';
import 'package:path_provider/path_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  double _initialSliderHeight = 80;
  double _sliderHeight = 80;
  TabController tabController;
  TextStyle selectedTextstyle;
  GlobalKey previewContainer  = new GlobalKey();
  Image _image2;

  Color _appBackgroundColor = Colors.blueAccent;
  List backgrounds = [
    "https://images.unsplash.com/photo-1472552944129-b035e9ea3744",
    "https://images.unsplash.com/photo-1577283617116-cad711fc556d",
    "https://images.unsplash.com/photo-1577261041320-fc4ec1e6b2a2",
    "https://images.unsplash.com/photo-1577218545339-2506e153c843",
    "https://images.unsplash.com/photo-1577269330970-d4f24a498e2f",
    "https://images.unsplash.com/photo-1577318530987-f2f4b903ad37",
    "https://images.unsplash.com/photo-1577234231282-d5017c6ac8b4",
    "https://images.unsplash.com/photo-1577154881361-c957822c3a0c",
  ];
  String backgroundImage="https://images.unsplash.com/photo-1577261041320-fc4ec1e6b2a2";

  void initState() {
    tabController = new TabController(length: 3, vsync: this);
    selectedTextstyle= TextStyle(color: Colors.white, fontSize: 40,fontFamily: "Lato");

    super.initState();
  }

  List subtitle = [
    "The club isn′t the best",
    "The club isn′t the best",
    "place to find a lover",
    "So the bar is where I go",
    "Me and my friends at the",
    "table doing shots",
    "Drinking fast and then we talk slow",
    "You come over and start up a",
    "conversation with just me",
    "And trust me I will give",
    "it a chance now",
    "Take my hand stop",
    "Put Van The Man on the jukebox",
    "And then we start to dance",
    "And now I am singing like",
    "Girl you know I want your love",
    "Your love was handmade",
    "for somebody like me",
    "Come on now follow my lead",
    "I may be crazy don′t mind me",
    "Say boy let′s not talk too much",
    "Grab on my waist and put",
    "that body on me",
    "Come on now follow my lead",
    "Come come on now follow my lead",
    "I am in love with the shape of you",
    "We push and pull like a magnet do",
    "Although my heart is falling too",
    "I am in love with your body",
    "And last night you were in my room",
    "And now my bedshets smell like you",
    "Every day discovering",
    "something brand new",
    "I am in love with your body",
    "Oh I oh I oh I oh I",
    "I am in love with your body",
    "Oh I oh I oh I oh I",
    "I am in love with your body",
    "Oh I oh I oh I oh I",
    "I am in love with your body",
    "Every day discovering",
    "something brand new",
    "I am in love with the shape of you",
    "One week in we let the story begin",
    "We are going out on our first date",
    "You and me are thrifty",
    "So go all you can eat",
    "Fill up your bag and I fill up a plate",
    "We talk for hours and hours about",
    "the sweet and the sour",
    "And how your family is doing okay",
    "Leave and get in a taxi then",
    "kiss in the backseat",
    "Tell the driver make the radio play",
    "And I am singing like",
    "Girl you know I want your love",
    "Your love was handmade",
    "for somebody like me",
    "Come on now follow my lead",
    "I may be crazy don′t mind me",
    "Say boy let′s not talk too much",
    "Grab on my waist and put"
  ];

  List layouts = [
    {"text": "lato"},
    {"text": "poiretOne"},
    {"text": "monotone"},
  ];



  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    double _maxHeightBottomSheet = _height - _initialSliderHeight - 20;
    double _middleHeightBottomSheet = _height/2 - _initialSliderHeight ;
    var _layouts = layouts.map<Widget>((book) => _fontView(book)).toList();
    var _backgrounds = backgrounds.map<Widget>((image) => _makeBackground(image)).toList();

    double dragPositionY = 0;
    return Scaffold(
        body: Stack(
          children: <Widget>[
            RepaintBoundary(
              key: previewContainer,
              child: Container(
                width: _width,
                height: _height,
                decoration: BoxDecoration(color: _appBackgroundColor,
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                        image: NetworkImage(backgroundImage+"?w="+_width.toInt().toString()),
                        fit: BoxFit.cover
                    )
                ),
                child: Center(
                  child: Text(
                    "Custom Bottom Sheet test",
                    style: selectedTextstyle,
                  ),
                ),
              ),
            )
            ,
            Positioned(
              top:30,
              right: 20,
              child: RaisedButton(
                child: Text('Download'),
                onPressed: (){
                  FocusScope.of(context).requestFocus(FocusNode());
                  takeScreenShot(context);
                },
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: _width,
                decoration: BoxDecoration(shape: BoxShape.rectangle, boxShadow: [
                  BoxShadow(
                      spreadRadius: 100.0,
                      offset: Offset(0, 60),
                      color: Color.fromARGB(150, 0, 0, 0),
                      blurRadius: 100.0)
                ]),
                child: Column(
                  children: <Widget>[
                    Container(
                        width: _width,
                        alignment: Alignment.center,
                        child: GestureDetector(
                          child: Container(
                              color: Colors.transparent,
                              child: Padding(
                                  padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                                  child: Text(
                                    "Tap Here",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ))),
                          onTap: () {
                            setState(() {
                              _sliderHeight =
                              _sliderHeight == _initialSliderHeight ?
                              _middleHeightBottomSheet :
                              _sliderHeight == _maxHeightBottomSheet ?
                              _initialSliderHeight : _maxHeightBottomSheet;

                            });
                          },
                          onVerticalDragUpdate: (drag) {
                            setState(() {
                              _sliderHeight = _height - drag.globalPosition.dy;
                            });
                          },
                          onVerticalDragEnd: (drag) {
                            setState(() {
                              _sliderHeight = _sliderHeight > _height / 2
                                  ? _maxHeightBottomSheet
                                  : _initialSliderHeight;
                            });
                          },
                        )),
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25.0),
                          topRight: Radius.circular(25.0)),
                      child:
//                    GestureDetector(
//                      onPanDown:    (darg){
//                        setState(() {
//                          _sliderHeight = _initialSliderHeight;
//                        });
//                      },
//                      child:
                      AnimatedContainer(
                        duration: Duration(seconds: 1),
                        curve: Curves.fastLinearToSlowEaseIn,
                        width: _width,
                        height: _sliderHeight,
                        color: Colors.transparent,
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              new TabBar(controller: tabController, tabs: [
                                new Tab(icon: const Icon(Icons.music_note)),
                                new Tab(icon: const Icon(Icons.font_download)),
                                new Tab(icon: const Icon(Icons.image))
                              ]),
                              Expanded(
                                  child: SizedBox(
                                      child: new TabBarView(
                                          controller: tabController,
                                          children: [
                                            new ListView.builder(
                                                itemCount: subtitle.length,
                                                itemBuilder: (BuildContext ctx, int index) {
                                                  return Padding(
                                                    padding:
                                                    EdgeInsets.fromLTRB(10, 4, 10, 4),
                                                    child: Container(
                                                        width: _width,
                                                        child: Text(subtitle[index],
                                                            style: TextStyle(
                                                                color: Colors.white70))),
                                                  );
                                                }),
                                            CustomScrollView(
                                              primary: false,
                                              slivers: <Widget>[
                                                SliverPadding(
                                                  padding: const EdgeInsets.all(20),
                                                  sliver: SliverGrid.count(
                                                      crossAxisSpacing: 10,
                                                      mainAxisSpacing: 10,
                                                      crossAxisCount: 3,
                                                      children: _layouts),
                                                ),
                                              ],
                                            ),
                                            CustomScrollView(
                                              primary: false,
                                              slivers: <Widget>[
                                                SliverPadding(
                                                  padding: const EdgeInsets.all(20),
                                                  sliver: SliverGrid.count(
                                                      crossAxisSpacing: 10,
                                                      mainAxisSpacing: 10,
                                                      crossAxisCount: 3,
                                                      children: _backgrounds),
                                                ),
                                              ],
                                            )
                                          ])))
                            ],
                          ),
                        ),
                      ),
//                      )
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }

  Widget _makeBackground(image){
    return
      GestureDetector(
        onTap: (){
          setState(() {
//            selectedTextstyle = font;
            backgroundImage = image;
            print(backgroundImage);
          });

        },
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(color: Colors.green,
              shape: BoxShape.rectangle,
              image: DecorationImage(
                  image: NetworkImage(image+"?w=160"),
                  fit: BoxFit.cover
              )
          ),


        ),
      )
    ;
  }

  Widget _fontView(fontStyle) {
    var font;
    switch (fontStyle["text"]) {
      case "lato":
        font =  TextStyle(color: Colors.white, fontSize: 40,fontFamily: "Lato");
        break;
      case "poiretOne":
        font =  TextStyle(color: Colors.white, fontSize: 40,fontFamily: "PoiretOne");
        break;
      case "monotone":
        font =  TextStyle(color: Colors.white, fontSize: 40,fontFamily: "Monoton");
        break;
      default:
        font =  TextStyle(color: Colors.white, fontSize: 40,fontFamily: "Lato");
    }

    return
      GestureDetector(
        onTap: (){
          setState(() {
            selectedTextstyle = font;
          });

        },
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: Colors.green),
          child: Text(
            fontStyle["text"],
            style: font,
          ),
        ),
      )
    ;
  }


  takeScreenShot(BuildContext context) async {
    RenderRepaintBoundary boundary =
    previewContainer.currentContext.findRenderObject();
    double pixelRatio = 800 / MediaQuery.of(context).size.width;
    ui.Image image = await boundary.toImage(pixelRatio: pixelRatio);
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData.buffer.asUint8List();
    setState(() {
      _image2 = Image.memory(pngBytes.buffer.asUint8List());
    });
    final directory = (await getApplicationDocumentsDirectory()).path;
    File imgFile = new File('$directory/screenshot.png');
    imgFile.writeAsBytes(pngBytes);
    final snackBar = SnackBar(
      content: Text('Saved to ${directory}'),
      action: SnackBarAction(
        label: 'Ok',
        onPressed: () {
          // Some code
        },
      ),
    );
    print("--done---");
    print(directory);
//    Scaffold.of(context).showSnackBar(snackBar);
  }


}
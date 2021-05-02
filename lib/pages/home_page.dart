import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isOpen = false;
  double alto = 50;
  double ancho = 200;
  double opacity = 1;
  late double drag;
  late double dragStart;
  late double altoOpen;
  late double anchoOpen;

  late double paddingTop;
  late double paddingLeft;
  late double paddingRight;
  late double paddingBottom;
  late double paddingTopOpen;
  late double paddingLeftOpen;
  late double paddingRightOpen;
  late double paddingBottomOpen;
  late double opacityButtonsOpen;
  late double opacityPipeOpen;

  @override
  void initState() {
    paddingTopOpen = 0;
    paddingLeftOpen = 0;
    paddingRightOpen = 0;
    paddingBottomOpen = 0;
    paddingBottom = 20;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    paddingTop = MediaQuery.of(context).size.height * 0.90;
    paddingLeft = MediaQuery.of(context).size.width * 0.33333333;
    paddingRight = MediaQuery.of(context).size.width * 0.3333333;
    return Material(
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  _buildHeader(),
                  Container(
                    padding: EdgeInsets.all(20),
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      'Recently played',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  _getBuildAlbum(
                      'assets/images/img1.png',
                      'assets/images/avatar.png',
                      'Crazy Compilations',
                      'Baby Come Back',
                      context),
                  _getBuildAlbum(
                      'assets/images/img2.png',
                      'assets/images/person2.png',
                      'Mortal Kombat Soundtrackz',
                      'MK',
                      context),
                  _getBuildAlbum(
                      'assets/images/img3.png',
                      'assets/images/avatar.png',
                      'Creamfield',
                      'Put your hands up',
                      context),
                  _getBuildAlbum(
                      'assets/images/img4.png',
                      'assets/images/person2.png',
                      'Tito el bambino live',
                      'Samarrea duro',
                      context),
                ],
              ),
            ),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 200),
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(
              top: isOpen ? 0 : paddingTop,
              left: isOpen ? paddingLeftOpen : paddingLeft,
              right: isOpen ? paddingRightOpen : paddingRight,
              bottom: isOpen ? paddingBottomOpen : paddingBottom,
            ),
            child: GestureDetector(
              onVerticalDragEnd: (details) {
                final primaryVelocity = details.primaryVelocity ?? 0;
                if (primaryVelocity < 0) {
                  isOpen = true;
                  altoOpen = MediaQuery.of(context).size.height * 0.6;
                  anchoOpen = MediaQuery.of(context).size.width;
                  paddingBottomOpen = 0;
                } else {
                  isOpen = false;
                }
                setState(() {});
              },
              onVerticalDragDown: (details) {
                drag = details.localPosition.dy;
              },
              onVerticalDragUpdate: (details) {
                dragStart = details.localPosition.dy;

                final dragAux = ((drag - dragStart) / 750).clamp(-0.4, 0.4);

                final baseAlto = MediaQuery.of(context).size.height * 0.6;

                final newAlto =
                    MediaQuery.of(context).size.height * (0.6 + dragAux);

                final closeConditionAlto =
                    MediaQuery.of(context).size.height * 0.4;

                final newAncho = MediaQuery.of(context).size.width *
                    (1 - (dragAux / 2).abs());

                final double newPaddingBottomOpen =
                    (dragAux.abs() * 50).clamp(0, 20);

                if (dragAux > 0) {
                  if (newAlto <= baseAlto) {
                    altoOpen = newAlto;
                    anchoOpen = newAncho;
                    opacityButtonsOpen = 1;
                    paddingBottomOpen = paddingBottom;
                  }
                } else if (newAlto <= closeConditionAlto) {
                  isOpen = false;
                } else {
                  altoOpen = newAlto;
                  anchoOpen = newAncho;
                  paddingBottomOpen = newPaddingBottomOpen;
                  opacityButtonsOpen =
                      (1 + (1 - (1 - (dragAux * 10)))).clamp(0, 1);
                  opacityPipeOpen = (1 + (1 - (1 - (dragAux * 5)))).clamp(0, 1);
                }

                setState(() {});
              },
              onTap: () {
                if (!isOpen) {
                  altoOpen = MediaQuery.of(context).size.height * 0.6;
                  anchoOpen = MediaQuery.of(context).size.width;
                  paddingBottomOpen = 0;
                  opacityButtonsOpen = 1;
                  opacityPipeOpen = 1;
                  isOpen = true;
                }
                setState(() {});
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  borderRadius: isOpen
                      ? BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        )
                      : BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(174, 82, 255, 1),
                      Color.fromRGBO(76, 101, 246, 1),
                      Color.fromRGBO(57, 129, 233, 1),
                    ],
                    begin: Alignment.centerLeft, //begin of the gradient color
                    end: Alignment.centerRight, //end of the gradient color
                  ),
                ),
                height: isOpen ? altoOpen : alto,
                width: isOpen ? anchoOpen : ancho,
                child: isOpen
                    ? AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        child: FittedBox(
                          alignment: Alignment.topCenter,
                          fit: BoxFit.none,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 20),
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(116, 81, 255, 1),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(50),
                                    topRight: Radius.circular(50),
                                  ),
                                ),
                                height: 8,
                                width: 40,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                height: MediaQuery.of(context).size.width * 0.4,
                                margin: EdgeInsets.only(top: 20),
                                child: Container(
                                  decoration: BoxDecoration(boxShadow: [
                                    BoxShadow(
                                      offset: Offset(0, 20),
                                      blurRadius: 5,
                                      spreadRadius: -10,
                                      color: Color.fromRGBO(33, 12, 170, 1),
                                    ),
                                  ]),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.asset(
                                      'assets/images/img1.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 30),
                                child: Text(
                                  'Lxst Cxst',
                                  style: TextStyle(
                                    color: Colors.white12,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Text(
                                  'Bloody Tear',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Opacity(
                                opacity: opacityPipeOpen,
                                child: Container(
                                  margin: EdgeInsets.only(top: 25),
                                  width: anchoOpen,
                                  height: altoOpen * 0.1,
                                  child: Center(
                                    child: Container(
                                      color: Colors.white,
                                      height: 40,
                                      width: 3,
                                    ),
                                  ),
                                ),
                              ),
                              Opacity(
                                opacity: opacityButtonsOpen,
                                child: Container(
                                  margin: EdgeInsets.only(top: 25),
                                  width: anchoOpen,
                                  height: altoOpen * 0.1,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Icons.queue_music_outlined,
                                        color: Colors.white,
                                        size: 40,
                                      ),
                                      Icon(
                                        Icons.pause_sharp,
                                        color: Colors.white,
                                        size: 40,
                                      ),
                                      Icon(
                                        Icons.people_outline,
                                        color: Colors.white,
                                        size: 40,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : _getMenuSmall(context),
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget _buildHeader() {
  return Container(
    width: double.infinity,
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 10),
          height: 200,
          color: Colors.white,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _getPersonsCard('assets/images/person1.png', 'EDX'),
              _getPersonsCard('assets/images/person2.png', 'David Guetta'),
              _getPersonsCard('assets/images/person3.png', 'Tiesto'),
              _getPersonsCard('assets/images/person4.png', 'Tito el bambino'),
            ],
          ),
        )
      ],
    ),
  );
}

Widget _getMenuSmall(BuildContext context) {
  return Stack(
    children: [
      Positioned(
        left: 20,
        top: 12,
        child: Container(
            child: Icon(Icons.file_copy_outlined, color: Colors.white)),
      ),
      Positioned(
        left: 50,
        top: 5,
        child: Container(
          height: 40,
          width: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset(
              'assets/images/img1.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      Positioned(
        left: 100,
        top: 12,
        child: Container(
          height: 25,
          width: 25,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset(
              'assets/images/avatar.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _getPersonsCard(String imgRoute, String namePerson) {
  return Column(
    children: [
      Container(
        height: 150,
        width: 150,
        padding: EdgeInsets.all(10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            imgRoute,
            fit: BoxFit.cover,
          ),
        ),
      ),
      Text(
        '$namePerson',
        style: TextStyle(fontSize: 15, color: Colors.black),
      )
    ],
  );
}

Widget _getBuildAlbum(String imgRoute, String imgAvatarRoute, String nameAlbum,
    String nameTheme, BuildContext context) {
  return Stack(
    children: [
      Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.width * 0.95,
        width: MediaQuery.of(context).size.width * 0.95,
        padding: EdgeInsets.all(10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            imgRoute,
            fit: BoxFit.cover,
          ),
        ),
      ),
      Positioned(
        top: MediaQuery.of(context).size.width * 0.85 / 10,
        left: MediaQuery.of(context).size.width * 0.85 / 2,
        child: CircleAvatar(
          child: ClipRRect(
            child: Image.asset(
              imgAvatarRoute,
            ),
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      ),
      Center(
        heightFactor: 9.52,
        child: Text(
          nameAlbum,
          style: TextStyle(
              color: Color.fromRGBO(44, 40, 57, 1),
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
      ),
      Center(
        heightFactor: 12,
        child: Text(
          nameTheme,
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    ],
  );
}

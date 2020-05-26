import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/cupertino.dart';

final Color darkBlue = Color.fromARGB(255, 18, 32, 47);

void main() {
  runApp(SpotifyAnimation());
}

class SpotifyAnimation extends StatefulWidget {
  @override
  _SpotifyAnimationState createState() => _SpotifyAnimationState();
}

class _SpotifyAnimationState extends State<SpotifyAnimation>
    with TickerProviderStateMixin {
  List<String> imageList = List.from([
    "https://newjams-images.scdn.co/v1/img/ab67616d0000b273eec93ac02189e6a2e93ddb21/tr/default.png",
    "https://i.scdn.co/image/ab67706f00000002272d6123c8962dc3107efeb6",
    "https://charts-images.scdn.co/REGIONAL_GLOBAL_DEFAULT.jpg",
    "https://dailymix-images.scdn.co/v1/img/09984b0aad71aadfa3e009cea2570b7d03339fa7/6/tr/default",
  ]);
  List<String> albumList = List.from([
    "Haftalık Keşif",
    "Mutlu Türkçe",
    "Global En İyi 50",
    "Sagopa Kajmer",
  ]);

  int selectedAlbum = 0;

  AnimationController animationController;
  AnimationController animationController2;
  AnimationController animationController3;
  Animation<double> animation;
  Animation<double> animation2;
  Animation<double> animation3;

  @override
  void initState() {
    super.initState();

    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    animationController2 =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    animationController3 = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));

    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.bounceIn,
      reverseCurve: Curves.easeOut,
    );

    animation2 = CurvedAnimation(
      parent: animationController2,
      curve: Curves.easeIn,
      reverseCurve: Curves.easeOut,
    );
    animation3 = CurvedAnimation(
      parent: animationController2,
      curve: Curves.bounceIn,
      reverseCurve: Curves.bounceOut,
    );

    animation.addStatusListener((d) {
      print(d.toString());
    });

//    animation.addListener(() {
//      print(animation.value.toString());
//    });

    animationController.repeat(reverse: true);
    animationController2.repeat(reverse: true);
    animationController3.repeat(reverse: true);
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
    animationController2.dispose();
    animationController3.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.blueGrey,
      home: Scaffold(
          backgroundColor: Color(0xff141414),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 500,
                    width: 500,
                    child: GridView.builder(
                      itemCount: 4,
                      padding: EdgeInsets.all(15),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          child: item(index),
                          onTap: () {
                            setState(() {
                              selectedAlbum = index;
                            });
                          },
                        );
                      },
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                    ),
                  )
                ],
              ),
            ],
          )),
    );
  }

  Widget item(int index) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xff404040), Color(0xff202020)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(imageList[index]),
                        fit: BoxFit.fill)),
              ),
              width: 80,
            ),
            Flexible(
              fit: FlexFit.loose,
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Text(
                  albumList[index],
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.white),
                ),
              ),
            ),
            index == selectedAlbum ? listenAnimation() : Container()
          ],
        ),
      ),
    );
  }

  Color animationColor = Color(0xff1DB954);

  Widget listenAnimation() {
    return Padding(
      padding: const EdgeInsets.only(right: 5),
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, _) {
          return Row(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: animationColor),
                width: 4,
                height: lerpDouble(5, 25, animation3.value),
              ),
              SizedBox(width: 2),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: animationColor),
                width: 4,
                height: lerpDouble(5, 25, animation2.value),
              ),
              SizedBox(width: 2),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: animationColor),
                width: 4,
                height: lerpDouble(5, 25, animation.value),
              ),
            ],
          );
        },
      ),
    );
  }
}

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:willow_app/model/data_list_model.dart';
import 'package:willow_app/utils/data_list.dart';

class CarouselScreen extends StatefulWidget {
  @override
  _CarouselScreenState createState() => _CarouselScreenState();
}

class _CarouselScreenState extends State<CarouselScreen> {
  int _currentIndex = 0;
  DataList mDataList = new DataList();
  List cardList = new List();
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    mDataList = DataList.fromJson(jsonData);
    print(mDataList.toString());

    for (int i = 0; i < mDataList.data.length; i++) {
      cardList.add(getSliderCardWidget(
        mDataList.data[i].picture,
        mDataList.data[i].title,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.purple);
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Container(
          child: Stack(
            children: [
              Positioned(
                top: 20,
                left: 10,
                right: 20,
                bottom: 20,
                child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.purple,
                      size: 20,
                    )),
              ),
//              SizedBox(
////                height: 50,
////              ),
              Container(
                child: Column(
                  children: [
                    CarouselSlider(
                      height: 500,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      pauseAutoPlayOnTouch: Duration(seconds: 10),
                      aspectRatio: 2.0,
                      onPageChanged: (index) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                      items: cardList.map((card) {
                        return Builder(builder: (BuildContext context) {
                          return Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25.0))),
                              child: card,
                            ),
                          );
                        });
                      }).toList(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: map<Widget>(cardList, (index, url) {
                        return Container(
                          width: 10.0,
                          height: 10.0,
                          margin: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 2.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentIndex == index
                                ? Colors.purple
                                : Colors.grey,
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  Widget getSliderCardWidget(String imageUrl, String description) {
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(25.0))),
      child: Card(
        elevation: 5.0,
        child: Column(
          children: [
            Image.network(
              imageUrl,
//                        "https://cdn.shopify.com/s/files/1/1595/8015/products/Milk_Bags_mom_baby.jpg?v=1616094876",
              fit: BoxFit.cover,
              height: 250,
            ),
            SizedBox(
              height: 24,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        description,
//                              "Meet the only disposable, spill-proof collection and storage Milk Bag.Our patented, no-spill technology lets you pump directly into self-sealing storage bags.",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
    );
  }
}

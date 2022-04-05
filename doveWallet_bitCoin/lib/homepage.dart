import 'package:dovewallet_bitcoin/walletpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;
import 'package:marquee_vertical/marquee_vertical.dart';
import 'package:url_launcher/url_launcher.dart';

import 'models/carousel_model.dart';

class HomePage extends StatefulWidget {
  //const HomePage({Key key, this.title}) : super(key: key);
  HomePage({this.title});
  final String? title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _current = 0;

  // 현재 작업하고 있는 더 보기 관련
  List<String> doveTitle = [];
  List<dynamic> doveLink = [];

  // Top4에 보일 Card
  List<String> currency_01 = [];

  void _fetchDoveTitle() async {
    final response =
        await http.get(Uri.parse("https://medium.com/dovewallet-ko"));
    dom.Document document = parser.parse(response.body);

    final elements =
        document.getElementsByClassName('u-lineHeightBase postItem');
    //debugPrint('elements:==========================>>> $elements');

    /* for (int i = 0; i < elements.length; i++) {
      debugPrint('78777777');
      debugPrint('elements[i]222:==========================>>> $elements[i]');
    }*/

    // 젤 위에거
    // Copy css selector를 통해서 정확한 class를 뽑아낸다.
    final linkElement = document.getElementsByClassName(
        'col u-xs-marginBottom10 u-paddingLeft0 u-paddingRight0 u-paddingTop15 u-marginBottom30');

    setState(() {
      doveTitle = elements
          .map((element) => element.getElementsByTagName("span")[0].innerHtml)
          .toList();

      //debugPrint('doveTitle:==========================>>> $doveTitle');

      doveLink = linkElement
          .map((element) =>
              element.getElementsByTagName("a")[0].attributes['href'])
          .toList();
    });
  }

  void _fetchTop4() async {
    //https://dovewallet.kr/ko
    //https://dovewallet.kr/ko/bonus-distribution-history

    final response = await http
        .get(Uri.parse("https://dovewallet.kr/ko/bonus-distribution-history"));
    dom.Document document = parser.parse(response.body);

    //final elements = document.getElementsByClassName('cell__contentWrapper');
    // div#__layout div:nth-child(1) > div > div.bonusHistoryDistTable__currencySymbol.cell.cell--leftAlignedColumn > div.cell__contentWrapper > span
    /*var test =
        document.getElementsByClassName('cell__contentWrapper')[0].innerHtml;
*/
    debugPrint('11111');

    /*final elements = document.querySelector(
        'div#__layout div:nth-child(1) > div > div.bonusHistoryDistTable__currencySymbol.cell.cell--leftAlignedColumn > div.cell__contentWrapper > span');
*/
    final elements =
        document.querySelectorAll("#cell__contentWrapper div:nth-child(1)");

    debugPrint('22222');

    debugPrint('elements_fetchTop4:==========================>>> $elements');

    /*  for (int i = 0; i < elements.length; i++) {
      debugPrint('33333');
      debugPrint('elements[i]:==========================>>> $elements[i]');
    }
*/
    //    test_result = [];
    //
    /*for (var i = 0; i < elements.length; i++) {
      //debugPrint(elements[i].innerHTML);
      test_result.push(elements[i].innerHtml);
    }*/

    /* elements.forEach((element) {
      currency_01 = element['title'];
      currency_01.add('$title');

      debugPrint('currency_01:==========================>>> $currency_01');
    });*/

    setState(() {
      /* currency_01 = document
          .querySelectorAll('.dailyBonusCoin__full span')
          .map((e) => e.getElementsByTagName("span")[0].innerHtml)
          .toList();*/

      currency_01 = elements
          .map((element) => element.getElementsByTagName("span")[0].innerHtml)
          .toList();

      debugPrint('currency_01:==========================>>> $currency_01');
    });
  }

  //final webScraper = WebScraper('https://dovewallet.kr/ko');

  // Response of getElement is always List<Map<String, dynamic>>
  /*List<Map<String, dynamic>>? productNames;

  void fetchProducts() async {
    // Loads web page and downloads into local state of library
    if (await webScraper.loadWebPage('/bonus-distribution-history')) {
      setState(() {
        // getElement takes the address of html tag/element and attributes you want to scrap from website
        // it will return the attributes in the same order passed
        productNames =
            webScraper.getElementTitle('cell__contentWrapper');

        debugPrint('productNames:==========================>>> $productNames');
      });
    }
  }*/

  @override
  void initState() {
    super.initState();
    //_getDataFromWeb();
    _fetchDoveTitle();
    _fetchTop4();
    //fetchProducts();
    //initChaptersTitleScrap();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Container(
              child: ListView(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    //margin: EdgeInsets.only(left: 10, right: 10),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 150,
                          child: Swiper(
                            onIndexChanged: (index) {
                              setState(() {
                                _current = index;
                              });
                            },
                            autoplay: true,
                            layout: SwiperLayout.DEFAULT,
                            itemCount: carousels.length,
                            itemBuilder: (BuildContext context, index) {
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                      image: AssetImage(
                                        carousels[index].image,
                                      ),
                                      fit: BoxFit.cover),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            //WalletPage(),
            Container(
              height: 180,
              width: 180,
              margin: EdgeInsets.only(left: 5, right: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey, width: 2)),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  children: [
                    //Expanded 사용
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: ImageIcon(
                        AssetImage("assets/images/icon_main_savings.png"),
                        //color: Colors.white,
                        size: 40,
                      ),
                      label: Text('예치'),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        padding:
                            //EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            //EdgeInsets.all(10),
                            EdgeInsets.fromLTRB(10, 10, 10, 0),
                        //EdgeInsets.only(left: 5, top: 10, right: 5, bottom: 5),
                        side: BorderSide(width: 1, color: Colors.grey),
                      ),
                    ),
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: ImageIcon(
                        AssetImage("assets/images/icon_main_trade.png"),
                        //color: Colors.white,
                        size: 40,
                      ),
                      label: Text('거래'),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        padding:
                            //EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            //EdgeInsets.all(10),
                            EdgeInsets.fromLTRB(10, 10, 10, 0),
                        //EdgeInsets.only(left: 5, top: 10, right: 5, bottom: 5),
                        side: BorderSide(width: 1, color: Colors.grey),
                      ),
                    ),
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: ImageIcon(
                        AssetImage("assets/images/icon_main_bonus.png"),
                        //color: Colors.white,
                        size: 40,
                      ),
                      label: Text('보너스'),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        padding:
                            //EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            //EdgeInsets.all(10),
                            EdgeInsets.fromLTRB(10, 10, 10, 0),
                        //EdgeInsets.only(left: 5, top: 10, right: 5, bottom: 5),
                        side: BorderSide(width: 1, color: Colors.grey),
                      ),
                    ),
                    SizedBox(height: 80),
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: ImageIcon(
                        AssetImage("assets/images/icon_main_tipping.png"),
                        //color: Colors.white,
                        size: 40,
                      ),
                      label: Text('티핑'),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        padding:
                            //EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            //   EdgeInsets.all(10),
                            EdgeInsets.fromLTRB(10, 10, 10, 0),
                        //EdgeInsets.only(left: 5, top: 10, right: 5, bottom: 5),
                        side: BorderSide(width: 1, color: Colors.grey),
                      ),
                    ),
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: ImageIcon(
                        AssetImage("assets/images/icon_main_staking.png"),
                        //color: Colors.white,
                        size: 40,
                      ),
                      label: Text('스테이킹'),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        padding:
                            //EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            //   EdgeInsets.all(10),
                            EdgeInsets.fromLTRB(10, 10, 10, 0),
                        //EdgeInsets.only(left: 5, top: 10, right: 5, bottom: 5),
                        side: BorderSide(width: 1, color: Colors.grey),
                      ),
                    ),
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: ImageIcon(
                        AssetImage("assets/images/icon_main_school.png"),
                        //color: Colors.white,
                        size: 40,
                      ),
                      label: Text('학교'),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        padding:
                            //EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            //   EdgeInsets.all(10),
                            EdgeInsets.fromLTRB(10, 10, 10, 0),
                        //EdgeInsets.only(left: 5, top: 10, right: 5, bottom: 5),
                        side: BorderSide(width: 1, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 40),
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    height: 60,
                    width: 380,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.cyanAccent,
                    ),
                  ),
                  Container(
                      height: 90,
                      child: MarqueeVertical(
                        itemCount: doveTitle.length,
                        lineHeight: 100,
                        marqueeLine: 2,
                        direction: MarqueeVerticalDirection.moveUp,
                        itemBuilder: (index) {
                          return Column(
                            children: [
                              Row(children: [
                                // const Icon(Icons.access_alarm),
                                Expanded(
                                  child: Text(
                                    doveTitle[index],
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                                Expanded(child: GestureDetector(
                                  onTap: () async {
                                    dynamic url = doveLink[index];
                                    // print("url:==============>>>" + url);
                                    if (await canLaunch(url)) {
                                      await launch(
                                        url,
                                        forceSafariVC: true,
                                        forceWebView: true,
                                        enableJavaScript: true,
                                      );
                                    } else {
                                      throw 'could not launch $url';
                                    }
                                  },
                                ))
                              ]),
                            ],
                          );
                        },
                        scrollDuration: const Duration(microseconds: 300),
                        stopDuration: const Duration(seconds: 3),
                      )),
                  Container(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new InkWell(
                        child: new Text('더보기'),
                        onTap: () => launch('https://medium.com/dovewallet-ko'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    height: 400,
                    width: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.cyanAccent,
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: const Text(
                                  '오늘의 일일 보너스',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: const Text(
                                  '매일매일 자산이 쑥쑥! 입금만 해도 거래 수수료의 일부가 보너스로 배분됩니다',
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Center(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      minimumSize: Size(350, 40)),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => WalletPage()),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      '입금하고 보너스 받기',
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Stack(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      alignment: Alignment.topLeft,
                                      child: SvgPicture.asset(
                                        'assets/icon_bonus_flag.svg',
                                        //'https://dovewallet.kr/images/icon_bonus_flag.svg',
                                        width: 70,
                                        height: 32,
                                        //allowDrawingOutsideViewBox: true,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Container(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        'TOP 4',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              /* height: 200,
                              width: 120,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: Colors.black, width: 2)),*/
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 140,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: 6,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            height: 100,
                                            width: 100,
                                            margin: EdgeInsets.all(10),
                                            child: Center(
                                              child: Text(currency_01[index]),
                                            ),
                                            color: Colors.blue,
                                          );
                                        }),
                                  )
                                ],
                              ),
                            ),
                          ],
                        )),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 70),
          ],
        ),
      ),
    );
  }
}

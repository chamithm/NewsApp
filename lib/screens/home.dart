import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/screens/top_news.dart';
import '../ui_models/message_dialog.dart';
import '../ui_models/my_text_field.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

late TextEditingController search;

class _HomeState extends State<Home> {
  Map topNews = {};

  @override
  void initState() {
    search = TextEditingController();

    getTopNews();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                    child: MyTextField(
                        type: MyTextFieldTypes.all,
                        controller: search,
                        label: 'Search',
                        suffix: Icon(Icons.search,size: 20,color: Colors.black54,),
                        maxLength: 30)
                        .get(),
                  ),
                ),
                MaterialButton(
                  onPressed: () {},
                  color: Colors.red,
                  textColor: Colors.white,
                  child: Icon(
                    Icons.search,
                    size: 16,
                  ),
                  padding: EdgeInsets.all(6),
                  shape: CircleBorder(),
                )
              ],
            ),
            Expanded(
              child: DefaultTabController(
                length: 2,
                child: Column(
                  children: <Widget>[
                    ButtonsTabBar(
                      backgroundColor: Colors.red,
                      unselectedBackgroundColor: Colors.grey[50],
                      unselectedBorderColor: Colors.grey[400]!,
                      borderWidth: 1,
                      radius: 20,
                      height: 35,
                      borderColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                      labelStyle: GoogleFonts.titilliumWeb(
                        fontSize: 12,
                        color: Colors.white,),
                      unselectedLabelStyle: GoogleFonts.titilliumWeb(
                        fontSize: 12,
                        color: Colors.black,),
                      tabs: const [
                        Tab(
                          text: "Top News",
                        ),
                        Tab(
                          text: "Breaking News",
                        ),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: <Widget>[
                          topNews.isNotEmpty ? TopNews(topNews) : const CircularProgressIndicator(),
                          Center(
                            child: Icon(Icons.directions_transit),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      )
    );
  }

  Future getTopNews() async {//2d909cb9ebfa436b9dea5d0247314ee4
    try {
      Response response;
      var dio = Dio();
      response = await dio.get('https://newsapi.org/v2/everything?q=bitcoin&apiKey=2d909cb9ebfa436b9dea5d0247314ee4',);
      if (response.statusCode == 200) {
        if (mounted) {
          setState(() {
            topNews = response.data;
          });
        }
      }
    } on DioError catch (e) {
      print(e);
      print(e.message);

      if (e.response!.statusCode == 401) {
        showDialog(
            context: context,
            builder: (context) => Center(
                child: MyMessageDialog(
                    context: context,
                    isError: true,
                    massage: 'Session Expired !\nPlease log in')
                    .get()));
      } else if (e.response!.statusCode == 500) {
        showDialog(
            context: context,
            builder: (context) => Center(
                child: MyMessageDialog(
                    context: context,
                    isError: true,
                    massage: 'Server Error !')
                    .get()));
      } else {
        showDialog(
            context: context,
            builder: (context) => Center(
                child: MyMessageDialog(
                    context: context,
                    isError: true,
                    massage: 'Unexpected Error !')
                    .get()));
      }
    }
  }
}

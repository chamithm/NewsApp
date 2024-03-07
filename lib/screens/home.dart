import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/screens/top_news.dart';
import '../controllers/home_controller.dart';
import '../ui_models/message_dialog.dart';
import '../ui_models/my_text_field.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import 'package:get/get.dart' hide Response;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

late TextEditingController search;

class _HomeState extends State<Home> {
  var homeController = Get.put(HomeController());

  Map topNews = {};
  List<Map<String, dynamic>> languages = [];
  List<Map<String, dynamic>> countries = [];

  @override
  void initState() {
    search = TextEditingController();

    getTopNews();

    super.initState();
  }

  @override
  void dispose() {
    Get.delete<HomeController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(height: 15,),
            Row(
              children: [
                Expanded(
                  child: GetX<HomeController>(
                    builder: (cont) {
                      return Container(
                        padding: const EdgeInsets.fromLTRB(12, 5, 0, 5),
                        child: MyTextField(
                            type: cont.tabIndex.value == 0 ? MyTextFieldTypes.all : MyTextFieldTypes.disabled,
                            controller: search,
                            label: 'Search',
                            suffix: const Icon(Icons.search,size: 20,color: Colors.black54,),
                            maxLength: 30)
                            .get(),
                      );
                    }
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: InkWell(
                    onTap: (){
                      if(search.text.isNotEmpty){
                        homeController.topNewsTitle.value = search.text;
                        getSearchNews(search.text);
                      }else{
                        homeController.topNewsTitle.value = "Top News";
                      }
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      child: Icon(Icons.search, size: 18,color: Colors.white,),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(50))
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10,),
            Expanded(
              child: DefaultTabController(
                length: 6,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0,right: 12.0),
                      child: ButtonsTabBar(
                        backgroundColor: Colors.red,
                        unselectedBackgroundColor: Colors.grey[50],
                        unselectedBorderColor: Colors.grey[400]!,
                        borderWidth: 1,
                        radius: 20,
                        height: 40,
                        borderColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
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
                          Tab(
                            text: "Top Headline",
                          ),
                          Tab(
                            text: "Healthy",
                          ),
                          Tab(
                            text: "Technology",
                          ),
                          Tab(
                            text: "Finance",
                          ),
                        ],
                        onTap: (index){
                          homeController.tabIndex.value = index;
                          search.clear();
                          if(index == 0){
                            getTopNews();
                          }else if(index == 1){
                            getSearchNews("Breaking News");
                          }else if(index == 2){
                            getHeadLines();
                          }else if(index == 3){
                            getSearchNews("Healthy");
                          }else if(index == 4){
                            getSearchNews("Technology");
                          }else if(index == 5){
                            getSearchNews("Finance");
                          }
                        },
                      ),
                    ),
                    Expanded(
                      child: GetX<HomeController>(
                        builder: (cont) {
                          return TabBarView(
                            children: <Widget>[
                              !cont.isLoading.value ? TopNews(topNews,cont.topNewsTitle.value) : const Center(child: CircularProgressIndicator(color: Colors.blue,)),
                              !cont.isLoading.value  ? TopNews(topNews,"Breaking News") : const Center(child: CircularProgressIndicator(color: Colors.blue,)),
                              !cont.isLoading.value  ? TopNews(topNews,"Top Headlines") : const Center(child: CircularProgressIndicator(color: Colors.blue,)),
                              !cont.isLoading.value ? TopNews(topNews,"Healthy") : const Center(child: CircularProgressIndicator(color: Colors.blue,)),
                              !cont.isLoading.value  ? TopNews(topNews,"Technology") : const Center(child: CircularProgressIndicator(color: Colors.blue,)),
                              !cont.isLoading.value  ? TopNews(topNews,"Finance") : const Center(child: CircularProgressIndicator(color: Colors.blue,)),
                            ],
                          );
                        }
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future getTopNews() async {
    homeController.isLoading.value = true;
    try {
      Response response;
      var dio = Dio();
      response = await dio.get('https://newsapi.org/v2/everything?q=bitcoin&apiKey=2d909cb9ebfa436b9dea5d0247314ee4',);
      if (response.statusCode == 200) {
        if (mounted) {
          topNews = response.data;
          homeController.isLoading.value = false;
        }
      }
    } on DioError catch (e) {
      print(e);
      print(e.message);

      homeController.isLoading.value = false;

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

  Future getSearchNews(String text) async {
    homeController.isLoading.value = true;
    try {
      Response response;
      var dio = Dio();
      response = await dio.get('https://newsapi.org/v2/everything?q=$text&apiKey=2d909cb9ebfa436b9dea5d0247314ee4',);
      if (response.statusCode == 200) {
        if (mounted) {
          topNews = response.data;
          homeController.isLoading.value = false;
        }
      }
    } on DioError catch (e) {
      print(e);
      print(e.message);

      homeController.isLoading.value = false;

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

  Future getHeadLines() async {
    homeController.isLoading.value = true;
    try {
      Response response;
      var dio = Dio();
      response = await dio.get('https://newsapi.org/v2/top-headlines?country=us&apiKey=2d909cb9ebfa436b9dea5d0247314ee4',);
      if (response.statusCode == 200) {
        if (mounted) {
          topNews = response.data;
          homeController.isLoading.value = false;
        }
      }
    } on DioError catch (e) {
      print(e);
      print(e.message);

      homeController.isLoading.value = false;

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

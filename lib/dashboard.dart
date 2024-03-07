import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/screens/home.dart';
import 'package:newsapp/screens/profile.dart';
import 'package:get/get.dart' hide Response;

import 'controllers/dashboard_controller.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> with SingleTickerProviderStateMixin{
  var dashboardController = Get.put(DashboardController());

  late TabController tabController;
  final List<Color> colors = [Colors.yellow, Colors.red, Colors.green, Colors.blue, Colors.pink];

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    tabController.animation!.addListener(() {
        final value = tabController.animation!.value.round();
        if (value != dashboardController.currentPage.value && mounted) {
          changePage(value);
        }
      },
    );
    super.initState();
  }

  void changePage(int newPage) {
    dashboardController.currentPage.value = newPage;
  }

  @override
  void dispose() {
    tabController.dispose();
    Get.delete<DashboardController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BottomBar(
        fit: StackFit.expand,
        icon: (width, height) => Center(
          child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: null,
            icon: Icon(
              Icons.arrow_upward_rounded,
              color: Colors.black,
              size: width,
            ),
          ),
        ),
        borderRadius: BorderRadius.circular(500),
        duration: Duration(seconds: 1),
        curve: Curves.decelerate,
        showIcon: true,
        width: MediaQuery.of(context).size.width * 0.8,
        barColor: Colors.white,
        start: 2,
        end: 0,
        offset: 10,
        barAlignment: Alignment.bottomCenter,
        iconHeight: 35,
        iconWidth: 35,
        reverse: false,
        hideOnScroll: true,
        scrollOpposite: false,
        onBottomBarHidden: () {},
        onBottomBarShown: () {},
        child: TabBar(
          indicatorPadding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
          controller: tabController,
          indicator: const UnderlineTabIndicator(
              borderSide: BorderSide(color: Colors.red,width: 0),
              insets: EdgeInsets.fromLTRB(16, 0, 16, 8)
          ),
          tabs: [
            GetX<DashboardController>(
              builder: (cont) {
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: SizedBox(
                    height: 40,
                    width: 40,
                    child: Center(
                        child: Column(
                          children: [
                            Icon(
                              Icons.home_outlined,
                              size: 22,
                              color: cont.currentPage.value == 0 ? Colors.red : Colors.grey[400],
                            ),
                            Text(
                              "Home",
                              style: GoogleFonts.titilliumWeb(
                                  fontSize: 10,
                                  color: cont.currentPage.value == 0 ? Colors.black87 : Colors.grey[400],
                                  fontWeight: FontWeight.w600
                              ),
                            )
                          ],
                        )),
                  ),
                );
              }
            ),
            GetX<DashboardController>(
              builder: (cont) {
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: SizedBox(
                    height: 40,
                    width: 40,
                    child: Center(
                        child: Column(
                          children: [
                            Icon(
                              Icons.favorite_border,
                              size: 22,
                              color: cont.currentPage.value == 1 ? Colors.red : Colors.grey[400],
                            ),
                            Text(
                              "Favorite",
                              style: GoogleFonts.titilliumWeb(
                                  fontSize: 10,
                                  color: cont.currentPage.value == 1 ? Colors.black87 : Colors.grey[400],
                                  fontWeight: FontWeight.w600
                              ),
                            )
                          ],
                        )),
                  ),
                );
              }
            ),
            GetX<DashboardController>(
              builder: (cont) {
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: SizedBox(
                    height: 40,
                    width: 40,
                    child: Center(
                        child: Column(
                          children: [
                            Icon(
                              CupertinoIcons.smiley,
                              size: 22,
                              color: cont.currentPage.value == 2 ? Colors.red : Colors.grey[400],
                            ),
                            Text(
                              "Profile",
                              style: GoogleFonts.titilliumWeb(
                                  fontSize: 10,
                                  color: cont.currentPage.value == 2 ? Colors.black87 : Colors.grey[400],
                                  fontWeight: FontWeight.w600
                              ),
                            )
                          ],
                        )),
                  ),
                );
              }
            ),
          ],
        ),
        body: (context, controller) => TabBarView(
          controller: tabController,
          physics: const BouncingScrollPhysics(),
          children: [
            const Home(),
            Container(),
            const Profile(),
          ],
        ),
      ),
    );
  }
}

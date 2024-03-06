import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TopNews extends StatefulWidget {
  Map topNews;
  TopNews(this.topNews,{Key? key}) : super(key: key);

  @override
  State<TopNews> createState() => _TopNewsState();
}

class _TopNewsState extends State<TopNews> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Row(
              children: [
                Text(
                  "About ${widget.topNews['totalResults']} result for ",
                  style: GoogleFonts.titilliumWeb(
                    fontSize: 13,
                    color: Colors.black,),
                ),
                Text(
                  "Top news",
                  style: GoogleFonts.titilliumWeb(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.italic
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.topNews['totalResults'],
              itemBuilder: (context,index){
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 120,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(widget.topNews['articles'][index]['urlToImage'],fit: BoxFit.fitWidth,),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.grey[900]!.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                widget.topNews['articles'][index]['title'],
                                textAlign: TextAlign.start,
                                style: GoogleFonts.titilliumWeb(
                                    color: Colors.grey[200],
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 12.0,bottom: 8),
                                  child: Text(
                                    widget.topNews['articles'][index]['author'],
                                    style: GoogleFonts.titilliumWeb(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey[200],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 12.0,bottom: 8),
                                  child: Text(
                                    DateFormat('EEEE, d MMMM yyyy').format(
                                      DateTime.parse(widget.topNews['articles'][index]['publishedAt'])
                                    ),
                                    style: GoogleFonts.titilliumWeb(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey[200],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
            ),
          ),
        ],
      ),
    );
  }
}

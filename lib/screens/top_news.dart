import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'news_details.dart';

class TopNews extends StatefulWidget {
  Map topNews;
  String title;
  TopNews(this.topNews,this.title,{Key? key}) : super(key: key);

  @override
  State<TopNews> createState() => _TopNewsState();
}

class _TopNewsState extends State<TopNews> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 15,),
        Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: Row(
            children: [
              Text(
                "About ${widget.topNews['totalResults']} result for ",
                style: GoogleFonts.titilliumWeb(
                  fontSize: 12,
                  color: Colors.black,
                  fontWeight: FontWeight.w500
                ),
              ),
              Text(
                widget.title,
                style: GoogleFonts.titilliumWeb(
                  fontSize: 13,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.italic
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6,),
        Expanded(
          child: ListView.builder(
            itemCount: widget.topNews['totalResults'],
            itemBuilder: (context,index){
              return Padding(
                padding: const EdgeInsets.only(left: 14.0,right: 14.0,top: 4.0,bottom: 4.0),
                child: InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewsDetails(widget.topNews['articles'][index])));
                  },
                  child: Stack(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 140,
                        child: widget.topNews['articles'][index]['urlToImage'] != null ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            widget.topNews['articles'][index]['urlToImage'],fit: BoxFit.fitWidth,
                            loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  color: Colors.blue,
                                  value: loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                            errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                              return const Center(child: Text('Failed to load image.'));
                            },
                          ),
                        ) : const SizedBox(),
                      ),
                      Container(
                        width: double.infinity,
                        height: 140,
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
                                  child: SizedBox(
                                    width: 120,
                                    child: Text(
                                      widget.topNews['articles'][index]['author'] ?? "",
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.titilliumWeb(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey[200],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 12.0,bottom: 8),
                                  child: Text(
                                      widget.topNews['articles'][index]['publishedAt'] != null ? DateFormat('EEEE, d MMMM yyyy').format(
                                      DateTime.parse(widget.topNews['articles'][index]['publishedAt'])
                                    ) : "",
                                    textAlign: TextAlign.end,
                                    style: GoogleFonts.titilliumWeb(
                                      fontSize: 11,
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
                ),
              );
            }
          ),
        ),
      ],
    );
  }
}

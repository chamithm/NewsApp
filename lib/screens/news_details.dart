import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class NewsDetails extends StatefulWidget {
  Map newsDetails;
  NewsDetails(this.newsDetails,{Key? key}) : super(key: key);

  @override
  State<NewsDetails> createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Image.network(
                      widget.newsDetails['urlToImage'],fit: BoxFit.fitWidth,
                      alignment: Alignment.topCenter,
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
                  ),
                  Positioned(
                    top: 20,
                    left: 15,
                    child: InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: const BorderRadius.all(Radius.circular(5))
                        ),
                        child: Icon(Icons.arrow_back_ios_new_outlined,size: 15,color: Colors.black87,),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 180,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0,top: 120,right: 12.0),
                        child: Text(
                          "${widget.newsDetails['description'] ?? ""} ${widget.newsDetails['content'] ?? ""}",
                          style: GoogleFonts.titilliumWeb(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 130,
                    left: 45,
                    right: 45,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter, // Start the gradient from the top
                            end: Alignment.bottomCenter, // End the gradient at the bottom
                            colors: [
                              Colors.grey[500]!, // Top color
                              Colors.grey[200]!, // Bottom color
                            ],
                            // You can add more colors to create more complex gradients
                          ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0,top: 8.0,bottom: 12),
                            child: Text(
                              widget.newsDetails['publishedAt'] != null ? DateFormat('EEEE, d MMMM yyyy').format(
                                  DateTime.parse(widget.newsDetails['publishedAt'])
                              ) : "",
                              style: GoogleFonts.titilliumWeb(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0,right: 12.0,bottom: 12),
                            child: Text(
                              widget.newsDetails['title'] ?? "",
                              style: GoogleFonts.titilliumWeb(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0,bottom: 8,right: 12.0),
                            child: Text(
                              widget.newsDetails['author'] ?? "",
                              style: GoogleFonts.titilliumWeb(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ),
    );
  }
}

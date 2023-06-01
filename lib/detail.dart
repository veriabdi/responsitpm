import 'package:flutter/material.dart';
import 'fetching.dart';
import 'package:url_launcher/url_launcher.dart';
class detail extends StatefulWidget {
  final String id;
  const detail({Key? key, required this.id}) : super(key: key);

  @override
  State<detail> createState() => _detailState();
}

class _detailState extends State<detail> {
  late List<dynamic> detail=[];
  @override
  void initState() {
    super.initState();
    detail = [];

    getDetail.fetchDetail(widget.id).then((data) {
      setState(() {
        detail = data;
      });
    }).catchError((error) {
      print(error);
    });
  }
  Future<void> _launchURL(String link) async {
    if (await canLaunch(link)) {
      await launch(link);
    } else {
      throw 'Tidak dapat meluncurkan $link';
    }
  }

  @override
  Widget build(BuildContext context) {
    final Uri youtubeUri = Uri.parse(detail[0]['strYoutube']);
    return Scaffold(
      appBar: AppBar(
        title: Text(detail[0]['strMeal']),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20, bottom: 20),
              alignment: Alignment.center,
              height: 350,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(detail[0]['strMealThumb']),
              ),
            ),
            Center(
              child: Text(
                detail[0]['strMeal'],
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 8,top: 8
                ), // Atur jarak padding sesuai kebutuhan
                child: Text('Kategori : ' + detail[0]['strCategory']),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 8,top: 5), // Atur jarak padding sesuai kebutuhan
                child: Text('Area : ' + detail[0]['strArea']),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              width: 380,
              child:
              Text(detail[0]['strInstructions'],
              style: TextStyle(

              ),textAlign: TextAlign.justify,),
            ),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: (){
              launchUrl(youtubeUri);

            },
                child: Text("Youtube")),
            SizedBox(height: 50,)

          ],
        ),

      ),
    );
  }
}

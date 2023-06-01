import 'package:flutter/material.dart';
import 'package:responsi_123200048/meals.dart';
import 'fetching.dart';

class kategori extends StatefulWidget {
  const kategori({Key? key}) : super(key: key);

  @override
  State<kategori> createState() => _kategoriState();
}

class _kategoriState extends State<kategori> {
  late List<dynamic> kategori=[];
  @override
  void initState() {
    super.initState();
    kategori = [];

    getCategories.fetchcategories().then((data) {
      setState(() {
        kategori = data;
      });
    }).catchError((error) {
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kategori"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: kategori.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => meals(title: kategori[index]['strCategory'],)));
            },
            child:
            Card(
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 20),
                    height: 100,
                    child:
                    Image.network(kategori[index]['strCategoryThumb']),
                  ),
                  Text(kategori[index]['strCategory'],
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),)
                ],
              ),
            ),
          );
        },
      ),
    );



  }
}


import 'package:flutter/material.dart';
import 'package:responsi_123200048/detail.dart';
import 'fetching.dart';
class meals extends StatefulWidget {
  final String title;
  const meals({Key? key, required this.title}) : super(key: key);

  @override
  State<meals> createState() => _mealsState();
}

class _mealsState extends State<meals> {

  late List<dynamic> Meals=[];
  @override
  void initState() {
    super.initState();
    Meals = [];
    getFood.fetchFood(widget.title).then((data) {
      setState(() {
        Meals = data;
      });
    }).catchError((error) {
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: Meals.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => detail(id: Meals[index]['idMeal'],)));

            },
            child:
            Card(
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 20,left: 10),
                    height: 150,
                    child: Image.network(Meals[index]['strMealThumb']),
                  ),
                  Expanded(
                    child: Text(
                      Meals[index]['strMeal'],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      softWrap: true, // Teks akan melanjutkan ke baris baru jika tidak cukup lebar
                    ),
                  ),
                ],
              ),
            ),

          );
        },
      ),
    );
  }
}

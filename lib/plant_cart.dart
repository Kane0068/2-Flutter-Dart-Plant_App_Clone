import 'package:flutter/material.dart';
import 'package:flutter_pant_app/home_page.dart';
import 'package:flutter_pant_app/models/database.dart';
import 'package:flutter_pant_app/models/plants.dart';

class PlantCart extends StatefulWidget {
  const PlantCart({Key? key}) : super(key: key);

  @override
  State<PlantCart> createState() => _PlantCartState();
}

class _PlantCartState extends State<PlantCart> {
  MyDb myDb = MyDb(); // -18
  List<Map> plantLists = []; //-19
  @override
  void initState() {
    //-20
    myDb.open();
    getPlantData();
    super.initState();
  }

  void getPlantData() {
    //-21
    Future.delayed(const Duration(milliseconds: 1000), () async {
      plantLists = await myDb.db!.rawQuery("SELECT * FROM plants");
      setState(() {});
    });
  }

  @override
  void dispose() {
    //-22

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // seçilen ürünlerin toplamını bulacaz**************************************************
    num total = plantLists.fold(0, (prev, value) => prev + value["price"]);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: (){
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context)=> HomePage())
            );
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        elevation: 0.0,
        title: Text(
          "My Cart",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          plantCartContainer(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    Text(
                      "\$ $total",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 35,
                      width: 155,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 2, color: Colors.tealAccent.shade700),
                          borderRadius: BorderRadius.circular(5)),
                      child: OutlinedButton(
                        onPressed: () {},
                        child: Text(
                          "Add More",
                          style: TextStyle(color: Colors.tealAccent.shade700),
                        ),
                      ),
                    ),
                    Container(
                      height: 35,
                      width: 155,
                      decoration: BoxDecoration(
                          color: Colors.tealAccent.shade700,
                          border: Border.all(
                              width: 2, color: Colors.tealAccent.shade700),
                          borderRadius: BorderRadius.circular(5)),
                      child: OutlinedButton(
                        onPressed: () {},
                        child: Text(
                          "Checkout",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget plantCartContainer() => Container(
        height: 480,
        color: Colors.grey.shade100,
        child: ListView(
          // select all data from database and drop here as list
          children: plantLists.map((plant) {
            //-23
            return Container(
              height: 130,
              padding: EdgeInsets.all(12),
              margin: EdgeInsets.fromLTRB(20, 15, 20, 0),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  imageWidget(plant),
                  cartDetails(plant),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await myDb.db!.rawDelete("DELETE FROM plants WHERE id =?",[plant["id"]]);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.teal,
                            content: Text(
                              "New delete to the Cart",
                              style: TextStyle(
                                color: Colors.white
                              ),
                            ),
                          ));
                        },
                        child: Icon(
                          Icons.delete_outline,
                          color: Colors.grey,
                          size: 28,
                        ),
                      ),
                      Text(
                        "\$ ${plant["price"]}",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 25),
                      )
                    ],
                  )
                ],
              ),
            );
          }).toList(),
        ),
      );
  Widget cartDetails(Map<dynamic, dynamic> plant) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              plant["plant"],
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            Text(
              "It's spine is toxic",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(5)),
              child: Icon(
                Icons.remove,
                color: Colors.black,
                size: 15,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "1",
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(5)),
              child: Icon(
                Icons.add,
                color: Colors.black,
                size: 15,
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget imageWidget(Map<dynamic, dynamic> plant) {
    return Container(
      height: 120,
      width: 90,
      decoration: BoxDecoration(color: Colors.white),
      child: Stack(
        children: [
          Container(
            height: 85,
            decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.grey.shade400)),
          ),
          Positioned(
            bottom: 5,
            left: 7,
            child: Container(
              height: 80,
              width: 70,
              decoration: BoxDecoration(
                //color: Colors.orange,
                image: DecorationImage(
                    image: AssetImage(
                      plant["image"],
                    ),
                    fit: BoxFit.cover),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_pant_app/models/plants.dart';
import 'package:flutter_pant_app/plant_cart.dart';

import 'database.dart';



class PlantDetails extends StatefulWidget {
  final Plants plants;
  const PlantDetails({Key? key, required this.plants}) : super(key: key);

  @override
  State<PlantDetails> createState() => _PlantDetailsState();
}

class _PlantDetailsState extends State<PlantDetails> {
  List<Map<String , dynamic>> details = [
    {
      "icon" : Icons.sunny,
      "data" : "Sun",
      "time" : "8 hours"
    },
    {
      "icon" : Icons.water_drop_outlined,
      "data" : "Water",
      "time" : "2 days"
    },
    {
      "icon" : Icons.favorite_border,
      "data" : "LifeTime",
      "time" : "2 mounts"
    }
  ];
  MyDb myDb = MyDb();//-12
  @override
  void initState() { //-13
    myDb.open(); //-14
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  plantDetailsAppBar(),
                  Text(
                    widget.plants.plantName,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Robust and dramatic \nwith leaves",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  Container(
                    height: 200,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            plantDetails("Type", "Indoor"),
                            plantDetails("Size", "Small"),
                            plantDetails("Plants", widget.plants.plant),
                          ],
                        ),
                        Container(
                          width: 200,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(widget.plants.image),
                                  fit: BoxFit.cover)),
                        )
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              aboutPlant(),
              Container(
                height: 100,
                padding: EdgeInsets.all(20),
                color: Colors.orangeAccent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text("Price :",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),),
                        Text("\$${widget.plants.price}",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold
                          ),),

                      ],
                    ),
                    Container(
                      height: 40,
                      width: 160,
                      child: ElevatedButton(
                        onPressed: () async{ // async eklemek -15
                          await myDb.db!.rawInsert(// -16
                            "INSERT INTO plants(plant,image,price) VALUES(?,?,?);",
                            [ //-17
                              widget.plants.plant,
                              widget.plants.image,
                              widget.plants.price,
                            ]
                          );
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => PlantCart())
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.teal,
                              content: Text(
                                "New Plant Added To the CART",
                                style: TextStyle(
                                  color: Colors.red
                                ),
                              ),
                            )
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.teal
                        ),
                        child: Text(
                          "Add To Cart",
                          style: TextStyle(

                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget aboutPlant() => Container(
        padding: EdgeInsets.all(20),
        height: 240,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "About",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "jkjkjlkkşkşlkşlklşklklklklklklmhhjgjgkjgjhgjhgfhgdfsdfsdfdjhkjkllllllllllllkşlkkjjlllllllllllllllllllkşlklşkşlkşlkşlklkhuhgghgjkljkljkhkjjhgjhkkljkhj",
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 20,),
            Container(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
              itemCount: details.length,
              itemBuilder: (context,index){
                  final detail = details[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 22,
                        backgroundColor: Colors.teal.withOpacity(0.2),
                        child: Icon(
                          detail["icon"],
                          size: 20,
                          color: Colors.teal.shade300,
                        ),
                      ),
                      SizedBox(width: 5,),
                      Column(
                        children: [
                          Text(detail["data"],
                          style: TextStyle(
                            fontSize: 12,
                          ),),
                          Text(detail["time"],
                          style: TextStyle(
                            fontSize: 15
                          ),),
                        ],
                      )
                    ],
                  ),
                );
              },),
            )
          ],
        ),
      );

  Widget plantDetails(String text, String subText) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: TextStyle(fontSize: 18, color: Colors.grey.shade400),
          ),
          Text(
            subText,
            style: TextStyle(color: Colors.grey.shade900, fontSize: 20),
          )
        ],
      );

  Widget plantDetailsAppBar() => Padding(
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                size: 40,
              ),
            ),
            Container(
              height: 30,
              width: 60,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.horizontal(left: Radius.circular(12))),
              child: Icon(
                Icons.shopping_cart,
                size: 28,
              ),
            )
          ],
        ),
      );
}


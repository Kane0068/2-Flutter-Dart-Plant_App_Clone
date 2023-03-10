import 'package:flutter/material.dart';
import 'package:flutter_pant_app/models/plants.dart';
import 'package:flutter_pant_app/models/plants_detail.dart';

class PlantGarden extends StatefulWidget {
  const PlantGarden({Key? key}) : super(key: key);

  @override
  State<PlantGarden> createState() => _PlantGardenState();
}

class _PlantGardenState extends State<PlantGarden>
    with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 6, vsync: this);
  List<Plants> plants = plantsList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // 1- Plant Garden Başlığını yapıyoruz.
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          "Plants Garden",
        ),
        titleTextStyle: TextStyle(
            color: Colors.black, fontWeight: FontWeight.w600, fontSize: 25),
        centerTitle: true,
        bottom: TabBar(
          isScrollable: true,
          labelColor: Colors.tealAccent.shade400,
          unselectedLabelColor: Colors.grey.shade400,
          controller: _tabController,
          tabs: [
            Tab(
              text: "All",
            ),
            Tab(
              text: "Ferns",
            ),
            Tab(
              text: "Succulents",
            ),
            Tab(
              text: "Herbs",
            ),
            Tab(
              text: "Tropical",
            ),
            Tab(
              text: "Bonsai",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          allPlantsLists(),
          Text("Ferns"),
          Text("Succulents"),
          Text("Herbs"),
          Text("Tropical"),
          Text("Bonsai"),
        ],
      ),
    );
  }

  Widget allPlantsLists() => Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            height: 510,
            color: Colors.greenAccent.shade100,
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  childAspectRatio: 6 / 8,
                ),
                itemCount: plantsList.length,
                itemBuilder: (context, index) {
                  final plant = plants[index];
                  return GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PlantDetails(plants: plant)));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: plant.lightColor,
                          borderRadius: BorderRadius.circular(8)),
                      child: Stack(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(12),
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(8),
                              ),
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    plant.lightColor,
                                    plant.darkColor,
                                  ]),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  plant.plantName.toUpperCase(),
                                  style: TextStyle(
                                    color: Colors.greenAccent.shade700,
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  plant.plant.toUpperCase(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 20,
                            left: 25,
                            child: Container(
                              height: 140,
                              width: 130,
                              decoration: BoxDecoration(
                                //color: Colors.yellow,
                                image: DecorationImage(
                                  image: AssetImage("${plant.image}",),
                                  fit: BoxFit.cover
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          )
        ],
      );
}

import 'package:flutter/material.dart';

class Plants {
  String image, plantName, plant;
  Color lightColor, darkColor;
  double price;

  Plants(
      {required this.image,
      required this.plant,
      required this.plantName,
      required this.lightColor,
      required this.darkColor,
      required this.price});
}

final plantsList = [
  Plants(
      image: "assets/bonsai.png",
      plant: "Bonsai",
      plantName: "Milanus",
      lightColor: Colors.greenAccent,
      darkColor: Colors.greenAccent.shade700,
      price: 20),
  Plants(
      image: "assets/bonsai.png",
      plant: "Ferns",
      plantName: "Excelsa",
      lightColor: Colors.blueAccent,
      darkColor: Colors.blueAccent.shade700,
      price: 16),
  Plants(
      image: "assets/bonsai.png",
      plant: "herbs",
      plantName: "Prometheus",
      lightColor: Colors.lightBlueAccent,
      darkColor: Colors.lightBlueAccent.shade700,
      price: 38),
  Plants(
      image: "assets/bonsai.png",
      plant: "Succulent",
      plantName: "Convenant",
      lightColor: Colors.purpleAccent,
      darkColor: Colors.purpleAccent.shade700,
      price: 42),
  Plants(
      image: "assets/bonsai.png",
      plant: "Tropical",
      plantName: "Fruticosa",
      lightColor: Colors.pinkAccent,
      darkColor: Colors.pinkAccent.shade700,
      price: 19),
  Plants(
      image: "assets/bonsai.png",
      plant: "Ferns",
      plantName: "Ailanthus",
      lightColor: Colors.yellowAccent,
      darkColor: Colors.yellowAccent.shade700,
      price: 24)
];

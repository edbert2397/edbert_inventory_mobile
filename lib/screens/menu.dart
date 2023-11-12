import 'package:flutter/material.dart';
import 'package:inventory/screens/inventory_form.dart';
import 'package:inventory/widgets/left_drawer.dart';
import 'package:inventory/widgets/shop_card.dart';

class MyHomePage extends StatelessWidget{
  MyHomePage({Key?key}) : super(key:key);
  
  final List<ShopItem> items = [
    ShopItem("Lihat Item", Icons.checklist,Colors.blue),
    ShopItem("Tambah Item", Icons.add_shopping_cart,Colors.indigo),
    ShopItem("Logout",Icons.logout,Colors.red),
  ];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Inventory',
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top:10,bottom:10),
                child:  Text(
                  'Inventory',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              GridView.count(
                primary: true,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 3,
                shrinkWrap: true,
                children: items.map((ShopItem item){
                  return ShopCard(item);
                }).toList(),
              ),
            ],
          ),
        ),
      ) ,
    );
  }

}
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:inventory/screens/DaftarItem.dart';
import 'package:inventory/screens/menu.dart';
import 'package:inventory/screens/inventory_form.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.indigo,
            ),
            child: Column(
              children:[
                Text(
                  'Inventory',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'catat seluruh inventorymu di sini',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
                )
              ]
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text("Halaman utama"),
            onTap: () {
              Navigator.pushReplacement(
                context, 
                MaterialPageRoute(
                  builder: (context) => MyHomePage(),
                  ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.view_list),
            title: const Text("Daftar Item"),
            onTap:(){
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) => const DaftarItem())
              );
            }
          ),
          ListTile(
            leading: const Icon(Icons.add_shopping_cart),
            title: const Text("Tambah item"),
            onTap:(){
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) => const InventoryFormPage())
              );
            }
          )
        ],
      )
    );
  }
}
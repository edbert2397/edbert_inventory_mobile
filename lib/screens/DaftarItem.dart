import 'package:flutter/material.dart';
import 'package:inventory/data.dart';
class DaftarItem extends StatelessWidget {
  const DaftarItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Inventory Produk"),
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: Data.objects.length,
        itemBuilder:(context,index){
          final data = Data.objects[index];
          return Card(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(data.name, style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8), // Adds space between the text
                  Text('Amount: ${data.amount}'),
                  Text(data.description),
                ],
              ),
            )
          );
        } ,
      ),
    );
  }
}
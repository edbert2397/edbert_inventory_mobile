import 'package:flutter/material.dart';
import 'package:inventory/models/item.dart';
class ItemDetailPage extends StatelessWidget {
  final Item item;
  const ItemDetailPage({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:Padding(
          padding: EdgeInsets.all(16),
          child:Column(
            
            children: [
              Text('Name: ${item.fields.name}', style: TextStyle(fontSize: 20)),
              Text('Amount: ${item.fields.amount}', style: TextStyle(fontSize: 18)),
              Text('Description: ${item.fields.description}', style: TextStyle(fontSize: 16)),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Back to List'),
              ),
            ],
          )

        )
      ),
    );
  }
}
import 'package:flutter/material.dart';

class OrderDetailsPage extends StatelessWidget {
  final dynamic order;

  OrderDetailsPage({required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Pedido'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Text(
            'Pedido #${order['id']}',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          Text('Status: ${order['status']}'),
          SizedBox(height: 8),
          Text('Data/Hora: ${order['created_at']}'),
          SizedBox(height: 16),
          Text(
            'Produtos no Pedido:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: order['items'].length,
            itemBuilder: (context, index) {
              var item = order['items'][index];
              var product = item['product'];
              var additional = item['additional'];


              List<String> additionalsList = [];
              if (additional != null) {
                if (additional['addoption'] == 1) {
                  additionalsList.add('Opcao Comida');
                }
                if (additional['notes'] != null && additional['notes'] != '') {
                  additionalsList.add('${additional['notes']}');
                }
              }

              return ListTile(
                title: Text(product['name']),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Descrição: ${product['description'] ?? 'Sem descrição'}'),
                    SizedBox(height: 4),
                    additionalsList.isEmpty
                        ? Container()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: additionalsList.map((additional) => Text(additional)).toList(),
                          ),
                    SizedBox(height: 4),
                    Text('Quantidade: ${item['quantity']}'),
                    Text('Preço produto: ${item['price']}'),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

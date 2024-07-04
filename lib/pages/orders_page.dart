import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'order_details_page.dart';

class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  List<dynamic> orders = [];

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    try {
      final response = await http.get(Uri.parse('http://127.0.0.1:3333/orders'));

      if (response.statusCode == 200) {
        List<dynamic> fetchedOrders = jsonDecode(response.body);



        fetchedOrders.sort((a, b) {
          var dateA = DateTime.parse(a['created_at']);
          var dateB = DateTime.parse(b['created_at']);
          return dateB.compareTo(dateA);
        });

        setState(() {
          orders = fetchedOrders;
        });
      } else {
        throw Exception('Falha ao carregar os pedidos');
      }
    } catch (e) {
      print('Erro: $e');
    }
  }

  void navigateToOrderDetails(dynamic order) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrderDetailsPage(order: order),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ver Pedidos'),
      ),
      body: orders.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                var order = orders[index];
                var createdAt = DateTime.parse(order['created_at']);
                var formattedDate = '${createdAt.day}/${createdAt.month}/${createdAt.year}';
                var formattedTime = '${createdAt.hour}:${createdAt.minute}';

                return ListTile(
                  title: Text('Pedido #${order['id']}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Status: ${order['status']}'),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          SizedBox(width: 4),
                          Text('Horário: $formattedTime'),
                        ],
                      ),
                      SizedBox(height: 4),
                      Text('Data: $formattedDate'),
                    ],
                  ),
                  onTap: () {
                    navigateToOrderDetails(order);
                  },
                );
              },
            ),
    );
  }
}

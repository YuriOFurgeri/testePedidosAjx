import 'package:flutter/material.dart';
import '/pages/home_page.dart';
import '/pages/orders_page.dart';
import '/pages/add_product_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minha Aplicação',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/orders': (context) => OrdersPage(),
        '/add_product': (context) => ProductCreatePage(),
      },
    );
  }
}

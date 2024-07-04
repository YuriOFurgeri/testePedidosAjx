import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductCreatePage extends StatefulWidget {
  @override
  _ProductCreatePageState createState() => _ProductCreatePageState();
}

class _ProductCreatePageState extends State<ProductCreatePage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _imageUrlController = TextEditingController();
  TextEditingController _categoryIdController = TextEditingController();
  bool _hasAdditional = false; 
  
  TextEditingController _addoptionsController = TextEditingController();
  
  TextEditingController _notesController = TextEditingController();

  Future<void> _createProduct() async {
    String url = 'http://127.0.0.1:3333/products';
    var response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'name': _nameController.text,
        'description': _descriptionController.text,
        'price': double.parse(_priceController.text),
        'image_url': _imageUrlController.text,
        'category_id': int.parse(_categoryIdController.text),
        'has_additional': _hasAdditional,
        /*'additional': {
          'addoption': int.parse(_addoptionsController.text),
          'notes': _notesController.text,
        },*/
      }),
    );

    if (response.statusCode == 201) {
      var product = jsonDecode(response.body);
      print('Novo produto criado: ${product['name']}');
    } else {
      print('Erro ao criar produto: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criar Novo Produto'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome do produto';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Descrição'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a descrição do produto';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Preço'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o preço do produto';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _imageUrlController,
                decoration: InputDecoration(labelText: 'URL da Imagem'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a URL da imagem do produto';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _categoryIdController,
                decoration: InputDecoration(labelText: 'ID da Categoria (1 ao 4)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o ID da categoria do produto';
                  }
                  return null;
                },
              ),
             /* CheckboxListTile(
                title: Text('Adicionais'),
                value: _hasAdditional,
                onChanged: (value) {
                  setState(() {
                    _hasAdditional = value!;
                  });
                },
              ),
              Visibility(
                visible: _hasAdditional,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _addoptionsController,
                      decoration: InputDecoration(labelText: 'Tipo de adição'),
                    ),
                 
                    TextFormField(
                      controller: _notesController,
                      decoration: InputDecoration(labelText: 'Notas Adicionais'),
                    ),
                  ],
                ),
              ),*/

              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _createProduct();
                  }
                },
                child: Text('Salvar Produto'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

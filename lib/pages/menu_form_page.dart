// lib/pages/menu_form_page.dart
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_finder/components/styles.dart';
import 'package:food_finder/components/widgets.dart';
import 'package:food_finder/helpers/api_services.dart';
import 'package:food_finder/models/restaurant.dart';
import 'package:image_picker/image_picker.dart';

import '../models/menu.dart';

class MenuFormPage extends StatefulWidget {
  final Function(Menu) onMenuAdded;
  final Restaurant resto;

  MenuFormPage({required this.onMenuAdded, required this.resto});

  @override
  _MenuFormPageState createState() => _MenuFormPageState();
}

class _MenuFormPageState extends State<MenuFormPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  XFile? _image;
  APIServices api = APIServices();

  void addMenu() async {
    final name = _nameController.text;
    final description = _descriptionController.text;
    final price = double.tryParse(_priceController.text) ?? 0;

    if (name.isNotEmpty && description.isNotEmpty && price > 0) {
      Menu newMenu = Menu(
          name: name,
          restoId: widget.resto.id,
          price: price,
          description: description);
      newMenu = await api.addMenu(widget.resto.id, newMenu);

      if (_image != null) {
        final imageFile = File(_image!.path);
        api.uploadMenuImage(newMenu, imageFile);
      }
      Navigator.pop(context);
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _image = pickedFile;
        _imageController.text = pickedFile.path;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Menu', style: whiteBoldText),
        backgroundColor: Colors.blue[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _image != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(
                        File(_image!.path),
                        width: 350,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.camera_alt,
                        size: 50,
                        color: Colors.grey[600],
                      ),
                    ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => _pickImage(ImageSource.camera),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[900],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text('Camera', style: whiteBoldText),
                  ),
                  ElevatedButton(
                    onPressed: () => _pickImage(ImageSource.gallery),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[900],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text('Gallery', style: whiteBoldText),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              BoxedTextField(
                label: "Nama menu",
                icon: Icons.fastfood,
                controller: _nameController,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _descriptionController,
                maxLines: 3,
                decoration:
                    boxedInputDecoration("Deskripsi", Icons.description),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _priceController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: boxedInputDecoration("Harga", Icons.price_change),
              ),
              const SizedBox(height: 20),
              BlueButton(
                text: "Simpan Menu",
                onPressed: addMenu,
              )
            ],
          ),
        ),
      ),
    );
  }
}

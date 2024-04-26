import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_local/src/providers/great_places.dart';
import 'package:my_local/src/widgets/image_input.dart';
import 'package:my_local/src/widgets/location_input.dart';
import 'package:provider/provider.dart';

class PlacesFormScreen extends StatefulWidget {
  const PlacesFormScreen({super.key});

  @override
  State<PlacesFormScreen> createState() => _PlacesFormScreenState();
}

class _PlacesFormScreenState extends State<PlacesFormScreen> {
  final _titleController = TextEditingController();
  File? _pickedImage;
  LatLng? _pickedPosition;

  void _selectImage(File pickedImage) {
    setState(() {
      _pickedImage = pickedImage;
    });
  }

  void _selectPosition(LatLng pickedPosition) {
    setState(() {
      _pickedPosition = pickedPosition;
    });
  }

  bool _isValidForm() {
    return _titleController.text.isNotEmpty &&
        _pickedImage != null &&
        _pickedPosition != null;
  }

  void _submitForm() async {
    if (!_isValidForm()) return;

    Provider.of<GreatPlaces>(context, listen: false).addPlace(
      _titleController.text,
      _pickedImage!,
      _pickedPosition!,
    );
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Lugar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextFormField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        labelText: "Titulo",
                      ),
                    ),
                    const SizedBox(height: 10),
                    ImageInput(onSelectImage: _selectImage),
                    const SizedBox(height: 10),
                    LocationInput(onSelectPosition: _selectPosition)
                  ],
                ),
              ),
            ),
            ElevatedButton.icon(
              onPressed: _isValidForm() ? _submitForm : null,
              icon: const Icon(Icons.add),
              label: const Text(
                "Adcionar",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

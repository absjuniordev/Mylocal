import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:my_local/src/utils/location_util.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  void _getCurrentLocation() async {
    try {
      final locData = await Location().getLocation();

      final staticMapImageUrl = LocationUtil.generateLocationPreviewImage(
        latitude: locData.latitude,
        longitude: locData.longitude,
      );
      setState(() {
        _previewImageUrl = staticMapImageUrl;
      });
    } catch (error) {
      debugPrint('Erro ao obter localização: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 200,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _previewImageUrl == null
              ? const Text("Localização não encontrado")
              : Image.network(
                  _previewImageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: _getCurrentLocation,
              icon: const Icon(Icons.location_on),
              label: const Text("Localização Atual"),
            ),
            const SizedBox(width: 20),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.map),
              label: const Text("Selecione o Mapa"),
            ),
          ],
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:my_local/src/screens/map_screen.dart';
import 'package:my_local/src/utils/location_util.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPosition;

  const LocationInput({super.key, required this.onSelectPosition});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;
  bool _isLoading = false;

  void _showPreviewImageUrl(double lat, double lng) {
    final staticMapImageUrl = LocationUtil.generateLocationPreviewImage(
      latitude: lat,
      longitude: lng,
    );
    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }

  Future<void> _getCurrentLocation() async {
    try {
      setState(() {
        _isLoading = true;
      });
      final locData = await Location().getLocation();
      _showPreviewImageUrl(locData.latitude!, locData.longitude!);

      widget.onSelectPosition(
        LatLng(
          locData.latitude!,
          locData.longitude!,
        ),
      );

      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      debugPrint('Erro ao obter localização: $error');
    }
  }

  Future<void> _selectMap() async {
    final LatLng selectedPosition = await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => const MapScreen(),
      ),
    );

    // ignore: unnecessary_null_comparison
    if (selectedPosition == null) return;
    widget.onSelectPosition(selectedPosition);

    _showPreviewImageUrl(selectedPosition.latitude, selectedPosition.longitude);
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton.icon(
              onPressed: _isLoading ? null : _getCurrentLocation,
              icon: const Icon(Icons.location_on),
              label: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text("Localização Atual"),
            ),
            ElevatedButton.icon(
              onPressed: _selectMap,
              icon: const Icon(Icons.map),
              label: const Text("Selecione o Mapa"),
            ),
          ],
        )
      ],
    );
  }
}

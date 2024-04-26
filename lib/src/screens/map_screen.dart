import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:my_local/src/model/place.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isReadOnly;

  const MapScreen({
    super.key,
    this.initialLocation = const PlaceLocation(
      latitude: 37.419857,
      longitude: -122.078827,
    ),
    this.isReadOnly = false,
  });

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pikedPosition;

  void _selectedPosition(LatLng position) {
    setState(() {
      _pikedPosition = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecione...'),
        actions: [
          if (!widget.isReadOnly)
            IconButton(
              onPressed: _pikedPosition == null
                  ? null
                  : () {
                      Navigator.of(context).pop(_pikedPosition);
                    },
              icon: const Icon(Icons.check),
            ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initialLocation.latitude,
            widget.initialLocation.longitude,
          ),
          zoom: 13,
        ),
        onTap: widget.isReadOnly ? null : _selectedPosition,
        markers: _pikedPosition == null
            ? {}
            : {
                Marker(
                  markerId: const MarkerId('p1'),
                  position: _pikedPosition!,
                )
              },
      ),
    );
  }
}

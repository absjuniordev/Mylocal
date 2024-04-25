import 'package:flutter/material.dart';
import 'package:my_local/src/providers/great_places.dart';
import 'package:my_local/src/utils/app_routs.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Lugares'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.placeForm);
            },
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false).loadPlaces(),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(child: CircularProgressIndicator())
                : Consumer<GreatPlaces>(
                    child: const Center(
                      child: Text('Nenhum local cadastrado!'),
                    ),
                    builder: (ctx, gretaPlaces, child) =>
                        gretaPlaces.itemsCount == 0
                            ? child!
                            : ListView.builder(
                                itemBuilder: (cxt, i) => ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: FileImage(
                                      gretaPlaces.itemByInde(i).image,
                                    ),
                                  ),
                                  title: Text(gretaPlaces.itemByInde(i).title),
                                  onTap: () {},
                                ),
                                itemCount: gretaPlaces.itemsCount,
                              ),
                  ),
      ),
    );
  }
}

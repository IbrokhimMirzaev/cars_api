import 'package:cars_api/db/company_item.dart';
import 'package:cars_api/db/local_database.dart';
import 'package:flutter/material.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favourites"),
      ),
      body: FutureBuilder(
          future: LocalDataBase.getAllCompanies(),
          builder: (context, AsyncSnapshot<List<Company>> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text("Error"));
            } else {
              List<Company> cachedCompanies = snapshot.data!;
              return ListView(
                children: List.generate(
                  cachedCompanies.length,
                  (index) => Container(
                    height: 200,
                    child: Column(
                      children: [
                        Image.network(cachedCompanies[index].logo, height: 150),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          Text(cachedCompanies[index].companyName),
                          const SizedBox(width: 50),
                          Text(cachedCompanies[index].companyId.toString()),
                        ],)
                      ],
                    ),
                  ),
                ),
              );
            }
          }),
    );
  }
}

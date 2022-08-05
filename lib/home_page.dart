import 'package:cars_api/models/companies/company_item.dart';
import 'package:cars_api/screens/car_info.dart';
import 'package:cars_api/screens/favourite_page.dart';
import 'package:cars_api/service/api_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Car companies"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (c)=>FavouriteScreen()));
            },
            icon: const Icon(
              Icons.favorite_outline_outlined,
              color: Colors.red,
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<CompanyItem>>(
        future: ApiProvider.getAllCompanies(),
        builder: (context, AsyncSnapshot<List<CompanyItem>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CupertinoActivityIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Error"));
          } else {
            List<CompanyItem> companies = snapshot.data!;
            return ListView(
              children: List.generate(
                companies.length,
                (index) => GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (c) => CarInfo(
                          id: companies[index].id,
                          carName: companies[index].carModel,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: 150,
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 5,
                            blurRadius: 5,
                            offset: const Offset(1, 3),
                            color: Colors.grey.shade400,
                          )
                        ]),
                    child: Row(
                      children: [
                        Image.network(companies[index].logo,
                            width: 130, height: 130),
                        const SizedBox(width: 35),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              companies[index].carModel,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(companies[index].year.toString()),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

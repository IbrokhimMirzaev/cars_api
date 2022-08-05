import 'package:carousel_slider/carousel_slider.dart';
import 'package:cars_api/db/company_item.dart';
import 'package:cars_api/db/local_database.dart';
import 'package:cars_api/models/companies/company_item.dart';
import 'package:cars_api/service/api_provider.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CarInfo extends StatefulWidget {
  const CarInfo({
    Key? key,
    required this.id,
    required this.carName,
  }) : super(key: key);

  final int id;
  final String carName;

  @override
  State<CarInfo> createState() => _CarInfoState();
}

class _CarInfoState extends State<CarInfo> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CompanyItem>(
      future: ApiProvider.getSingleCompany(id: widget.id),
      builder: (context, AsyncSnapshot<CompanyItem> snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        } else if (snapshot.hasError) {
          return const Center(child: Text("Error"));
        } else {
          CompanyItem car = snapshot.data!;
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                await LocalDataBase.insertCompany(
                  Company(
                    companyId: car.id,
                    companyName: car.year.toString(),
                    isFavourite: 1,
                    logo: car.logo,
                  ),
                );
              },
              child: const Icon(Icons.add),
            ),
            appBar: AppBar(
              title: Text("About ${widget.carName}"),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(25),
                child: Column(
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 200.0,
                        autoPlay: false,
                        enlargeCenterPage: true,
                        autoPlayInterval: const Duration(seconds: 1),
                        viewportFraction: 0.7,
                      ),
                      items: List.generate(
                        car.pics.length,
                        (index) => Container(
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(horizontal: 7),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(car.pics[index], fit: BoxFit.cover),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 70),
                    Container(
                      height: 150,
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.network(car.logo, width: 130, height: 130),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                car.carModel,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                car.year.toString(),
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.greenAccent,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    ExpansionTile(
                      title: const Text("About company"),
                      children: [Text(car.desc)],
                    )
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}

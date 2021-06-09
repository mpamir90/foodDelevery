import 'package:flutter/material.dart';
import 'package:relative_scale/relative_scale.dart';

class DetailProductView extends StatelessWidget {
  const DetailProductView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.grey),
        centerTitle: true,
        title: Text(
          "Makanan",
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: Colors.black),
        ),
      ),
      body: RelativeBuilder(
        builder: (BuildContext context, double height, double width,
                double Function(double) sx, double Function(double) sy) =>
            Column(
          children: [
            Expanded(
                child: Container(
              color: Colors.white,
              padding: EdgeInsets.all(8),
              child: ListView(
                children: [
                  Text(
                    "Tahu Tempe Bajem",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: Colors.deepOrangeAccent[400]),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Rp 300.000",
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(color: Colors.deepOrangeAccent),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Card(
                    child: ListTile(
                      leading: Icon(
                        Icons.home_work_outlined,
                        size: sy(50),
                      ),
                      title: Text("Toko Sumber Abadi"),
                      subtitle: Row(
                        children: [
                          Icon(Icons.location_on_outlined),
                          Text(" Surabaya")
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Image(
                    image: AssetImage("assets/makanan.jpg"),
                    height: sy(300),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Card(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Deskripsi",
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(color: Colors.black),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                            "Ini adalah makanan yang tradisional yang dikenal oleh banyak orang dan ini sudah menjadi makanan seari hari dan biasanya ini dimakan dengan sambal terasi ini juga akan menjadi makanan faforit kita semua")
                      ],
                    ),
                  ))
                ],
              ),
            )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Icon(Icons.shopping_cart_outlined),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.deepOrange[400]),
                  )),
            )
          ],
        ),
      ),
    );
  }
}

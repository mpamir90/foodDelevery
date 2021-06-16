
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:relative_scale/relative_scale.dart';

class AddProductView extends StatelessWidget {
  const AddProductView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    File? imageFile;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: Text("Tambah Product"),
      ),
      body: RelativeBuilder(
        builder: (BuildContext context, double height, double width,
                double Function(double) sx, double Function(double) sy) =>
            SingleChildScrollView(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    StatefulBuilder(
                      builder: (BuildContext context,
                              void Function(void Function()) setState) =>
                          Container(
                        height: sy(300),
                        width: double.infinity,
                        child: Image(image: AssetImage("assets/makanan.jpg"),),
                        decoration: BoxDecoration(
                            color: (imageFile != null) ? Colors.white : Colors.deepOrange,
                            border: Border.all(style: BorderStyle.solid)),
                      ),
                    )
                  ],
                )),
      ),
    );
  }
}

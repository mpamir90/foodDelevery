import 'dart:io';


import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fooddelevery/bloc/tokoview_bloc.dart';
import 'package:fooddelevery/services/auth_service.dart';
import 'package:relative_scale/relative_scale.dart';

class TokoView extends StatefulWidget {
  final Map<String, dynamic>? data;
  const TokoView(
    this.data, {
    Key? key,
  }) : super(key: key);

  @override
  _TokoViewState createState() => _TokoViewState();
}

class _TokoViewState extends State<TokoView> {
  bool editState = false;
  File? imageFile;
  TextEditingController cNamaToko = TextEditingController();
  TextEditingController cProvinsi = TextEditingController();
  TextEditingController cKota = TextEditingController();
  TextEditingController cAlamat = TextEditingController();
  @override
  void initState() {
    if (widget.data != null) {
      cNamaToko.text = widget.data!["nama toko"];
      cProvinsi.text = widget.data!["provinsi"];
      cKota.text = widget.data!["kota"];
      cAlamat.text = widget.data!["alamat"];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TokoviewBloc>(
      create: (context) => TokoviewBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Toko Saya"),
          backgroundColor: Colors.deepOrangeAccent,
          actions: [
            BlocBuilder<TokoviewBloc, TokoviewState>(
              builder: (context, state) {
                return IconButton(
                    onPressed: () async {
                      if (editState) {
                        editState = false;
                        if (state is! OnSaveTokoLoading) {
                          
                          context.read<TokoviewBloc>().add(SaveToko(
                              cNamaToko.text,
                              cProvinsi.text,
                              cKota.text,
                              cAlamat.text,
                              AuthService().user!.uid,
                              (imageFile != null) ? await imageFile!.readAsBytes() : null));
                        }
                      } else {
                        editState = true;
                      }
                      setState(() {});
                    },
                    icon: (state is OnSaveTokoLoading)
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : (editState)
                            ? Icon(Icons.save)
                            : Icon(Icons.edit));
              },
            )
          ],
        ),
        body: RelativeBuilder(
          builder: (BuildContext context, double height, double width,
                  double Function(double) sx, double Function(double) sy) =>
              SingleChildScrollView(
            padding: EdgeInsets.all(9),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: StatefulBuilder(
                    builder: (BuildContext context,
                            void Function(void Function()) setState2) =>
                        GestureDetector(
                            onTap: () async {
                              if (editState) {
                                FilePickerResult? res = await FilePicker
                                    .platform
                                    .pickFiles(type: FileType.image);
                                if (res != null) {
                                  print("Path File: " +
                                      res.files.first.path.toString());
                                  imageFile =
                                      File(res.files.first.path.toString());
                                  setState2(() {});
                                }
                              }
                            },
                            child: Container(
                                child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                  (imageFile != null)
                                      ? Image.file(imageFile!)
                                      : FadeInImage(
                                          imageErrorBuilder:
                                              (context, obj, sTrace) {
                                            print("Image Error");
                                            return Image(
                                              image: AssetImage(
                                                  "assets/makanan.jpg"),
                                            );
                                          },
                                          placeholder:
                                              AssetImage("assets/makanan.jpg"),
                                          image: NetworkImage(widget.data!["image"]["url"])),
                                  (editState)
                                      ? Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                          size: 50,
                                        )
                                      : SizedBox()
                                ]))),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Card(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Profile",
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.deepOrangeAccent),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        buildTextFormField("Nama Toko", editState, cNamaToko)
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Lokasi",
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.deepOrangeAccent),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        buildTextFormField("Provinsi", editState, cProvinsi),
                        buildTextFormField("Kota", editState, cKota),
                        buildTextFormField(
                            "Alamat Lengkap", editState, cAlamat),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextFormField(
      String title, bool enabled, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        enabled: enabled,
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            labelText: title),
      ),
    );
  }
}

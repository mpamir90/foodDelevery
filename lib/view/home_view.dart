import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:relative_scale/relative_scale.dart';

import '../bloc/auth_bloc.dart';
import '../bloc/homeview_bloc.dart';
import '../services/auth_service.dart';
import 'detail_product._view.dart';
import 'toko_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey[200],
      body: RelativeBuilder(
        builder: (context, height, width, sy, sx) => ListView(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(120)),
                color: Colors.deepOrange,
              ),
              child: SafeArea(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hallo, " + AuthService().user!.displayName.toString(),
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Text(
                    DateFormat("EEEE, d MMMM").format(DateTime.now()),
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        Icon(
                          Icons.account_balance_wallet_outlined,
                          size: 30,
                          color: Colors.white,
                        ),
                        Text(
                          " Rp 12500",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      buildItemMenu(
                          context, "Isi Saldo", Icons.add_circle_outline, () {
                        showMaterialModalBottomSheet(
                            enableDrag: true,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20))),
                            context: context,
                            builder: (context) => Container(
                                  // height: sy(100),

                                  child: SingleChildScrollView(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "Top Up",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5!
                                              .copyWith(
                                                  color:
                                                      Colors.orangeAccent[700]),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              bottom: MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom),
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6!
                                                .copyWith(color: Colors.black),
                                            decoration: InputDecoration(
                                                hintText: "Masukan Nominal",
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.grey),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20)),
                                                prefixIcon: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "Rp.",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline6!
                                                        .copyWith(
                                                            color:
                                                                Colors.black),
                                                  ),
                                                ),
                                                prefixIconConstraints:
                                                    BoxConstraints(
                                                        minHeight: 0,
                                                        minWidth: 0),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20))),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                            width: double.infinity,
                                            child: ElevatedButton(
                                              onPressed: () {},
                                              child: Text("Top Up"),
                                              style: ElevatedButton.styleFrom(
                                                  primary:
                                                      Colors.deepOrange[400]),
                                            ))
                                      ],
                                    ),
                                  ),
                                ));
                      }),
                      BlocConsumer<HomeviewBloc, HomeviewState>(
                        listener: (context, state) {
                          if (state is OnGetTokoSucceded) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TokoView(state.data)));
                          }
                        },
                        builder:(context,state)=>
                            buildItemMenu(context, (state is OnGetTokoLoading) ? "..." : "Toko Saya", Icons.shop, () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => TokoView()));
                          if(state is! OnLogoutLoading){
                            context.read<HomeviewBloc>().add(GetToko(AuthService().user!.uid));
                          }
                        }),
                      )
                    ],
                  ),
                ],
              )),
            ),
            Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      "Kategori",
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(color: Colors.grey),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        buildItemKategori(sy, sx, context, "Makanan"),
                        buildItemKategori(sy, sx, context, "Minuman"),
                        buildItemKategori(sy, sx, context, "Fast Food"),
                        buildItemKategori(sy, sx, context, "Camilan"),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Wrap(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailProductView()));
                          },
                          child: buildItemProduct(sy, sx, context)),
                      buildItemProduct(sy, sx, context),
                      buildItemProduct(sy, sx, context),
                      buildItemProduct(sy, sx, context),
                      buildItemProduct(sy, sx, context),
                      buildItemProduct(sy, sx, context),
                      buildItemProduct(sy, sx, context),
                      buildItemProduct(sy, sx, context),
                      buildItemProduct(sy, sx, context),
                      buildItemProduct(sy, sx, context),
                      buildItemProduct(sy, sx, context),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildItemMenu(
      BuildContext context, String title, IconData icon, void navigation()) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          navigation();
        },
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(8),
            primary: Colors.deepOrange[100],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 30,
              color: Colors.deepOrange[700],
            ),
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }

  SizedBox buildItemProduct(double Function(double) sy,
      double Function(double) sx, BuildContext context) {
    return SizedBox(
      height: sy(250),
      width: sx(265),
      child: Card(
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              height: sy(100),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/makanan.jpg"),
                      fit: BoxFit.fill)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Tahu bulat dan kotak begitu juga dengan persegi",
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.amber[800]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Rp 300.000",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 8, right: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("(5/5)"),
                    Icon(
                      Icons.star,
                      color: Colors.amber[400],
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.amber[400],
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.amber[400],
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.amber[400],
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.amber[400],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Icon(Icons.add_shopping_cart),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.deepOrange[300]),
                  )),
            )
          ],
        ),
      ),
    );
  }

  Widget buildItemKategori(double Function(double) sy,
      double Function(double) sx, BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/makanan.jpg"), fit: BoxFit.fill)),
        height: sy(40),
        width: sx(200),
        child: ElevatedButton(
          onPressed: () {},
          style:
              ElevatedButton.styleFrom(primary: Colors.black.withOpacity(0.5)),
          child: Center(
            child: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(fontStyle: FontStyle.italic),
            ),
          ),
        ),
      ),
    );
  }
}

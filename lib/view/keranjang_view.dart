import 'package:flutter/material.dart';
import 'package:relative_scale/relative_scale.dart';

class KeranjangView extends StatelessWidget {
  const KeranjangView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Keranjang",
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: RelativeBuilder(
        builder: (BuildContext context, double height, double width,
                double Function(double) sx, double Function(double) sy) =>
            Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  buildCartItem(context, "Noodless", "250000", "2"),
                  buildCartItem(context, "Noodless", "250000", "2")
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.deepOrange[200],
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: Text("Total",style: Theme.of(context).textTheme.headline5,),
                    trailing: Text("Rp 3000000",style: Theme.of(context).textTheme.headline5,),
                  ),
                  SizedBox(height: 60,width: double.infinity,child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(onPressed: (){}, child: Text("Checkout",style: Theme.of(context).textTheme.headline5),style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)
                      ),
                      primary: Colors.deepOrange[400]
                    ),),
                  ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildCartItem(BuildContext context,String title,String price,String total) {
    return Card(
      elevation: 0,
      child: ListTile(
        leading: ClipOval(
                  child: Image(
            image: AssetImage("assets/makanan.jpg"),
          ),
        ),
        title: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(color: Colors.black),
        ),
        subtitle: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Rp "+price),
            Row(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.add_circle_outlined,
                      color: Colors.grey,
                    )),
                Text(total),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.minimize_rounded,
                      color: Colors.grey,
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

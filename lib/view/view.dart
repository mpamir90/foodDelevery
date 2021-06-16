import 'package:flutter/material.dart';
import 'account_view.dart';
import 'home_view.dart';
import 'keranjang_view.dart';

class View extends StatefulWidget {
  const View({Key? key}) : super(key: key);

  @override
  _ViewState createState() => _ViewState();
}

class _ViewState extends State<View> with TickerProviderStateMixin {
  int selectedBarItem = 0;
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 3, vsync: this);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey[200],
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        child: StatefulBuilder(
          builder: (context, setStateNavigation) {
            tabController.addListener(() {
      selectedBarItem = tabController.index;
      setStateNavigation((){});
    });
            return BottomNavigationBar(
              currentIndex: selectedBarItem,
              type: BottomNavigationBarType.fixed,
              showUnselectedLabels: false,
              selectedItemColor: Colors.red[400],
              onTap: (value) {
                print("Tab Index: " + value.toString());
                selectedBarItem = value;
                tabController.animateTo(value);
                setStateNavigation(() {});
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_bag_outlined),
                    label: "Keranjang"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle_outlined),
                    label: "Account"),
              ]);}
        ),
      ),
      body: TabBarView(
          controller: tabController,
          children: [HomeView(), KeranjangView(), AccountView()]),
    );
  }
}

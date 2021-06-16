import 'package:cloud_firestore/cloud_firestore.dart';


class FirestoreService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> createUser(String username, String noHp,String uid) async {
    await firestore
        .collection("user").doc(uid)
        .set({"username": username, "no handphone": noHp,"keranjang" : {},"saldo" : "","toko" : {}});
  }

  Future<bool> cekUserByNumber(String no) async{
   var query = await firestore.collection("user").where("no handphone",isEqualTo: "+62"+no.trim()).get();
   if(query.docs.length == 1){
     return true;
   }
   return false;
  }

  Future<Map<String, dynamic>?> getToko(String uid) async {
    return (await firestore.collection("toko").doc(uid).get()).data();
  }
  
  Future<void> setToko(String uid,String namaToko,String provinsi,String kota,String alamat,Map<String,dynamic>? image) async {
    if(image != null){
    await firestore.collection("toko").doc(uid).set({"nama toko" : namaToko,"provinsi" : provinsi,"kota" : kota,"alamat" : alamat,"image" : image});

    }else{
    await firestore.collection("toko").doc(uid).set({"nama toko" : namaToko,"provinsi" : provinsi,"kota" : kota,"alamat" : alamat},SetOptions(merge: true));
    }
  }
  
}


import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';

class ApiService{
  Future<Map<String,dynamic>> uploadImage(Uint8List? uint8list) async {
    String myBase = base64Encode(uint8list!);
    print("myBase: "+myBase);
    Response respon = await Dio().post("https://api.imgbb.com/1/upload",data: FormData.fromMap({
      "key" : "dfb0f97dca93366d8394e55687ee6044",
      "image" : myBase
    }),options: Options());
    print("Response Api Imgbb:"+respon.data.toString());
    return {"url" : respon.data["data"]["image"]["url"],"display_url" : respon.data["data"]["image"]["display_url"]};
  }
}
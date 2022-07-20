
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';

import '../sura_list_model.dart';
class SuraService{
  Future <List<SuraListModel>> getSuraList()async{

     Uri url = Uri.parse("https://alquranbd.com/api/tafheem/sura/list");
     final response=await http.get(url);
    var data=jsonDecode(response.body);

     return suraListModelFromJson(response.body);
    
  }
}


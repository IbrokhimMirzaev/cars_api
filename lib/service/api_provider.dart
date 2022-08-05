import 'dart:convert';

import 'package:cars_api/models/companies/company_item.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as https;

class ApiProvider {
  static Future<List<CompanyItem>> getAllCompanies() async {
    try {
      Response res = await https.get(Uri.parse("https://easyenglishuzb.free.mockoapp.net/companies"));
      if (res.statusCode == 200){
        List<CompanyItem> companies = (jsonDecode(res.body)['data'] as List?)?.map((item) => CompanyItem.fromJson(item)).toList() ?? [];
        return companies;
      }
      else {
        throw Exception();
      }
    }
    catch (e){
      print(e.toString());
      throw Exception(e);
    }
  }
  static Future<CompanyItem> getSingleCompany({required int id}) async {
    try {
      Response res = await https.get(Uri.parse("https://easyenglishuzb.free.mockoapp.net/companies/$id"));
      if (res.statusCode == 200){
        CompanyItem company = CompanyItem.fromJson(jsonDecode(res.body));
        return company;
      }
      else {
        throw Exception();
      }
    }
    catch (e){
      print(e.toString());
      throw Exception(e);
    }
  }
}
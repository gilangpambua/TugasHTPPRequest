import 'dart:core';
import 'base_network.dart';

class ApiDataSource  {
  static ApiDataSource instace = ApiDataSource();

  Future<Map<String, dynamic>>loadUser(){
    return BaseNetwork.get("users");
  }

  Future<Map<String, dynamic>>loadDetailUser(int idDiterima){
    String id = idDiterima.toString();
    return BaseNetwork.get("users/$id");
  }

  loadUserById(int idUser) {}
}
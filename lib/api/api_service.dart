import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter_app/api/api.dart';
import 'package:flutter_starter_app/api/endpoints.dart';
import 'package:flutter_starter_app/config/config.dart';

class APIService {
  late API _api;
  static final APIService _instance = APIService._internal();

  factory APIService() {
    return _instance;
  }

  APIService._internal() {
    this._api = API(Config().apiHost );
  }


  Future<Response> getEndpointData({required Endpoint endpoint}) async{


    Uri uri = _api.endpointUri(endpoint);
    String path = uri.toString();

    final Response res = await _api.dio.get(path);

    if(res.statusCode == 200){
      return res;
    }
    throw res;
  }

  Future<Response> deleteEndpointData({required Endpoint endpoint, required String param}) async{


    Uri uri = _api.endpointUri(endpoint);
    String path = uri.toString();

    if(param != null)
      path += param;


    final Response res = await _api.dio.delete(path);

    if(res.statusCode == 200){
      return res;
    }
    throw res;
  }


  Future<Response> postFormData({required Endpoint endpoint, required FormData formData}) async{


    Uri uri = _api.endpointUri(endpoint);
    _api.dio.interceptors.add(LogInterceptor(requestBody: true,responseBody: true,request: true));
    String path = uri.toString();

    final Response res = await _api.dio.post(path,
        data: formData,
        options:Options(
          headers: {
            Headers.contentLengthHeader: formData.length, //// set content-length
            Headers.contentTypeHeader:'multipart/form-data'
          },
        )
    );



    if(res.statusCode == 200){
      return res;
    }

    throw res;

  }

}


class Config{
  static final Config _instance = Config._internal();

  String apiHost;


  factory Config(){
    return _instance;
  }

  Config._internal({this.apiHost = ""}){
    this.apiHost = "tdos-task-list-backend.herokuapp.com";

  }


}
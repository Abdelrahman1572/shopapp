class ChangeFavoritesModel {
  bool? status;
  String? message;
  ChangeFavoritesModel.forjson(Map<String ,dynamic> json){
    status = json['status'];
    message = json['message'];
  }
}
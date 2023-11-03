class UserModel{

  String? uid;
  String? fullName;
  String? email;
  String? prn;

  UserModel({this.uid, this.email, this.prn, this.fullName});

  UserModel.fromMap(Map<String, dynamic> map){
    uid = map["uid"];
    fullName = map["fullname"];
    email = map["email"];
    prn = map["prn"];
  }

  Map<String, dynamic> toMap() {
    return{
      "uid" : uid,
      "fullname" : fullName,
      "email" : email,
      "prn": prn,
    };
  }
}
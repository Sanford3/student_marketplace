class BookModel {
  String? uid;
  String? sellerId;
  String? sellerName;
  String? subjectName;
  String? bookName;
  String? bookAuthor;
  String? bookEdition;
  String? bookPrice;
  String? description;
  String? department;
  int? semester;
  String? imageUrl;

  BookModel({this.sellerId, this.sellerName, this.subjectName, this.bookName, this.bookAuthor, this.bookEdition, this.bookPrice, this.description, this.department, this.semester, this.imageUrl, this.uid});

  BookModel.fromMap(Map<String, dynamic> map){
    uid = map["uid"];
    sellerName = map["sellername"];
    sellerId = map["sellerid"];
    subjectName = map["subjectname"];
    bookName = map["bookname"];
    bookAuthor = map["author"];
    bookEdition = map["edition"];
    bookPrice = map["price"];
    description = map["description"];
    department = map["department"];
    semester = map["semester"];
    imageUrl = map["image"];
  }

  Map<String, dynamic> toMap() {
    return{
      "uid": uid,
      "sellerid" : sellerId,
      "sellername": sellerName,
      "subjectname": subjectName,
      "bookname" : bookName,
      "author" : bookAuthor,
      "edition" : bookEdition,
      "price": bookPrice,
      "description": description,
      "department" : department,
      "semester" : semester,
      "image": imageUrl
    };
  }
}
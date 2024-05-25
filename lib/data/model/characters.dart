
class Character{
  late int id;
  late  String firstName;
  late  String lastName;
  late  String image;
  late  String fullName;
  late  String title;
  late String family;
  late  String imageURL;


  Character.fromJson(Map <String , dynamic> json){
      id=json['id'];
      firstName=json['firstName'];
      lastName=json['lastName'];
      image=json['image'];
      fullName=json['fullName'];
      title=json['title'];
      family=json['family'];
      imageURL=json['imageUrl'];


  }
}
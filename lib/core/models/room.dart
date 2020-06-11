
class Room{
  // String owner;
  // String name;
  // String id;
  // List<String> members;

  String owner;
  String name;
  String id;
  List<dynamic> members;

  Room({this.owner, this.name, this.members, this.id});

  Room.formJson(Map<String, dynamic> json):
  this.owner = json['owner'],
  this.name = json['name'],
  this.id = json['_id'],
  this.members = json['members'];

  Map<String, dynamic> toJson() =>{
    'owner':owner,
    'name':name,
    'members':members,
    '_id':id,
  };
}
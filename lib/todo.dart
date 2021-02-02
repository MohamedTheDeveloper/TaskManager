

class Todo{

  int id;
  String title;
  String description;
  bool isDone;
  DateTime date;
  DateTime addedDate;

  Todo( { this.id , this.title , this.description , this.isDone , this.date , this.addedDate } );

  String toString(){
    return "id : $id , title : $title , desc : $description , isDone : $isDone";
  }
}
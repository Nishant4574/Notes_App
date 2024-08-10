import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'Boxes/boxes.dart';
import 'Model/notes_model.dart';
import 'package:hive_flutter/hive_flutter.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
final titleController =TextEditingController();
final descriptionController =TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes App",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.blue),),
        centerTitle: true,
      ),
body: ValueListenableBuilder<Box<NotesModel>>(valueListenable: Boxes.getData().listenable(),
  builder: (context,box,__){
  var data =box.values.toList().cast<NotesModel>();
return ListView.builder(
    itemCount: box.length,
    itemBuilder: (context,index){
  return Card(

    child:Padding(
      padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
      Row(
        children: [
          Text(data[index].title.toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          Spacer(),
          GestureDetector(
              onTap: (){
delete(data[index]);
              },
              child: Icon(Icons.delete,color: Colors.red,)),
          SizedBox(width: 15,),
          GestureDetector(
              onTap: (){
                _showmyEdited(data[index],data[index].title,data[index].desciption);
              },
              child: Icon(Icons.edit)),



        ],
      ),
          SizedBox(
            height: 5,
          ),
          Text(data[index].desciption.toString(),style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
        ],
      ),
    ),
  );
});
  },
  
),
      floatingActionButton: FloatingActionButton(
        elevation: 10,
       backgroundColor: Colors.amber,
        onPressed: ()async{
          setState(() {

          });
_showmyDialog();
        },child: Icon(Icons.add),
      ),
    );
  }
  void delete(NotesModel noteModel)async{
    await noteModel.delete();
  }
Future<void>_showmyEdited(NotesModel notesModel,String title,String description)async{
 titleController.text =title;
 descriptionController.text=description;

  return showDialog(context: context, builder: (context){
    return AlertDialog(
      title: Text("Add Notes"),
      content: SingleChildScrollView(
        child: Column(
          children: [

            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                  hintText: "Enter title",
                  border: OutlineInputBorder(

                  )
              ),
            ),SizedBox(
              height: 20,
            ),

            TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(
                  hintText: "Enter description",
                  border: OutlineInputBorder(

                  )
              ),
            ),
          ],
        ),
      ),
      actions: [

        TextButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text("Cancel")),
        TextButton(onPressed: ()async{
          Navigator.pop(context);
notesModel.title = titleController.text.toString();
notesModel.desciption =descriptionController.text.toString();
notesModel.save();
        }, child: Text("Edit"))
      ],
    );
  });
}
  Future<void>_showmyDialog()async{
return showDialog(context: context, builder: (context){
  return AlertDialog(
    title: Text("Add Notes"),
    content: SingleChildScrollView(
      child: Column(
        children: [

          TextFormField(
            controller: titleController,
            decoration: InputDecoration(
              hintText: "Enter title",
              border: OutlineInputBorder(

              )
            ),
          ),SizedBox(
            height: 20,
          ),

          TextFormField(
            controller: descriptionController,
            decoration: InputDecoration(
                hintText: "Enter description",
                border: OutlineInputBorder(

                )
            ),
          ),
        ],
      ),
    ),
    actions: [

      TextButton(onPressed: (){
        Navigator.pop(context);
      }, child: Text("Cancel")),
      TextButton(onPressed: (){
        final data =NotesModel(title: titleController.text, desciption: descriptionController.text);
        final box =Boxes.getData();
        box.add(data);
       // data.save();
        titleController.clear();
        descriptionController.clear();
        print(box);

        Navigator.pop(context);
      }, child: Text("Add"))
    ],
  );
});
}
}

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hive Database"),
      ),
body: Column(
  children: [
  FutureBuilder(future: Hive.openBox('File'), builder: (context,snapshot){
    return Column(
      children: [
Text(snapshot.data!.get("Name"))


      ],
    );
  })
  ],
),
      floatingActionButton: FloatingActionButton(onPressed: ()async{
var box = await Hive.openBox('File');
box.put("Name", "Abhi");
box.put("Age", "40");
box.put("details", {
  'pro':"developer",
  "Habit":"Cooking"
});
print(box.get("Name"));
print(box.get("Age"));
print(box.get("details"));
      },
      child: Icon(Icons.add),),
    );
  }
}

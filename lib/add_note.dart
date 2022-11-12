import 'package:flutter/material.dart';
import 'package:note_app/home.dart';
import 'package:note_app/sqldb.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({Key? key}) : super(key: key);

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  SqlDp sqlDp = SqlDp();

  GlobalKey<FormState> formstate = GlobalKey();

  TextEditingController note = TextEditingController();

  TextEditingController title = TextEditingController();

  TextEditingController color = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.black,
          title: const Text('Add Notes'),
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              SizedBox(
                height: 40,
              ),
              Form(
                  key: formstate,
                  child: Column(
                    children: [
                      TextFormField(
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        cursorColor: Colors.white,
                        controller: note,
                        decoration:
                        const InputDecoration(
                            fillColor: Colors.white10,
                            filled: true,
                            hintStyle: TextStyle(color: Colors.white ,fontSize: 13),
                            hintText: "Type note here"),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        cursorColor: Colors.white,
                        controller: title,
                        decoration:
                        const InputDecoration(
                            fillColor: Colors.white10,
                            filled: true,
                            hintStyle: TextStyle(color: Colors.white ,fontSize: 13),
                            hintText: "Type title here"),
                        maxLines: 25,
                      ),
                      TextFormField(
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        cursorColor: Colors.white,
                        controller: title,
                        decoration:
                        const InputDecoration(
                            fillColor: Colors.white10,
                            filled: true,
                            hintStyle: TextStyle(color: Colors.white ,fontSize: 13),
                            hintText: "Type title here"),
                        maxLines: 3,
                      ),
                      Container(
                        height: 20,
                      ),
                      MaterialButton(
                        textColor: Colors.white,
                        color: Colors.deepOrangeAccent,
                        onPressed: () async {
                          print(title.text);
                          // // int response = await sqlDp.insertData(
                          //     // '''
                          //     // INSERT INTO notes (note , title , color)
                          //     // VALUES ("${note.text}" , "${title.text}" , "${color
                          //     //     .text}")
                          //     // ''');
                          // int response = await sqlDp.insert("notes", {
                          //   "note" : "${note.text}" ,
                          //   "title" : "${note.text}" ,
                          //   "color" : "${note.text}" ,
                          // });
                          // if (response > 0) {
                          //   // ignore: use_build_context_synchronously
                          //   Navigator.of(context).pushAndRemoveUntil(
                          //       MaterialPageRoute(builder: (context) => const Home()), (
                          //       route) => false) ;
                          // }
                          // print("respone=========================");
                          // print(response);
                        },
                        child: const Text(
                          "Add Note",
                        ),
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

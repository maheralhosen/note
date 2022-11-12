import 'package:flutter/material.dart';
import 'package:note_app/home.dart';
import 'package:note_app/sqldb.dart';

class EditNote extends StatefulWidget {

  final note;
  final title;
  final id;
  final color;

  const EditNote({Key? key, this.note, this.title, this.id, this.color})
      : super(key: key);

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  SqlDp sqlDp = SqlDp();

  GlobalKey<FormState> formstate = GlobalKey();

  TextEditingController note = TextEditingController();

  TextEditingController title = TextEditingController();

  TextEditingController color = TextEditingController();

  @override
  void initState() {
    note.text = widget.note;
    title.text = widget.title;
    color.text = widget.color;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.black,
          title: const Text('Edit Notes'),
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
                            hintText: "Type title here"),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(

                        style: TextStyle(
                          color: Colors.white,

                        ),
                        cursorColor: Colors.white10,
                        controller: title,
                        decoration: const InputDecoration(
                          fillColor: Colors.white10,
                          filled: true,
                          hintStyle: TextStyle(color: Colors.white ,fontSize: 13),
                          hintText: "Type note here"),

                        maxLines: 25,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: color,
                        decoration:
                        const InputDecoration(hintText: "color"),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      MaterialButton(
                        textColor: Colors.white,
                        color: Colors.deepOrangeAccent,
                        onPressed: () async {
                          // int response = await sqlDp.updateData('''
                          //     UPDATE notes SET
                          //     note = "${note.text}" ,
                          //     title = "${title.text}" ,
                          //     color = "${color.text}"
                          //     WHERE id = ${widget.id}
                          //     ''');
                          int response = await sqlDp.update("notes",
                              {
                            "note" : "${note.text}",
                            "color" : "${color.text}",
                                "title" : "${title.text}"
                          },
                              "id = ${widget.id}");
                          if (response > 0) {
                            // ignore: use_build_context_synchronously
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => const Home()),
                                    (route) => false);
                          }
                          print("respone=========================");
                          print(response);
                        },
                        child: const Text(
                          "Edit Note",
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

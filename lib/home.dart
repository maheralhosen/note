import 'package:flutter/material.dart';
import 'package:note_app/edit_notes.dart';
import 'package:note_app/sqldb.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SqlDp sqlDp = SqlDp();
  bool isLoading = true;

  List notes = [];

  Future readData() async {
    List<Map> response = await sqlDp.read("notes");
    notes.addAll(response);
    isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed("addnotes");
          },
          child: const Icon(Icons.add),
          backgroundColor: Colors.deepOrangeAccent,
        ),
        appBar: AppBar(
          titleTextStyle: TextStyle(),
          elevation: 0.0,
          backgroundColor: Colors.black,
          title: Text(
            "All Notes",
            style: TextStyle(fontSize: 30),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Icon(Icons.menu_sharp),
            ),
          ],
        ),
        body: isLoading == true
            ? const Center(child: Text("Loading ...",style: TextStyle(color: Colors.white),))
            : Container(
                child: ListView(
                  children: [
                    // MaterialButton(
                    //   onPressed: () async{
                    //     await sqlDp.mydeletedatabase() ;
                    //   },
                    //   child: const Text("delete database"),
                    // ),
                    SizedBox(
                      height: 100,
                    ),
                    ListView.builder(
                        itemCount: notes.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, i) {
                          return Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            child: Card(
                              color: Colors.white10,
                              elevation: 0.0,
                              child: ListTile(
                                title: Text(
                                  "${notes[i]['note']}",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25),
                                ),
                                subtitle: Text(
                                  "${notes[i]['title']}",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                        onPressed: () async {
                                          // int respone = await sqlDp.deleteData(
                                          //     "DELETE FROM notes WHERE id = ${notes[i]['id']} ");
                                          int respone = await sqlDp.delete(
                                              "notes",
                                              "id = ${notes[i]['id']}");
                                          if (respone > 0) {
                                            notes.removeWhere((element) =>
                                                element['id'] ==
                                                notes[i]['id']);
                                            setState(() {});
                                          }
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.deepOrangeAccent,
                                        )),
                                    IconButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) => EditNote(
                                                      color: notes[i]['color'],
                                                      title: notes[i]['title'],
                                                      note: notes[i]['note'],
                                                      id: notes[i]['id'],
                                                    )),
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.edit,
                                          color: Colors.blue,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white10,
                            ),
                          );
                        }),
                  ],
                ),
              ),
      ),
    );
  }
}

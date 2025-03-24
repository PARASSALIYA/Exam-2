import 'package:exam/views/likednotes/controller/likednotes_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../firestore/firestore.dart';
import '../../helper/helper.dart';
import '../../utills/routes.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController noteController = TextEditingController();
    LikedNotesController controller = Get.put(LikedNotesController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff9a9dbe),
        foregroundColor: Colors.white,
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () {
              controller.fetchLikedNotes();
              Get.toNamed(GetPages.likedNotes);
            },
            icon: const Icon(Icons.favorite),
          ),
        ],
      ),
      body: Column(children: [
        Expanded(
          child: StreamBuilder(
              stream: FirestoreService.firestoreService.getNotes(),
              builder: (context, snapshot) {
                var data = snapshot.data;
                List allData = data!.docs;
                if (allData.isEmpty) {
                  return const Center(
                    child: Text('No Notes'),
                  );
                }
                return ListView.builder(
                  itemCount: allData.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        DatabaseHelper.databaseHelper.insert(
                          note: allData[index]['notes'],
                        );
                      },
                      onLongPress: () {
                        noteController.text = allData[index]['notes'];
                        Get.dialog(
                          AlertDialog(
                            title: const Text("Edit Notes"),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
                                  controller: noteController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Notes',
                                  ),
                                ),
                                const SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: () {
                                    FirestoreService.firestoreService
                                        .updateNotes(allData[index].id,
                                            noteController.text);
                                    Get.back();
                                    noteController.clear();
                                  },
                                  child: const Text('Submit'),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      title: Text("${allData[index]['notes']}"),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          FirestoreService.firestoreService
                              .deleteNotes(allData[index].id);
                        },
                      ),
                    );
                  },
                );
              }),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff9a9dbe),
        foregroundColor: Colors.white,
        onPressed: () {
          Get.dialog(
            AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: noteController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Notes',
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      FirestoreService.firestoreService
                          .addNotes(noteController.text);
                      Get.back();
                      noteController.clear();
                    },
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

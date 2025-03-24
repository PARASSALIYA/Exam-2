import 'package:exam/views/likednotes/controller/likednotes_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LikeNotesPage extends StatelessWidget {
  const LikeNotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    LikedNotesController controller = Get.put(LikedNotesController());
    controller.fetchLikedNotes();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff9a9dbe),
        foregroundColor: Colors.white,
        title: const Text('Liked Notes'),
      ),
      body: GetBuilder<LikedNotesController>(
        builder: (context) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: controller.likedNotes.length,
                  itemBuilder: (context, index) {
                    if (controller.likedNotes.isEmpty) {
                      const Center(
                        child: Text(
                          'No liked notes yet!',
                        ),
                      );
                    }
                    return ListTile(
                      title: Text(
                        controller.likedNotes[index].note ??
                            'No note available',
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          var id = controller.likedNotes[index].id;
                          controller.delete(controller.likedNotes[index].id);
                          controller.fetchLikedNotes();
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

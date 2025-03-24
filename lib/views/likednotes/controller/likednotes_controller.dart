import 'package:exam/helper/helper.dart';
import 'package:exam/model/model.dart';
import 'package:get/get.dart';

class LikedNotesController extends GetxController {
  List<NoteModel> likedNotes = [];
  Future<void> fetchLikedNotes() async {
    likedNotes = await DatabaseHelper.databaseHelper.fetchData();
    update();
  }

  void delete(int id) async {
    DatabaseHelper.databaseHelper.deleteData(id);
    Get.snackbar('Deleted', 'Note removed from Liked Notes');
    fetchLikedNotes();
    update();
  }
}

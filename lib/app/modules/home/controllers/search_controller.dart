import 'package:get/get.dart';
import 'package:meds_record/app/data/models/user_model.dart';
import 'package:meds_record/app/services/firestore_service.dart';

class SearchingController extends GetxController {
  var query = ''.obs;
  var users = <UserModel>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    debounce(query, (_) => searchUser(),
        time: const Duration(milliseconds: 1000));
    super.onInit();
  }

  void searchUser() async {
    if (query.value.isEmpty) {
      users.clear();
      return;
    }

    isLoading.value = true;

    try {
      final result =
          await FirestoreService().searchUsers(query.value, 'patient');
      users.assignAll(result);
    } finally {
      isLoading.value = false;
    }
  }
}

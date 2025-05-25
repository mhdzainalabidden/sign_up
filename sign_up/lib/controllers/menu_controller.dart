import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:sign_up/models/menu_add_image_model.dart';
import '../models/menu_model.dart';
import '../services/menu_service.dart';
// import 'package:image_picker/image_picker.dart';

class MenuListController extends GetxController {
  final MenuService _service = Get.find();

  var items = <MenuModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchItems();
  }

  Future<void> fetchItems() async {
    isLoading(true);
    try {
      final list = await _service.fetchMenuItems();
      items.value = list;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteItem(int id) async {
    if (await _service.deleteMenuItem(id)) {
      items.removeWhere((e) => e.id == id);
      Get.snackbar('Deleted', 'Item removed');
    } else {
      Get.snackbar('Error', 'Failed to delete');
    }
  }

  //
  Future<bool> addItem(MenuAddImageModel item) async {
    if (await _service.addMenuItem(item)) {
      Get.snackbar('Success', 'Item added successfully');
      Get.back();
      await fetchItems();
      return true;
    }
    return false;
  }

  Future<PlatformFile?> pickImage() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,

        withData: true, // important for getting bytes on web
      );

      if (result != null && result.files.isNotEmpty) {
        return result.files.first;
      }

      return null;
    } catch (e) {
      Get.snackbar(
        'Failed to pick image',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );

      return null;
    }
  }
}

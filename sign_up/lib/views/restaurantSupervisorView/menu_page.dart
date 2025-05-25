import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:sign_up/controllers/menu_controller.dart';
import 'package:sign_up/models/menu_add_image_model.dart';
import '../restaurantSupervisorView/main_layout.dart';
import '../restaurantSupervisorView/menu_componant/menu_card.dart';

class MenuPage extends StatelessWidget {
  final MenuListController ctrl = Get.put(MenuListController());

  MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Restaurant Menu Dashboard',
                  style: TextStyle(fontSize: 7.sp, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  onPressed: _showAddDialog,
                  child: Text('Add New Item'),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: Obx(() {
                if (ctrl.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 16.w,
                    crossAxisSpacing: 16.w,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: ctrl.items.length,
                  itemBuilder:
                      (_, i) => MenuCard(
                        item: ctrl.items[i],
                        onDelete: () => ctrl.deleteItem(ctrl.items[i].id),
                      ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddDialog() {
    final arName = ''.obs;
    final enName = ''.obs;
    final arDesc = ''.obs;
    final enDesc = ''.obs;
    final type = ''.obs;
    final price = ''.obs;
    final selected = Rx<PlatformFile?>(null);

    Get.defaultDialog(
      title: 'Add Menu Item',
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              onChanged: (v) => arName.value = v,
              decoration: InputDecoration(labelText: 'Arabic Name'),
            ),
            TextField(
              onChanged: (v) => enName.value = v,
              decoration: InputDecoration(labelText: 'English Name'),
            ),
            TextField(
              onChanged: (v) => arDesc.value = v,
              decoration: InputDecoration(labelText: 'Arabic Desc'),
            ),
            TextField(
              onChanged: (v) => enDesc.value = v,
              decoration: InputDecoration(labelText: 'English Desc'),
            ),
            SizedBox(height: 10.h),
            Obx(() {
              if (selected.value != null) {
                final bytes = selected.value!.bytes!;
                return Column(
                  children: [
                    Image.memory(
                      bytes,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    Text(
                      selected.value!.name.length > 10
                          ? '${selected.value!.name.substring(0, 10)}...'
                          : selected.value!.name,
                    ),
                  ],
                );
              }
              return Text(
                'No image selected',
                style: TextStyle(
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
              );
            }),
            ElevatedButton(
              onPressed: () async {
                final pick = await ctrl.pickImage();
                if (pick != null) {
                  selected.value = pick;
                } else {
                  Get.snackbar('Error', 'No image selected');
                }
              },
              child: Text('Select Photo'),
            ),
            TextField(
              onChanged: (v) => type.value = v,
              decoration: InputDecoration(labelText: 'Type'),
            ),
            TextField(
              onChanged: (v) => price.value = v,
              decoration: InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
      textConfirm: 'Add',
      onConfirm: () async {
        // Validation
        if (selected.value == null ||
            arName.value.trim().isEmpty ||
            enName.value.trim().isEmpty ||
            arDesc.value.trim().isEmpty ||
            enDesc.value.trim().isEmpty ||
            type.value.trim().isEmpty ||
            price.value.trim().isEmpty) {
          Get.snackbar('Error', 'All fields are required');
          return;
        }

        final item = MenuAddImageModel(
          id: 0,
          arName: arName.value.trim(),
          enName: enName.value.trim(),
          arDescription: arDesc.value.trim(),
          enDescription: enDesc.value.trim(),
          type: type.value.trim(),
          price: price.value.trim(),
          photo: selected.value!,
        );

        final success = await ctrl.addItem(item);
        if (success == false) {
          // Close dialog and refresh
          Get.back();
          await ctrl.fetchItems();
          Get.snackbar(
            'Success',
            'Item added successfully',
            snackPosition: SnackPosition.BOTTOM,
            // ignore: deprecated_member_use
            backgroundColor: Colors.green.withOpacity(0.8),
            colorText: Colors.white,
          );
        } else {
          Get.snackbar('Error', 'Failed to add item');
        }
      },
      textCancel: 'Cancel',
      onCancel: () => Get.back(),
    );
  }
}

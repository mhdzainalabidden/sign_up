// lib/pages/add_menu_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:alyarmok_hotel/modules/supervisor/controllers/menu_controller.dart';
import 'package:alyarmok_hotel/modules/supervisor/models/menu_add_image_model.dart';

class AddMenuPage extends StatelessWidget {
  final MenuListController ctrl = Get.find<MenuListController>();

  AddMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    // قائمة الأنواع المسموح بها
    final List<String> allowedTypes = [
      'Appetizers',
      'Main_Course',
      'Desserts',
      'Drinks',
    ];

    // متغيّرات الحالة التفاعلية
    final arName = ''.obs;
    final enName = ''.obs;
    final arDesc = ''.obs;
    final enDesc = ''.obs;
    final type = ''.obs;
    final price = ''.obs;
    final selected = Rx<PlatformFile?>(null);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Menu Item'),
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(12.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // الحقول النصية الخاصة بالأسماء والوصف
              TextField(
                onChanged: (v) => arName.value = v,
                decoration: InputDecoration(
                  labelText: 'Arabic Name',
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 8.h,
                    horizontal: 12.w,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              TextField(
                onChanged: (v) => enName.value = v,
                decoration: InputDecoration(
                  labelText: 'English Name',
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 8.h,
                    horizontal: 12.w,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              TextField(
                onChanged: (v) => arDesc.value = v,
                decoration: InputDecoration(
                  labelText: 'Arabic Desc',
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 8.h,
                    horizontal: 12.w,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              TextField(
                onChanged: (v) => enDesc.value = v,
                decoration: InputDecoration(
                  labelText: 'English Desc',
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 8.h,
                    horizontal: 12.w,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              ),
              SizedBox(height: 12.h),

              // معاينة الصورة (إذا تم اختيارها)
              Obx(() {
                if (selected.value != null) {
                  final bytes = selected.value!.bytes!;
                  return Column(
                    children: [
                      Image.memory(
                        bytes,
                        width: 120.w,
                        height: 120.w,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        selected.value!.name.length > 20
                            ? '${selected.value!.name.substring(0, 15)}...'
                            : selected.value!.name,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 12.sp),
                      ),
                      SizedBox(height: 12.h),
                    ],
                  );
                }
                return Text(
                  'No image selected',
                  style: TextStyle(
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                    fontSize: 5.sp,
                  ),
                );
              }),

              // زر اختيار الصورة
              ElevatedButton.icon(
                onPressed: () async {
                  final pick = await ctrl.pickImage();
                  if (pick != null) {
                    selected.value = pick;
                  } else {
                    Get.snackbar('Error', 'No image selected');
                  }
                },
                icon: const Icon(Icons.photo),
                label: Text('Select Photo', style: TextStyle(fontSize: 8.sp)),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 10.h,
                  ),
                ),
              ),
              SizedBox(height: 12.h),

              // استبدل حقل الـ TextField الخاص بالـ type بالقائمة المنسدلة
              LayoutBuilder(
                builder: (context, constraints) {
                  return DropdownButtonFormField<String>(
                    value: type.value.isEmpty ? null : type.value,
                    decoration: InputDecoration(
                      labelText: 'Type',
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 8.h,
                        horizontal: 12.w,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    items:
                        allowedTypes
                            .map(
                              (t) => DropdownMenuItem<String>(
                                value: t,
                                child: Text(
                                  t,
                                  style: TextStyle(fontSize: 5.sp),
                                ),
                              ),
                            )
                            .toList(),
                    onChanged: (v) {
                      if (v != null) {
                        type.value = v;
                      }
                    },
                    hint: Text(
                      'Select Type',
                      style: TextStyle(fontSize: 5.sp, color: Colors.grey),
                    ),
                  );
                },
              ),
              SizedBox(height: 8.h),

              // حقل السعر
              TextField(
                onChanged: (v) => price.value = v,
                decoration: InputDecoration(
                  labelText: 'Price',
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 8.h,
                    horizontal: 12.w,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),

              SizedBox(height: 24.h),
              // زر الإرسال
              SizedBox(
                width: 200.w,
                child: ElevatedButton(
                  onPressed: () async {
                    // التحقق من تعبئة جميع الحقول
                    if (selected.value == null ||
                        arName.value.trim().isEmpty ||
                        enName.value.trim().isEmpty ||
                        arDesc.value.trim().isEmpty ||
                        enDesc.value.trim().isEmpty ||
                        type.value.trim().isEmpty ||
                        price.value.trim().isEmpty) {
                      Get.snackbar(
                        'Error',
                        'All fields are required',
                        snackPosition: SnackPosition.BOTTOM,
                      );
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
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.r),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    child: Text('Add Item', style: TextStyle(fontSize: 10.sp)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

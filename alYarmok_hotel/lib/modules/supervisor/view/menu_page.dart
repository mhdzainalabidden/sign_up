import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:alyarmok_hotel/modules/supervisor/controllers/menu_controller.dart';
import 'main_layout.dart';
import 'menu_componant/menu_card.dart';
import 'package:alyarmok_hotel/modules/supervisor/view/menu_componant/add_menu_item.dart';

class MenuPage extends StatelessWidget {
  final MenuListController ctrl = Get.put(MenuListController());

  MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));

    final width = MediaQuery.of(context).size.width;
    int crossCount;
    if (width >= 1200) {
      crossCount = 4;
    } else if (width >= 800) {
      crossCount = 3;
    } else if (width >= 600) {
      crossCount = 2;
    } else {
      crossCount = 1;
    }

    return MainLayout(
      child: Padding(
        padding: EdgeInsets.all(9.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // العنوان وزر الإضافة
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Restaurant Menu Dashboard',
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(48.w, 48.h),
                    backgroundColor: const Color.fromARGB(255, 235, 235, 235),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.w,
                      vertical: 5.h,
                    ),
                  ),
                  onPressed: () {
                    // هنا نستدعي صفحة إضافة العنصر الجديد
                    Get.to(() => AddMenuPage());
                  },
                  child: FittedBox(
                    child: Text(
                      'add new item',
                      style: TextStyle(
                        fontSize: 6.sp,
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),

            // قائمة العناصر (لا تغيير هنا)
            Expanded(
              child: Obx(() {
                if (ctrl.isLoading.value) {
                  return Center(
                    child: SizedBox(
                      width: 40.w,
                      height: 40.w,
                      child: const CircularProgressIndicator(),
                    ),
                  );
                }
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossCount,
                    mainAxisExtent: width >= 1200 ? 300.h : 180.h,
                    mainAxisSpacing: 5.h,
                    crossAxisSpacing: 5.w,
                    childAspectRatio: 0.99,
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
}

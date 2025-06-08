// lib/restaurantSupervisorView/menu_componant/menu_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../models/menu_model.dart';
import 'package:image_network/image_network.dart';

class MenuCard extends StatelessWidget {
  final MenuModel item;
  final VoidCallback onDelete;

  const MenuCard({super.key, required this.item, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
              child: ImageNetwork(
                image: item.photo,
                height: 200.h,
                width: 50.w,
                duration: 100,
                fitAndroidIos: BoxFit.cover,
                fitWeb: BoxFitWeb.cover,
                onLoading: Center(
                  child: SizedBox(
                    width: 30.w,
                    height: 30.w,
                    child: const CircularProgressIndicator(),
                  ),
                ),
                onError: const Icon(Icons.error, color: Colors.red),
                borderRadius: BorderRadius.circular(12.r),
                onTap: () {
                  showDialog(
                    context: context,
                    builder:
                        (_) => AlertDialog(
                          content: Text(item.enDescription),
                          title: Text(item.arDescription),
                        ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(2.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.enName,
                  style: TextStyle(fontSize: 5.sp, fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 6.h),
                Text(
                  item.type,
                  style: TextStyle(fontSize: 5.sp, color: Colors.grey),
                ),
                SizedBox(height: 6.h),

                Text(
                  '\$${item.price}',
                  style: TextStyle(fontSize: 5.sp, color: Colors.green),
                ),
                SizedBox(width: 10.w),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onDelete,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                    ),
                    child: Text(
                      'Delete',
                      style: TextStyle(fontSize: 5.sp, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

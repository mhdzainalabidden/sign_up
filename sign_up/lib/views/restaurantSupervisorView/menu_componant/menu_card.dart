import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../models/menu_model.dart';
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
              // child: Image.network('${item.photo}', fit: BoxFit.cover),
              child: ImageNetwork(
                image: item.photo,
                height: 155.h,
                width: 66.w,
                duration: 100,
                // curve: Curves.bounceOut,
                onPointer: true,
                debugPrint: false,
                backgroundColor: Colors.blue,
                fitAndroidIos: BoxFit.cover,
                fitWeb: BoxFitWeb.cover,
                onLoading: const CircularProgressIndicator(
                  color: Colors.indigoAccent,
                ),
                onError: const Icon(Icons.error, color: Colors.red),
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  showDialog(
                    context: context,
                    builder:
                        (_) => const AlertDialog(
                          content: Text("©gabrielpatricksouza"),
                        ),
                  );
                },
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.all(8.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.enName,
                  style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4.h),
                Text(
                  item.type,
                  style: TextStyle(fontSize: 4.sp, color: Colors.grey),
                ),
                SizedBox(height: 4.h),
                Text(
                  '\$${item.price}',
                  style: TextStyle(fontSize: 4.sp, color: Colors.green),
                ),
                SizedBox(height: 8.h),
                ElevatedButton(
                  onPressed: onDelete,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                  ),
                  child: const Text('Delete'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore: duplicate_ignore
// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fl_chart/fl_chart.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';

// import '../controller/dashboard_controller.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});
  // final DashboardController controller = getIt<DashboardController>();

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return Scaffold(
      drawer: isMobile ? Drawer(child: _SidebarContent()) : null,
      body: SafeArea(
        child: Row(
          children: [
            if (!isMobile)
              Container(
                width: 100.w,
                color: Colors.grey.shade100,
                child: _SidebarContent(),
              ),

            // Main content
            Expanded(
              child: Column(
                children: [
                  // Top bar
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                      vertical: 16.h,
                    ),
                    color: Colors.white,
                    child: Row(
                      children: [
                        if (isMobile)
                          Builder(
                            builder:
                                (context) => IconButton(
                                  icon: Icon(Icons.menu),
                                  onPressed:
                                      () => Scaffold.of(context).openDrawer(),
                                ),
                          ),
                        Text(
                          'Dashboard',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 24.w),
                        if (!isMobile)
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search...',
                                prefixIcon: Icon(Icons.search),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                              ),
                            ),
                          ),
                        if (!isMobile) ...[
                          SizedBox(width: 16.w),
                          Text(
                            DateTime.now().toString().split(' ')[0],
                            style: TextStyle(
                              fontSize: 8.sp,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(width: 16.w),
                          ElevatedButton(
                            onPressed: () {},
                            child: Text('Create booking'),
                          ),
                          SizedBox(width: 16.w),
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                              'https://i.pravatar.cc/300',
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),

                  // Overview cards
                  Padding(
                    padding: EdgeInsets.all(24.w),
                    child: Wrap(
                      spacing: 16.w,
                      runSpacing: 16.h,
                      children: [
                        _StatCard(
                          label: "Today's Check-in",
                          value: 'Today s Check-in',
                        ),
                        _StatCard(
                          label: "Today's Check-out",
                          value: "Today's Check-out",
                        ),
                        _StatCard(
                          label: 'Total In Hotel',
                          value: 'Total In Hotel',
                        ),
                        _StatCard(
                          label: 'Available room',
                          value: 'Available room',
                        ),
                        _StatCard(
                          label: 'Occupied room',
                          value: 'Occupied room',
                        ),
                      ],
                    ),
                  ),

                  // Scrollable content
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            // Room type cards
                            SizedBox(
                              height: 200.h,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  _RoomTypeCard(
                                    title: 'Single sharing',
                                    used: 2,
                                    total: 30,
                                    price: 568,
                                  ),
                                  _RoomTypeCard(
                                    title: 'Double sharing',
                                    used: 2,
                                    total: 35,
                                    price: 1068,
                                  ),
                                  _RoomTypeCard(
                                    title: 'Triple sharing',
                                    used: 2,
                                    total: 25,
                                    price: 1568,
                                  ),
                                  _RoomTypeCard(
                                    title: 'VIP Suit',
                                    used: 4,
                                    total: 10,
                                    price: 2568,
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 24.h),

                            // Room status & Floor status
                            Flex(
                              direction:
                                  isMobile ? Axis.vertical : Axis.horizontal,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(child: _RoomStatusPanel()),
                                SizedBox(
                                  width: isMobile ? 0 : 16.w,
                                  height: isMobile ? 16.h : 0,
                                ),
                                Expanded(child: _FloorStatusPanel()),
                              ],
                            ),

                            SizedBox(height: 24.h),

                            // Occupancy Statistics & Restaurant Profit
                            Flex(
                              direction:
                                  isMobile ? Axis.vertical : Axis.horizontal,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(child: _OccupancyChartPanel()),
                                SizedBox(
                                  width: isMobile ? 0 : 16.w,
                                  height: isMobile ? 16.h : 0,
                                ),
                                Expanded(child: _RestaurantProfitPanel()),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SidebarContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Column(
    children: [
      SizedBox(height: 20.h),
      _SidebarItem(icon: Icons.dashboard, label: 'Dashboard'),
      _SidebarItem(icon: Icons.meeting_room, label: 'Rooms Details'),
      _SidebarItem(icon: Icons.person, label: 'Employment Management'),
      _SidebarItem(icon: Icons.book, label: 'Manage Reservations'),
    ],
  );
}

// -- Widgets --

class _StatCard extends StatelessWidget {
  final String label;
  final String value;

  const _StatCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60.w,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 8.sp, color: Colors.grey)),
          SizedBox(height: 8.h),
          Text(
            value,
            style: TextStyle(
              fontSize: 8.sp,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}

class _OccupancyChartPanel extends StatelessWidget {
  const _OccupancyChartPanel();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Occupancy Statistics",
                  style: TextStyle(fontSize: 8.sp, fontWeight: FontWeight.w600),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.calendar_today, size: 8.sp),
                  label: Text("Monthly"),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.grey[100],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      side: const BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            SizedBox(
              height: 100.h,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 100,
                  barTouchData: BarTouchData(enabled: false),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        interval: 25,
                        getTitlesWidget:
                            (value, _) => Text("${value.toInt()}%"),
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 1,
                        getTitlesWidget: (value, _) {
                          const months = [
                            'May',
                            'Jun',
                            'Jul',
                            'Aug',
                            'Sep',
                            'Oct',
                            'Nov',
                            'Dec',
                            'Jan',
                            'Feb',
                          ];
                          return Text(
                            months[value.toInt()],
                            style: TextStyle(fontSize: 10.sp),
                          );
                        },
                      ),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  gridData: FlGridData(show: true, horizontalInterval: 25),
                  borderData: FlBorderData(show: false),
                  barGroups: _buildBarGroups(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<BarChartGroupData> _buildBarGroups() {
    final values = [85, 65, 80, 40, 100, 85, 85, 85, 100, 100];
    return List.generate(values.length, (index) {
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: values[index].toDouble(),
            width: 14,
            borderRadius: BorderRadius.circular(4),
            color: const Color(0xFF3B82F6),
          ),
        ],
      );
    });
  }
}

class _RoomStatusPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Room Status",
            style: TextStyle(fontSize: 8.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: _StatusColumn(
                  title: 'Occupied Rooms',
                  items: {'Clean': 90, 'Dirty': 4, 'Inspected': 60},
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: _StatusColumn(
                  title: 'Available Rooms',
                  items: {'Clean': 30, 'Dirty': 19, 'Inspected': 30},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatusColumn extends StatelessWidget {
  final String title;
  final Map<String, int> items;

  const _StatusColumn({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 8.h),
        ...items.entries.map(
          (e) => Padding(
            padding: EdgeInsets.symmetric(vertical: 2.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(e.key, style: TextStyle(fontSize: 8.sp)),
                Text(e.value.toString(), style: TextStyle(fontSize: 8.sp)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _FloorStatusPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        children: [
          Text(
            "Floor Status",
            style: TextStyle(fontSize: 8.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.h),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 50.w,
                height: 50.h,
                child: CustomPaint(painter: _SemiCirclePainter()),
              ),
              Text(
                "80%",
                style: TextStyle(fontSize: 8.sp, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Container(width: 10.w, height: 10.h, color: Colors.blue),
                  SizedBox(width: 4.w),
                  Text('Completed'),
                ],
              ),
              Row(
                children: [
                  Container(width: 10.w, height: 10.h, color: Colors.grey),
                  SizedBox(width: 4.w),
                  Text('Pending'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SemiCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 12
          ..color = Colors.blue;

    final rect = Rect.fromLTWH(0, 0, size.width, size.height * 2);
    final startAngle = 3.14;
    final sweepAngle = 3.14;

    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _SidebarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  const _SidebarItem({required this.icon, required this.label});
  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.symmetric(vertical: 12.h),
    child: Row(
      children: [
        SizedBox(width: 16.w),
        Icon(icon, color: Colors.blue),
        SizedBox(width: 12.w),
        Text(label, style: TextStyle(fontSize: 8.sp)),
      ],
    ),
  );
}

class _RoomTypeCard extends StatelessWidget {
  final String title;
  final int used;
  final int total;
  final int price;
  const _RoomTypeCard({
    required this.title,
    required this.used,
    required this.total,
    required this.price,
  });
  @override
  Widget build(BuildContext context) => Container(
    width: 120.w,
    margin: EdgeInsets.only(right: 16.w),
    padding: EdgeInsets.all(16.w),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.r),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: Colors.green[100],
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: Text('2 Deals', style: TextStyle(fontSize: 12.sp)),
        ),
        SizedBox(height: 8.h),
        Text(
          title,
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
        ),
        Spacer(),
        Text(
          '$used/$total',
          style: TextStyle(fontSize: 14.sp, color: Colors.grey[700]),
        ),
        SizedBox(height: 4.h),
        Text(
          '\$$price/day',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
      ],
    ),
  );
}

class _RestaurantProfitPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextStyle labelStyle = Theme.of(
      context,
    ).textTheme.bodySmall!.copyWith(color: Colors.grey[600]);
    TextStyle valueStyle = Theme.of(
      context,
    ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600);

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Restaurant  Profit",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 20),
            _buildProfitRow(
              "Week's",
              "Total Revenue",
              "313\$",
              labelStyle,
              valueStyle,
            ),
            const Divider(),
            _buildProfitRow(
              "Week's",
              "Total Orders",
              "55",
              labelStyle,
              valueStyle,
            ),
            const Divider(),
            _buildProfitRow(
              "Week's",
              "Total Delivered",
              "1200",
              labelStyle,
              valueStyle,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfitRow(
    String title,
    String subtitle,
    String value,
    TextStyle labelStyle,
    TextStyle valueStyle,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: labelStyle),
            Text(subtitle, style: labelStyle),
          ],
        ),
        Text(value, style: valueStyle),
      ],
    );
  }
}

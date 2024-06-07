import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> daysOfWeek = ["T2", "T3", "T4", "T5", "T6"];
  final List<Map<String, dynamic>> menuData = [
    {
      "day": "T2",
      "meals": [
        {"type": "Bữa trưa", "menu": ["Bánh trứng nhện", "Cháo cá rau cải xanh"]},
        {"type": "Bữa chiều", "menu": ["Phở bò"]}
      ]
    },
    {
      "day": "T3",
      "meals": []
    },
    {
      "day": "T4",
      "meals": []
    },
    {
      "day": "T5",
      "meals": []
    },
    {
      "day": "T6",
      "meals": [
        {"type": "Bữa trưa", "menu": ["Bánh trứng nhện", "Cháo cá rau cải xanh"]},
        {"type": "Bữa chiều", "menu": ["Phở bò"]}
      ]
    },

  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: daysOfWeek.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget buildMealCard(Map<String, dynamic> meal) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(meal['type'], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            ...meal['menu'].map<Widget>((item) {
              return Text(item, style: TextStyle(fontSize: 16));
            }).toList(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thực đơn tuần'),
        bottom: TabBar(
          controller: _tabController,
          tabs: menuData.map((day) => Tab(text: '${day["day"]}')).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: menuData.map((day) {
          return ListView(
            children: day['meals'].isNotEmpty
                ? day['meals'].map<Widget>((meal) => buildMealCard(meal)).toList()
                : [Center(child: Text('Không có dữ liệu'))],
          );
        }).toList(),
      ),
    );
  }
}


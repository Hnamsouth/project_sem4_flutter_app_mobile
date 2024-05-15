import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
List<String> breakfastDishes = ['Omelette', 'Toast', 'Fruit Salad'];
List<String> lunchDishes = ['Grilled Chicken', 'Steamed Vegetables', 'Brown Rice'];
List<String> dinnerDishes = ['Salmon', 'Quinoa Salad', 'Stir-fried Tofu'];

// Khởi tạo thực đơn cho mỗi ngày trong tuần
List<Menu> weeklyMenu = [
  Menu('Thứ 2', Meal('Breakfast', breakfastDishes), Meal('Lunch', lunchDishes), Meal('Dinner', dinnerDishes)),
  Menu('Thứ 3', Meal('Breakfast', breakfastDishes), Meal('Lunch', lunchDishes), Meal('Dinner', dinnerDishes)),
  Menu('Thứ 4', Meal('Breakfast', breakfastDishes), Meal('Lunch', lunchDishes), Meal('Dinner', dinnerDishes)),
  Menu('Thứ 5', Meal('Breakfast', breakfastDishes), Meal('Lunch', lunchDishes), Meal('Dinner', dinnerDishes)),
  Menu('Thứ 6', Meal('Breakfast', breakfastDishes), Meal('Lunch', lunchDishes), Meal('Dinner', dinnerDishes)),
  Menu('Thứ 7', Meal('Breakfast', breakfastDishes), Meal('Lunch', lunchDishes), Meal('Dinner', dinnerDishes)),
];


class Meal {
  late String name;
  late List<String> dishes;

  Meal(this.name, this.dishes);
}

class Menu {
  late String day;
  late Meal breakfast;
  late Meal lunch;
  late Meal dinner;

  Menu(this.day, this.breakfast, this.lunch, this.dinner);
}

class MealScreen extends StatefulWidget {
  const MealScreen({super.key});

  @override
  State<MealScreen> createState() => _MealScreenState();
}

class _MealScreenState extends State<MealScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thực đơn"),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: ListView.builder(
          itemCount: weeklyMenu.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  weeklyMenu[index].day,
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                ),
                SizedBox(height: 10),
                DataTable(
                  columns: [
                    DataColumn(label: Text('Sáng :',
                      style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),
                    )
                    ),

                  ],
                  rows: weeklyMenu[index].breakfast.dishes.map((dish) {
                    return DataRow(
                      cells: [
                        DataCell(Text(dish)),
                      ],
                    );
                  }).toList(),
                ),
                SizedBox(height: 10),
                DataTable(
                  columns: [
                    DataColumn(label: Text('Trưa :', style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),)),
                  ],
                  rows: weeklyMenu[index].lunch.dishes.map((dish) {
                    return DataRow(
                      cells: [
                        DataCell(Text(dish)),
                      ],
                    );
                  }).toList(),
                ),
                SizedBox(height: 10),
                DataTable(
                  columns: [
                    DataColumn(label: Text('Chiều :', style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),)),
                  ],
                  rows: weeklyMenu[index].dinner.dishes.map((dish) {
                    return DataRow(
                      cells: [
                        DataCell(Text(dish)),
                      ],
                    );
                  }).toList(),
                ),
                Divider(),
              ],
            );
          },
        ),
      ),
    );
  }
}





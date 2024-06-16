import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meds_record/app/modules/home/controllers/navigation_controller.dart';

import '../../../../data/menu_item.dart';
import '../../../../utils/imageprodiver.dart';
import '../widget/custom_gridmenu.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final BottomNavigationController _controller = Get.find();

  final List<MenuItem> menuItems = [
    MenuItem(Icons.location_history_rounded, 'My Record', route: 1),
    MenuItem(Icons.my_library_books_rounded, 'List', route: 2),
    MenuItem(Icons.settings, 'Setting', route: 3),
    MenuItem(Icons.move_to_inbox_rounded, 'Receive', routeName: '/receive'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(image: Images().imageProvider),
        const SizedBox(height: 52),
        Expanded(
          child: GridView.builder(
              itemCount: menuItems.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0),
              itemBuilder: (context, index) {
                final menuItem = menuItems[index];
                return CustomGridMenu(menuItem,
                    onTap: menuItem.route != null
                        ? () {
                            _controller.changePage(menuItem.route!);
                          }
                        : () {
                            if (menuItem.routeName != null) {
                              Get.toNamed(menuItem.routeName!);
                            }
                          });
              }),
        )
      ],
    );
  }
}

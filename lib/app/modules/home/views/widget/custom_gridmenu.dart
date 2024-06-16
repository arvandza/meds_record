import 'package:flutter/material.dart';
import 'package:meds_record/app/data/menu_item.dart';

class CustomGridMenu extends StatelessWidget {
  final MenuItem menuItem;
  final VoidCallback? onTap;

  const CustomGridMenu(this.menuItem, {this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      elevation: 5,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        splashColor: Colors.blue.shade100,
        highlightColor: Colors.blue.shade200,
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Colors.blue, Colors.purple],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds),
              child: Icon(menuItem.icon, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 8),
            Text(menuItem.title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }
}

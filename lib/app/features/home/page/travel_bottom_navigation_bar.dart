import 'package:flutter/material.dart';

class TravelBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const TravelBottomNavigationBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: 'Viagens',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.camera_alt),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.description),
          label: 'Documentos',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people),
          label: 'Pessoas',
        ),
      ],
      currentIndex: currentIndex,
      onTap: onTap,
      backgroundColor: Colors.white,
      selectedItemColor: const Color(0xFF0A4DA1),
      unselectedItemColor: Colors.black38,
      showUnselectedLabels: true,
      selectedFontSize: 12,
      unselectedFontSize: 12,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    );
  }
}

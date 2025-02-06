import 'package:attendance_edit/ui/absent/absent_screen.dart';
import 'package:attendance_edit/ui/attendance/attendance.dart';
import 'package:attendance_edit/ui/attendance_history/attendance_history_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // Disable the back button
      // ignore: deprecated_member_use
      onPopInvoked: (bool didPop) async {
        if (!didPop) {
          final shouldPop = await _onWillPop(context);
          if (shouldPop) {
            Navigator.of(context).pop(true);
          }
        }
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.indigo[800]!, Colors.indigo[600]!])),
          child: SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Welcome Mate',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber[100],
                        height: 1.3)),
                Text('What you want to do?',
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber[100],
                        height: 1.3)),
                SizedBox(height: 40),
                Expanded(
                    child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 0.9, // p/l
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  children: [
                    _buildMenuCard(
                        icon: Icons.camera,
                        color: Colors.amberAccent,
                        title: 'Attendance',
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const AttendScreen()));
                        }),
                    _buildMenuCard(
                        icon: Icons.beach_access_rounded,
                        color: Colors.greenAccent,
                        title: 'Leave',
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AbsentScreen()));
                        }),
                    _buildMenuCard(
                        icon: Icons.history_rounded,
                        color: Colors.purpleAccent,
                        title: 'History',
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const AttendanceHistoryScreen()));
                        }),
                    _buildMenuCard(
                        icon: Icons.logout,
                        color: Colors.redAccent,
                        title: 'Exit',
                        onTap: () async {
                          final shouldPop = await _onWillPop(context);
                          if (shouldPop) {
                            Navigator.of(context).pop(true);
                          }
                        }),
                  ],
                ))
              ],
            ),
          )),
        ),
      ),
    );
  }

  Widget _buildMenuCard(
      {required IconData icon,
      required Color color,
      required String title,
      required VoidCallback onTap}) {
    return Material(
        borderRadius: BorderRadius.circular(20),
        elevation: 6,
        child: InkWell(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.indigo.shade400),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: color),
                  child: Icon(
                    icon,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 15),
                Text(title,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1))
              ],
            ),
          ),
        ));
  }

  Future<bool> _onWillPop(BuildContext context) async {
    return await showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) => AlertDialog(
                  title: Text('Confirm Exit'),
                  content: Text('Are you sure you want to exit?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text('No'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text('Yes'),
                    ),
                  ],
                )) ??
        false;
  }
}

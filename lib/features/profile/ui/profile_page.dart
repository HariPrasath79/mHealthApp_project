import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:project_cdm/features/authentication/auth_page.dart';
import 'package:project_cdm/features/authentication/service/shared_prefs.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();

    await GoogleSignIn().signOut();
    await SharedPrefs.removeSignInStatus();
  }

  @override
  Widget build(BuildContext context) {
    final box = Hive.box('services');
    final totalCal = box.get('totalcal');
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: MaterialButton(
        shape: const CircleBorder(),
        color: Colors.blue,
        padding: const EdgeInsets.all(15),
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text(
          ' Page',
          style: GoogleFonts.outfit(fontWeight: FontWeight.w500),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: height * 0.25,
            child: PieChart(
              PieChartData(
                pieTouchData: PieTouchData(enabled: true),
                sections: [
                  PieChartSectionData(
                      value: 80, color: Colors.green, showTitle: true),
                  PieChartSectionData(
                    value: 20,
                    color: Colors.red,
                    showTitle: true,
                  ),
                ],
                centerSpaceRadius: 50,
                sectionsSpace: 0,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Total Calories: $totalCal',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          MaterialButton(
            color: Colors.amber,
            onPressed: () {
              signOut().then((value) => Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const AuthPage())));
            },
            child: const Text('Log Out'),
          ),
        ],
      ),
    );
  }
}

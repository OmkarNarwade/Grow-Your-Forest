import 'dart:async';
import 'package:flutter/material.dart';
import 'task_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const TaskScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B342F),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.park_rounded,
                size: 70,
                color: Colors.greenAccent,
              ),
              const SizedBox(height: 20),
              Text(
                'Grow Your Forest',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.greenAccent.shade100,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.fitness_center, color: Colors.white70),
                  SizedBox(width: 8),
                  Text(
                    'Complete 3 Healthy Tasks Daily',
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.eco, color: Colors.white70),
                  SizedBox(width: 8),
                  Text(
                    'Plant Trees & Track Progress',
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              const CircularProgressIndicator(
                color: Colors.greenAccent,
              ),
              const SizedBox(height: 20),
              const Text(
                'Loading your forest...',
                style: TextStyle(fontSize: 14, color: Colors.white38),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

void main() => runApp(const ModernPersonalInfoApp());

class ModernPersonalInfoApp extends StatelessWidget {
  const ModernPersonalInfoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personal Info App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueGrey,
          brightness: Brightness.light,
        ),
      ),
      home: const PersonalInfoScreen(),
    );
  }
}

class ProjectModel {
  final String title;
  final String subtitle;
  final String details;
  final IconData icon;

  const ProjectModel({
    required this.title,
    required this.subtitle,
    required this.details,
    required this.icon,
  });
}

class PersonalInfoScreen extends StatelessWidget {
  const PersonalInfoScreen({super.key});

  final List<ProjectModel> myProjects = const [
    ProjectModel(
      title: 'E-Commerce Store App(Kotlin, Jetcompose UI',
      subtitle: 'Flutter & REST API integration with modern UI.',
      details: 'A fully functional cross-platform e-commerce application built with Flutter and Dart. Features dynamic product catalog loading via REST APIs, custom cart management, and interactive star ratings.',
      icon: Icons.shopping_bag_rounded,
    ),
    ProjectModel(
      title: 'Mehandi Hub',
      subtitle: 'big mehandi portal',
      details: 'Mehandi station will be designed using Kotlin, Flutter',
      icon: Icons.task_alt_rounded,
    ),
    ProjectModel(
      title: 'Fitness Metrics Tracker',
      subtitle: 'Health dashboard with interactive metrics visualization.',
      details: 'A comprehensive health and wellness tracker displaying daily step counts, calorie burn, and workout metrics with custom card widgets and responsive UI alignment.',
      icon: Icons.fitness_center_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Clean, professional dark slate/blue-grey background
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        title: const Text('Personal Information', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: true,
        backgroundColor: const Color(0xFF1E293B),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            // Profile Photo with high contrast ring
            const CircleAvatar(
              radius: 56,
              backgroundColor: Colors.blueAccent,
              child: CircleAvatar(
                radius: 53,
                backgroundImage: AssetImage('assets/profile_img.png'),
              ),
            ),
            const SizedBox(height: 16),
            // Name & Title (High-contrast bright white & light silver for clarity)
            const Text(
              'Nandhini Murugesan',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 4),
            const Text(
              'Mobile App Developer',
              style: TextStyle(fontSize: 15, color: Color(0xFF94A3B8), fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 24),

            // Skills Card Section
            Card(
              elevation: 4,
              color: const Color(0xFF1E293B),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Core Skills', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: const [
                        Chip(label: Text('Kotlin'), backgroundColor: Color(0xFF334155), labelStyle: TextStyle(color: Colors.white)),
                        Chip(label: Text('Jetcompose'), backgroundColor: Color(0xFF334155), labelStyle: TextStyle(color: Colors.white)),
                        Chip(label: Text('Flutter'), backgroundColor: Color(0xFF334155), labelStyle: TextStyle(color: Colors.white)),
                        Chip(label: Text('Dart'), backgroundColor: Color(0xFF334155), labelStyle: TextStyle(color: Colors.white)),
                        Chip(label: Text('UI Design'), backgroundColor: Color(0xFF334155), labelStyle: TextStyle(color: Colors.white)),
                        Chip(label: Text('REST APIs'), backgroundColor: Color(0xFF334155), labelStyle: TextStyle(color: Colors.white)),
                        Chip(label: Text('Git & GitHub'), backgroundColor: Color(0xFF334155), labelStyle: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Projects Card Section (Interactive)
            Card(
              elevation: 4,
              color: const Color(0xFF1E293B),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 12.0, top: 8.0, bottom: 4.0),
                      child: Text('Featured Projects', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                    ),
                    const SizedBox(height: 6),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: myProjects.length,
                      itemBuilder: (context, index) {
                        final project = myProjects[index];
                        return ListTile(
                          leading: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.blueAccent.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(project.icon, color: Colors.blueAccent),
                          ),
                          title: Text(project.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white)),
                          subtitle: Text(project.subtitle, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8))),
                          trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Color(0xFF94A3B8)),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProjectDetailPage(project: project),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Contact Info Section
            Card(
              elevation: 4,
              color: const Color(0xFF1E293B),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                child: Column(
                  children: const [
                    ListTile(
                      leading: Icon(Icons.email_outlined, color: Colors.blueAccent),
                      title: Text('nandhini@gmail.com', style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white)),
                    ),
                    Divider(height: 1, indent: 16, endIndent: 16, color: Color(0xFF334155)),
                    ListTile(
                      leading: Icon(Icons.phone_outlined, color: Colors.blueAccent),
                      title: Text('+91 9876543210', style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white)),
                    ),
                    Divider(height: 1, indent: 16, endIndent: 16, color: Color(0xFF334155)),
                    ListTile(
                      leading: Icon(Icons.location_on_outlined, color: Colors.blueAccent),
                      title: Text('Chennai', style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Separate Page for Project Details
class ProjectDetailPage extends StatelessWidget {
  final ProjectModel project;

  const ProjectDetailPage({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        title: Text(project.title, style: const TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF1E293B),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.blueAccent.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(project.icon, size: 64, color: Colors.blueAccent),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              project.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 8),
            Text(
              project.subtitle,
              style: const TextStyle(fontSize: 16, color: Color(0xFF94A3B8), fontWeight: FontWeight.w500),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Divider(color: Color(0xFF334155)),
            ),
            const Text(
              'Project Overview',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 10),
            const Text(
              'Detailed documentation and core architecture implementation overview goes here. Built with optimized performance and scalability in mind.',
              style: TextStyle(fontSize: 15, color: Color(0xFFCBD5E1), height: 1.6),
            ),
          ],
        ),
      ),
    );
  }
}
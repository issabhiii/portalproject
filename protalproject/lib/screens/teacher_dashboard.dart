import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart'; // for pretty time formatting
import '../providers/class_schedule_provider.dart';

class TeacherDashboard extends StatelessWidget {
  const TeacherDashboard({super.key});

  // ================= Performance Section =================
  Widget buildPerformanceCard() {
    final stats = [
      {"label": "Overall Score", "value": 88},
      {"label": "Attendance", "value": 100},
      {"label": "Punctuality", "value": 100},
      {"label": "Engagement", "value": 100},
      {"label": "Class Feedback", "value": 100},
      {"label": "Trial Won", "value": 62},
      {"label": "Batch Retention", "value": 56},
    ];

    return Card(
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: stats.map((s) {
              return GestureDetector(
                onTap: () {
                  debugPrint("Clicked ${s['label']}");
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 60,
                            height: 60,
                            child: CircularProgressIndicator(
                              value: (s['value'] as int) / 100.0,
                              backgroundColor: Colors.grey[700],
                              color: Colors.amber,
                              strokeWidth: 6,
                            ),
                          ),
                          Text(
                            "${s['value']}",
                            style: const TextStyle(
                              color: Colors.amber,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      SizedBox(
                        width: 70,
                        child: Text(
                          s['label'] as String,
                          style: const TextStyle(
                            color: Colors.amber,
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  // ================= Session Quality =================
  Widget buildSessionQualityIndicator() {
    final dates = [
      {"label": "[placeholder_date]", "ok": true},
      {"label": "[placeholder_date]", "ok": true},
      {"label": "[placeholder_date]", "ok": false},
      {"label": "[placeholder_date]", "ok": true},
    ];

    return Card(
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: dates.map((d) {
            return GestureDetector(
              onTap: () {
                debugPrint("Clicked date ${d['label']}");
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                decoration: BoxDecoration(
                  color:
                      (d['ok'] as bool) ? Colors.green[700] : Colors.red[700],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  d['label'] as String,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  // ================= Learning Status =================
  Widget buildLearningStatus() {
    return Card(
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildLearningTile("0", "Not Started"),
            buildLearningTile("0", "In Progress"),
            buildLearningTile("0", "Overdue"),
            buildLearningTile("12", "Completed"),
          ],
        ),
      ),
    );
  }

  Widget buildLearningTile(String count, String label) {
    return GestureDetector(
      onTap: () {
        debugPrint("Clicked $label");
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(count,
                style: const TextStyle(
                    color: Colors.amber,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(label,
                style: const TextStyle(color: Colors.white, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  // ================= To-Do =================
  Widget buildToDoSection() {
    return Card(
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 8,
              children: [
                buildToDoChip("Need Attention (1)"),
                buildToDoChip("Feedbacks (PTM)"),
                buildToDoChip("Assignments (1)"),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.warning, color: Colors.amber),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("[placeholder_name] (Indian Vocals)",
                            style: TextStyle(color: Colors.amber)),
                        Text(
                          "[placeholder_name] is now eligible for Radio Mirchi Performance!",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      debugPrint("Add Comments tapped");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text("Add Comments"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildToDoChip(String label) {
    return GestureDetector(
      onTap: () {
        debugPrint("$label tapped");
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.red[800],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(label,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }

  // ================= Upcoming Classes (Dynamic) =================
  Widget buildUpcomingClasses(BuildContext context) {
    final scheduleProvider = context.watch<ClassScheduleProvider>();
    final upcoming = scheduleProvider.classes;

    if (upcoming.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            "No classes scheduled yet",
            style: TextStyle(color: Colors.amber, fontSize: 16),
          ),
        ),
      );
    }

    final timeFormat = DateFormat('EEE, dd MMM - hh:mm a');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: upcoming.map((c) {
        return Card(
          color: Colors.grey[900],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: ListTile(
            title: Text(
              c.title,
              style: const TextStyle(color: Colors.amber, fontSize: 16),
            ),
            subtitle: Text(
              "${timeFormat.format(c.startTime)} → ${timeFormat.format(c.endTime)}",
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
            trailing: ElevatedButton(
              onPressed: () {
                debugPrint("Join class tapped: ${c.title}");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text("Join"),
            ),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Row(
        children: [
          // Side nav
          Container(
            width: 60,
            color: Colors.grey[850],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                SideNavItem(icon: Icons.home, tooltip: 'Home'),
                SideNavItem(icon: Icons.group, tooltip: 'View Students'),
                SideNavItem(icon: Icons.menu_book, tooltip: 'Classes'),
                SideNavItem(icon: Icons.settings, tooltip: 'Settings'),
                SideNavItem(icon: Icons.chat, tooltip: 'Chat'),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: ListView(
                      children: [
                        buildPerformanceCard(),
                        const SizedBox(height: 12),
                        buildSessionQualityIndicator(),
                        const SizedBox(height: 12),
                        buildLearningStatus(),
                        const SizedBox(height: 12),
                        buildToDoSection(),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 1,
                    child: SingleChildScrollView(
                      child: buildUpcomingClasses(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ================= Side Nav Item =================
class SideNavItem extends StatefulWidget {
  final IconData icon;
  final String tooltip;
  const SideNavItem({super.key, required this.icon, required this.tooltip});

  @override
  State<SideNavItem> createState() => _SideNavItemState();
}

class _SideNavItemState extends State<SideNavItem> {
  bool _clicked = false;
  OverlayEntry? _overlayEntry;

  void _showTooltip(BuildContext context) {
    final box = context.findRenderObject() as RenderBox;
    final offset = box.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx + 60,
        top: offset.dy + 12,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 6,
                  offset: const Offset(2, 2),
                )
              ],
            ),
            child: Text(
              widget.tooltip,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ),
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hideTooltip() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _showTooltip(context),
      onExit: (_) => _hideTooltip(),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _clicked = true;
          });
          Future.delayed(const Duration(milliseconds: 150), () {
            if (mounted) setState(() => _clicked = false);
          });
          debugPrint("${widget.tooltip} clicked");

          // 👉 Navigation
          if (widget.tooltip == 'Classes') {
            Navigator.pushNamed(context, '/schedule');
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: 60,
          height: 60,
          color: _clicked ? Colors.grey[700] : Colors.transparent,
          child: Icon(widget.icon, color: Colors.amber, size: 28),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key, required this.quizHistory});

  final List<int> quizHistory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close),
                      color: Colors.white,
                    ),
                    const Text(
                      'RESULTS HISTORY',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 25.0,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 24),
                    if (quizHistory.isEmpty)
                      const Text(
                        'No previous results yet.',
                        style: TextStyle(color: Colors.white),
                      ),
                    for (var i = 0; i < quizHistory.length; i++)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 50,
                            child: Text('${(i + 1)}.   - -',
                                style: TextStyle(color: Colors.white)),
                          ),
                          Text('${quizHistory[i]} points',
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:foodreminder/screen/wearos/recommendation.dart';
import 'package:wear/wear.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

int _selectedIndexRecommendation = 0;
final PageController _pageControllerRecommendation =
    PageController(initialPage: 0);

final List<Widget> _recommendation = [
  const WatchRecommendationBreakfastCard(),
  const WatchRecommendationLunchCard(),
  const WearRecommendationDinnerCard(),
];

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return WatchShape(
        builder: (BuildContext context, WearShape shape, Widget? child) {
      return AmbientMode(builder: (context, mode, child) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Today's Recommendation",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 52,
                            height: 20,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    _selectedIndexRecommendation == 0
                                        ? Colors.teal
                                        : Colors.grey.shade900,
                                elevation: 8,
                              ),
                              onPressed: () {
                                _pageControllerRecommendation.animateToPage(0,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.ease);
                              },
                              child: const Text(
                                "Break",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 6,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 2),
                          SizedBox(
                            width: 52,
                            height: 20,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    _selectedIndexRecommendation == 1
                                        ? Colors.teal
                                        : Colors.grey.shade900,
                                elevation: 8,
                              ),
                              onPressed: () {
                                _pageControllerRecommendation.animateToPage(1,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.ease);
                              },
                              child: const Text(
                                "Lunch",
                                style: TextStyle(
                                  fontSize: 6,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 2),
                          SizedBox(
                            width: 52,
                            height: 20,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    _selectedIndexRecommendation == 2
                                        ? Colors.teal
                                        : Colors.grey.shade900,
                                elevation: 8,
                              ),
                              onPressed: () {
                                _pageControllerRecommendation.animateToPage(2,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.ease);
                              },
                              child: const Text(
                                "Dinner",
                                style: TextStyle(
                                  fontSize: 6,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 200,
                        child: PageView(
                          physics: const BouncingScrollPhysics(),
                          controller: _pageControllerRecommendation,
                          onPageChanged: (index) {
                            setState(() {
                              _selectedIndexRecommendation = index;
                            });
                          },
                          children: _recommendation,
                        ),
                      ),
                    ]),
              ),
            ),
          ),
        );
      });
    });
  }
}

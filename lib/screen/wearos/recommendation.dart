import 'package:flutter/material.dart';
import 'package:foodreminder/model/recommendation.dart';
import 'package:foodreminder/repository/recommend_repository.dart';
import 'package:wear/wear.dart';

class WatchRecommendationBreakfastCard extends StatefulWidget {
  const WatchRecommendationBreakfastCard({super.key});

  @override
  State<WatchRecommendationBreakfastCard> createState() =>
      _WatchRecommendationBreakfastCardState();
}

class _WatchRecommendationBreakfastCardState
    extends State<WatchRecommendationBreakfastCard> {
  @override
  Widget build(BuildContext context) {
    return WatchShape(
        builder: (BuildContext context, WearShape shape, Widget? child) {
      return AmbientMode(builder: (context, mode, child) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return FutureBuilder(
                future: RecommendRepositoryImpl().getRecommendedBreakfastFood(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Recommend> foods = snapshot.data!;
                    return ListView.builder(
                      itemCount: foods.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, index) {
                        Recommend food = foods[index];
                        return Card(
                          color: Colors.teal,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            title: Column(
                              children: [
                                const Padding(padding: EdgeInsets.only(top: 0)),
                                Text(
                                  food.name,
                                  style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '${food.calories} Calories',
                                  style: const TextStyle(
                                      fontSize: 8, color: Colors.white70),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                  // else if (snapshot.hasError) {
                  //   return Text("${snapshot.error}");
                  // }
                  return const Center(
                      child:
                          Text("Service Not Available, We Are Working on it"));
                });
          },
        );
      });
    });
  }
}

class WatchRecommendationLunchCard extends StatefulWidget {
  const WatchRecommendationLunchCard({super.key});

  @override
  State<WatchRecommendationLunchCard> createState() =>
      _WatchRecommendationLunchCardState();
}

class _WatchRecommendationLunchCardState
    extends State<WatchRecommendationLunchCard> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return FutureBuilder(
            future: RecommendRepositoryImpl().getRecommendedLunchFood(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Recommend> foods = snapshot.data!;
                return ListView.builder(
                  itemCount: foods.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, index) {
                    Recommend food = foods[index];
                    return Card(
                      color: Colors.teal,
                      child: ListTile(
                        title: Column(
                          children: [
                            const Padding(padding: EdgeInsets.only(top: 0)),
                            Text(
                              food.name,
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${food.calories} Calories',
                              style: const TextStyle(
                                  fontSize: 8, color: Colors.white70),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
              // else if (snapshot.hasError) {
              //   return Text("${snapshot.error}");
              // }
              return const Center(
                  child: Text("Service Not Available, We Are Working on it"));
            });
      },
    );
  }
}

class WearRecommendationDinnerCard extends StatefulWidget {
  const WearRecommendationDinnerCard({super.key});

  @override
  State<WearRecommendationDinnerCard> createState() =>
      _WearRecommendationDinnerCardState();
}

class _WearRecommendationDinnerCardState
    extends State<WearRecommendationDinnerCard> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return FutureBuilder(
            future: RecommendRepositoryImpl().getRecommendedDinnerFood(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Recommend> foods = snapshot.data!;
                return ListView.builder(
                  itemCount: foods.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, index) {
                    Recommend food = foods[index];
                    return Card(
                      color: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        title: Column(
                          children: [
                            const Padding(padding: EdgeInsets.only(top: 0)),
                            Text(
                              food.name,
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${food.calories} Calories',
                              style: const TextStyle(
                                  fontSize: 8, color: Colors.white70),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
              //  else if (snapshot.hasError) {
              //   return Text("${snapshot.error}");
              // }
              return const Center(
                  child: Text("Service Not Available, We Are Working on it"));
            });
      },
    );
  }
}

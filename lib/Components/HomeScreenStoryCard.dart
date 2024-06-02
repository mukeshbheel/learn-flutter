import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Utils/Constant.dart';
import 'GradientText.dart';
import 'NeumorphismContainer.dart';

class HomeScreenStoryCard extends StatelessWidget {
  HomeScreenStoryCard({super.key, required this.storyData});
  QueryDocumentSnapshot<Map<String, dynamic>> storyData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NeumorphismContainer(
          child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 90,
                        height: 90,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            storyData['image'],
                            fit: BoxFit.cover,
                            errorBuilder: errorBuilder,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GradientText(
                            storyData['title'],
                            gradient: greenGradient,
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          GradientText(
                            storyData['type'] == 1
                                ? 'Normal story'
                                : 'Story with Random words',
                            gradient: greyGradient,
                          ),
                        ],
                      )
                    ],
                  )
                ],
              )),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

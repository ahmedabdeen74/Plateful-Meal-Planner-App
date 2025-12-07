import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCardSwiper extends StatelessWidget {
  const ShimmerCardSwiper({super.key});

  @override
  Widget build(BuildContext context) {
    final double cardWidth = MediaQuery.of(context).size.width * 0.8;
    final double cardHeight = MediaQuery.of(context).size.height * 0.48;

    return Center(
      child: SizedBox(
        height: cardHeight,
        width: cardWidth,
        child: PageView.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
            return Stack(
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: cardWidth,
                      height: cardHeight,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      width: cardWidth,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 14,
                            width: 120,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 6),
                          Container(height: 12, width: 80, color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

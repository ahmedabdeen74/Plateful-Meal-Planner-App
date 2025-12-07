import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerSearchResultItem extends StatelessWidget {
  const ShimmerSearchResultItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(height: 20, color: Colors.white),
      ),
    );
  }
}

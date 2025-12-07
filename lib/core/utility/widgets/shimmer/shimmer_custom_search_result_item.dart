import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCustomSearchResultItem extends StatelessWidget {
  const ShimmerCustomSearchResultItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListTile(
        leading: CircleAvatar(radius: 24, backgroundColor: Colors.white),
        title: Container(width: 100, height: 16, color: Colors.white),
        subtitle: Container(width: 60, height: 14, color: Colors.white),
      ),
    );
  }
}

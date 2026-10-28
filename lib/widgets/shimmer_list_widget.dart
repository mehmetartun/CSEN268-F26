import 'package:material_ui/material_ui.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerListWidget extends StatelessWidget {
  const ShimmerListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: Column(
        children: List.generate(10, (index) {
          return Container(
            height: 50,

            width: double.infinity,
            margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(2)),
              ),
              color: Colors.white,
            ),
          );
        }),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class UserCircleContainer extends StatefulWidget {
  const UserCircleContainer({super.key, required this.url});

  final String url;

  @override
  State<UserCircleContainer> createState() => _UserCircleContainerState();
}

class _UserCircleContainerState extends State<UserCircleContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 9.w,
      height: 9.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0, 1),
          )
        ],
        image: DecorationImage(
          image: NetworkImage(
            widget.url,
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

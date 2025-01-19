import 'package:course_travel/features/destination/domain/entities/DestinationEntity.dart';
import 'package:flutter/material.dart';

class DetailDestination extends StatefulWidget {
  const DetailDestination({super.key, required this.destination});
  final DestinationEntity destination;

  @override
  State<DetailDestination> createState() => _DetailDestinationState();
}

class _DetailDestinationState extends State<DetailDestination> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: Text(
        widget.destination.name,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
      centerTitle: true,
      automaticallyImplyLeading: false,
      flexibleSpace: Container(
        margin:
            EdgeInsets.only(left: 20, top: MediaQuery.of(context).padding.top),
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            BackButton(),
          ],
        ),
      ),
    );
  }
}

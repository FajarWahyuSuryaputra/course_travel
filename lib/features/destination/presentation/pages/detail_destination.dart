import 'package:course_travel/api/urls.dart';
import 'package:course_travel/features/destination/domain/entities/DestinationEntity.dart';
import 'package:course_travel/features/destination/presentation/widget/gallery_photo.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../widget/circle_loading.dart';

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
      appBar: header(),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 30),
        children: [
          SizedBox(
            height: 10,
          ),
          gallery(),
        ],
      ),
    );
  }

  Widget gallery() {
    List patternGallery = [
      StaggeredTile.count(3, 3),
      StaggeredTile.count(2, 1.5),
      StaggeredTile.count(2, 1.5),
    ];
    return StaggeredGridView.countBuilder(
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      crossAxisCount: 5,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 3,
      staggeredTileBuilder: (index) {
        return patternGallery[index % patternGallery.length];
      },
      itemBuilder: (context, index) {
        if (index == 2) {
          return GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) =>
                      GalleryPhoto(images: widget.destination.images));
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  itemGalleryImage(index),
                  Container(
                    color: Colors.black.withOpacity(0.3),
                    alignment: Alignment.center,
                    child: Text(
                      '+ More',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }
        return ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: itemGalleryImage(index));
      },
    );
  }

  ClipRRect itemGalleryImage(int index) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: ExtendedImage.network(
        URLs.image(widget.destination.images[index]),
        fit: BoxFit.cover,
        handleLoadingProgress: true,
        loadStateChanged: (state) {
          if (state.extendedImageLoadState == LoadState.failed) {
            return AspectRatio(
              aspectRatio: 16 / 9,
              child: Material(
                borderRadius: BorderRadius.circular(16),
                color: Colors.grey[300],
                child: const Icon(
                  Icons.broken_image,
                  color: Colors.black,
                ),
              ),
            );
          }
          if (state.extendedImageLoadState == LoadState.loading) {
            return AspectRatio(
              aspectRatio: 16 / 9,
              child: Material(
                borderRadius: BorderRadius.circular(16),
                color: Colors.grey[300],
                child: const CircleLoading(),
              ),
            );
          }
          return null;
        },
      ),
    );
  }

  AppBar header() {
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

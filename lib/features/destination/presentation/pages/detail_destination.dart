import 'package:course_travel/api/urls.dart';
import 'package:course_travel/features/destination/domain/entities/DestinationEntity.dart';
import 'package:course_travel/features/destination/presentation/widget/gallery_photo.dart';
import 'package:d_method/d_method.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
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
        padding: const EdgeInsets.symmetric(horizontal: 30),
        children: [
          const SizedBox(
            height: 10,
          ),
          gallery(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  location(),
                  const SizedBox(
                    height: 10,
                  ),
                  category(),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  rate(),
                  const SizedBox(
                    height: 10,
                  ),
                  rateCount(),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          facilities(),
          const SizedBox(
            height: 24,
          ),
          details(),
          const SizedBox(
            height: 24,
          ),
          reviews(),
        ],
      ),
    );
  }

  Widget reviews() {
    List list = [
      ['Jhon Dipsy', 'assets/images/p1.jpg', 4.9, 'Best place', '2023-01-02'],
      [
        'Mikael Lunch',
        'assets/images/p2.jpg',
        4.7,
        'Unforgettable',
        '2023-03-21'
      ],
      ['Dinner Sopi', 'assets/images/p3.jpg', 5.0, 'Nice one', '2023-09-02'],
      [
        'Loro Sepuh',
        'assets/images/p4.jpg',
        4.4,
        'You should go with your family',
        '2023-09-24'
      ],
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Reviews',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        ...list.map((review) {
          return Padding(
            padding: EdgeInsets.only(top: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 15,
                  backgroundImage: AssetImage(review[1]),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            review[0],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          RatingBarIndicator(
                            rating: double.parse(review[2].toString()),
                            unratedColor: Colors.grey,
                            itemBuilder: (context, index) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            itemSize: 12,
                          ),
                          Spacer(),
                          Text(
                            DateFormat('d MMM')
                                .format(DateTime.parse(review[4])),
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        review[3],
                        style: TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
        SizedBox(
          height: 14,
        ),
      ],
    );
  }

  Widget details() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Details',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          widget.destination.description,
          style: TextStyle(fontSize: 16, color: Colors.black54),
        ),
      ],
    );
  }

  Widget facilities() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Facilities',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        ...widget.destination.facilities.map((facility) {
          return Padding(
            padding: EdgeInsets.only(top: 8),
            child: Row(
              children: [
                Icon(
                  Icons.radio_button_checked,
                  color: Theme.of(context).primaryColor,
                  size: 15,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  facility,
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                )
              ],
            ),
          );
        }).toList()
      ],
    );
  }

  Widget location() {
    return Row(
      children: [
        Container(
          height: 20,
          width: 20,
          alignment: Alignment.centerLeft,
          child: Icon(
            Icons.location_on,
            color: Theme.of(context).primaryColor,
            size: 20,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          widget.destination.location,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black54,
          ),
        )
      ],
    );
  }

  Widget category() {
    return Row(
      children: [
        Container(
          height: 20,
          width: 20,
          alignment: Alignment.center,
          child: Icon(
            Icons.fiber_manual_record,
            color: Theme.of(context).primaryColor,
            size: 15,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          widget.destination.category,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black54,
          ),
        )
      ],
    );
  }

  Widget rate() {
    return RatingBarIndicator(
      rating: widget.destination.rate,
      unratedColor: Colors.grey,
      itemBuilder: (context, index) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
      itemSize: 15,
    );
  }

  Widget rateCount() {
    String rate = DMethod.numberAutoDigit(widget.destination.rate);
    String rateCount =
        NumberFormat.compact().format(widget.destination.rateCount);
    return Text(
      '$rate / $rateCount reviews',
      style: TextStyle(fontSize: 14, color: Colors.grey[500]),
    );
  }

  Widget gallery() {
    List patternGallery = [
      const StaggeredTile.count(3, 3),
      const StaggeredTile.count(2, 1.5),
      const StaggeredTile.count(2, 1.5),
    ];
    return StaggeredGridView.countBuilder(
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      crossAxisCount: 5,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
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
                    child: const Text(
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
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
      centerTitle: true,
      automaticallyImplyLeading: false,
      flexibleSpace: Container(
        margin:
            EdgeInsets.only(left: 20, top: MediaQuery.of(context).padding.top),
        alignment: Alignment.centerLeft,
        child: const Row(
          children: [
            BackButton(),
          ],
        ),
      ),
    );
  }
}

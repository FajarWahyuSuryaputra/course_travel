import 'package:course_travel/api/urls.dart';
import 'package:course_travel/common/app_route.dart';
import 'package:course_travel/features/destination/domain/entities/DestinationEntity.dart';
import 'package:course_travel/features/destination/presentation/bloc/search_destination/search_destination_bloc.dart';
import 'package:course_travel/features/destination/presentation/widget/circle_loading.dart';
import 'package:course_travel/features/destination/presentation/widget/parallax_vertical_deligate.dart';
import 'package:course_travel/features/destination/presentation/widget/text_failure.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class SearchDestinationPage extends StatefulWidget {
  const SearchDestinationPage({super.key});

  @override
  State<SearchDestinationPage> createState() => _SearchDestinationPageState();
}

class _SearchDestinationPageState extends State<SearchDestinationPage> {
  final searchController = TextEditingController();
  search() {
    if (searchController == '') return;
    context
        .read<SearchDestinationBloc>()
        .add(OnSearchDestination(searchController.text));
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  void initState() {
    context.read<SearchDestinationBloc>().add(OnResetSearchDestination());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: Theme.of(context).primaryColor,
        padding: EdgeInsets.only(top: 60, bottom: 80),
        child: buildSearch(),
      ),
      bottomSheet: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        child: Container(
          color: Colors.white,
          height: MediaQuery.sizeOf(context).height - 140,
          child: BlocBuilder<SearchDestinationBloc, SearchDestinationState>(
            builder: (context, state) {
              if (state is SearchDestinationLoading) return CircleLoading();
              if (state is SearchDestinationFailure)
                return TextFailure(message: state.message);
              if (state is SearchDestinationLoaded) {
                List<DestinationEntity> list = state.data;
                return ListView.builder(
                  itemCount: list.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    DestinationEntity destination = list[index];
                    return Container(
                      margin: EdgeInsets.only(
                          bottom: index == list.length - 1 ? 0 : 20),
                      child: itemSearch(destination),
                    );
                  },
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

  Widget itemSearch(DestinationEntity destination) {
    final imageKey = GlobalKey();
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, AppRoute.detailDestination,
          arguments: destination),
      child: AspectRatio(
        aspectRatio: 2,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Builder(builder: (context) {
              return Flow(
                delegate: ParallaxVerticalDelegate(
                    scrollable: Scrollable.of(context),
                    listItemContext: context,
                    backgroundImageKey: imageKey),
                children: [
                  ExtendedImage.network(
                    URLs.image(destination.cover),
                    key: imageKey,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    handleLoadingProgress: true,
                    loadStateChanged: (state) {
                      if (state.extendedImageLoadState == LoadState.failed) {
                        return Material(
                          borderRadius: BorderRadius.circular(28),
                          color: Colors.grey[300],
                          child: const Icon(
                            Icons.broken_image,
                            color: Colors.black,
                          ),
                        );
                      }
                      if (state.extendedImageLoadState == LoadState.loading) {
                        return Material(
                          borderRadius: BorderRadius.circular(28),
                          color: Colors.grey[300],
                          child: const CircleLoading(),
                        );
                      }
                      return null;
                    },
                  ),
                ],
              );
            }),
            Align(
              alignment: Alignment.bottomCenter,
              child: AspectRatio(
                aspectRatio: 4,
                child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.black87, Colors.transparent],
                            begin: AlignmentDirectional.bottomCenter,
                            end: AlignmentDirectional.center)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              destination.name,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            Text(
                              destination.location,
                              style: TextStyle(
                                  color: Colors.white54, fontSize: 12),
                            )
                          ],
                        )),
                        RatingBarIndicator(
                          rating: destination.rate,
                          unratedColor: Colors.grey,
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemSize: 15,
                        ),
                      ],
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildSearch() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey[300]!,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        children: [
          IconButton.filledTonal(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                size: 24,
              )),
          const SizedBox(
            width: 10,
          ),
          Expanded(
              child: TextField(
            controller: searchController,
            cursorColor: Colors.white,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
            decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                hintText: 'Search destination here...',
                hintStyle:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
                contentPadding: EdgeInsets.all(0)),
          )),
          const SizedBox(
            width: 10,
          ),
          IconButton.filledTonal(
              onPressed: () => search(),
              icon: const Icon(
                Icons.search_rounded,
                size: 24,
              )),
        ],
      ),
    );
  }
}

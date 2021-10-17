import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:movich/widgets/carousel_list.dart';
import 'package:movich/utilities/constants.dart';
import 'package:animate_do/animate_do.dart';

class HomeScreen extends StatelessWidget {
  static const String id = 'HomeScreen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Hello Amir!',
                          style: TextStyle(
                            fontSize: 30,
                            letterSpacing: 1.1,
                            fontFamily: 'Oxygen',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'See, Whats Next',
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Oxygen',
                            fontWeight: FontWeight.w400,
                            color: Colors.lightBlue,
                          ),
                        )
                      ],
                    ),
                    const CircleAvatar(
                      radius: 25.0,
                      backgroundImage: AssetImage('images/face2.webp'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                FadeInDown(
                  child: createCarouselList(
                    'Trending Movie',
                    MediaType.movie,
                    MediaListType.trending,
                  ),
                ),
                FadeInRight(
                  child: createCarouselList(
                    'Trending Tv',
                    MediaType.tv,
                    MediaListType.trending,
                  ),
                ),
                // TODO: Add slide here
                FadeInUp(
                  child: createCarouselList(
                    'Top Rated Movie',
                    MediaType.movie,
                    MediaListType.top_rated,
                  ),
                ),
                FadeInLeft(
                  child: createCarouselList(
                    'Top Rated TV',
                    MediaType.tv,
                    MediaListType.top_rated,
                  ),
                ),
              ],
            ),
          ),
        ),
        // bottomNavigationBar: const NavigationBar(),
        // extendBody: true,
      ),
    );
  }

  Column createCarouselList(
      String title, MediaType mediaType, MediaListType mediaListType) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _carouselListTitle(title),
        CarouselList(
          mediaType: mediaType,
          mediaListType: mediaListType,
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Row _carouselListTitle(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontFamily: 'Oxygen',
            fontWeight: FontWeight.w800,
          ),
        ),
        const Text(
          'see all',
          style: TextStyle(
            fontSize: 14,
            decoration: TextDecoration.underline,
            color: Colors.lightBlue,
          ),
        ),
      ],
    );
  }
}

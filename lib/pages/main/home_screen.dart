import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movich/service/cloud/database_service.dart';
import 'package:movich/widgets/lists/horizontal_list.dart';
import 'package:movich/helpers/constants.dart';
import 'package:animate_do/animate_do.dart';
import 'package:movich/model/user/user_data.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'HomeScreen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late final User loggedInUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: StreamBuilder<Object>(
            stream: DatabaseService(uid: loggedInUser.uid).userData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                UserData userData = snapshot.data! as UserData;
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: getCurrentUser,
                                child: Text(
                                  'Hello ${userData.username}!',
                                  style: const TextStyle(
                                    fontSize: 30,
                                    letterSpacing: 1.1,
                                    fontFamily: 'Oxygen',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
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
                );
              } else {
                return const Center(
                  child: SpinKitChasingDots(
                    color: Colors.white,
                    size: 50.0,
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Column createCarouselList(
      String title, MediaType mediaType, MediaListType mediaListType) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
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
        ),
        HorizontalList(
          mediaType: mediaType,
          mediaListType: mediaListType,
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

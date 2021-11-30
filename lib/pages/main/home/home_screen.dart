import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    Size size = MediaQuery.of(context).size;
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
                              Text(
                                'Hello ${userData.username}!',
                                style: const TextStyle(
                                  fontSize: 30,
                                  letterSpacing: 1.1,
                                  fontFamily: 'Oxygen',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: size.height * 0.01),
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
                          CircleAvatar(
                            radius: size.width * 0.07,
                            backgroundImage:
                                const AssetImage('assets/images/face2.webp'),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.05),
                      FadeInDown(
                        child: createCarouselList(
                          'Trending Movie',
                          MediaType.movie,
                          MediaListType.trending,
                        ),
                      ),
                      SizedBox(height: size.height * 0.03),
                      FadeInRight(
                        child: createCarouselList(
                          'Trending Tv',
                          MediaType.tv,
                          MediaListType.trending,
                        ),
                      ),
                      SizedBox(height: size.height * 0.03),
                      FadeInUp(
                        child: createCarouselList(
                          'Top Rated Movie',
                          MediaType.movie,
                          MediaListType.top_rated,
                        ),
                      ),
                      SizedBox(height: size.height * 0.03),
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
                  child: kloadingSpinKit,
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
          ],
        ),
        HorizontalList(
          mediaType: mediaType,
          mediaListType: mediaListType,
        ),
      ],
    );
  }
}

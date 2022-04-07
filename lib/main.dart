import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'My portfolio',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double offset = 0;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final nameStyle = Theme.of(context).textTheme.headline2;
    final descriptionStyle = Theme.of(context).textTheme.headline4;
    return Material(
      child: NotificationListener<ScrollNotification>(
        // When user scrolls, this will trigger onNotification.
        // updateOffsetAccordingToScroll updates the offset
        onNotification: updateOffsetAccordingToScroll,
        // ScrollConfiguration sets the scroll glow behaviour
        child: ScrollConfiguration(
          behavior: NoScrollGlow(),
          child: Stack(
            children: <Widget>[
              Positioned(
                // The hero image will be pushed up once user scrolls up
                // That is why it is multiplied negatively.
                top: -.25 * offset,
                child: FadeInImage.memoryNetwork(
                  // From the transparent_image package
                  placeholder: kTransparentImage,
                  image: kHeroImage,
                  height: height,
                  width: width,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Positioned(
                top: -.25 * offset,
                child: SizedBox(
                  height: height,
                  width: width,
                  child: Align(
                      alignment: const Alignment(0, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Hoang Minh Tam',
                            style: nameStyle!.copyWith(
                              backgroundColor: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'minhtamhoang207@gmail.com',
                            style: descriptionStyle!.copyWith(
                              backgroundColor: Colors.white,
                            ),
                          ),
                        ],
                      )),
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: height),
                    Container(
                      height: height,
                      width: width,
                      color: Colors.blueAccent,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// Returns true to cancel the notification bubbling.
  bool updateOffsetAccordingToScroll(ScrollNotification scrollNotification) {
    setState(() => offset = scrollNotification.metrics.pixels);
    return true;
  }
}

class NoScrollGlow extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context,
      Widget child,
      AxisDirection axisDirection,
      ) {
    return child;
  }
}

const kHeroImage =
    'https://media-cdn.tripadvisor.com/media/photo-s/15/a4/9b/77/legacy-hotel-at-img-academy.jpg';
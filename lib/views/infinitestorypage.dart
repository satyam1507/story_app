import 'package:flutter/material.dart';
import 'package:story_app/models/dataModel.dart';
import 'package:story/story_page_view/story_page_view.dart';
import 'package:share_plus/share_plus.dart';
import 'package:story_app/views/webviewpage.dart';

class StoryPage extends StatefulWidget {
  StoryPage({Key? key, required this.data}) : super(key: key);

  ProductList data;
  @override
  _StoryPageState createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  late ValueNotifier<IndicatorAnimationCommand> indicatorAnimationController;

  @override
  void initState() {
    super.initState();
    indicatorAnimationController = ValueNotifier<IndicatorAnimationCommand>(
        IndicatorAnimationCommand.resume);
  }

  @override
  void dispose() {
    indicatorAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoryPageView(
        indicatorPadding: const EdgeInsets.only(top: 50),
        itemBuilder: (context, pageIndex, storyIndex) {
          final user = widget.data.products[pageIndex];
          final story = widget.data.products[pageIndex].images[storyIndex];

          return Stack(
            children: [
              Positioned.fill(
                child: Container(color: Colors.black),
              ),
              Positioned.fill(
                left: 8,
                right: 8,
                top: MediaQuery.of(context).padding.top + 50,
                bottom: MediaQuery.of(context).padding.bottom + 50,
                child: Image.network(
                  story,
                  fit: BoxFit.contain,
                  loadingBuilder: (context, child, loadingProgress) {
                    indicatorAnimationController.value =
                        IndicatorAnimationCommand.pause;
                    if (loadingProgress == null) {
                      indicatorAnimationController.value =
                          IndicatorAnimationCommand.resume;
                      return child;
                    }

                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 60, left: 8),
                child: Row(
                  children: [
                    Container(
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(user.thumbnail),
                          fit: BoxFit.cover,
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      user.title,
                      style: const TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        gestureItemBuilder: (context, pageIndex, storyIndex) {
          return Stack(children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      color: Colors.white,
                      icon: indicatorAnimationController.value ==
                              IndicatorAnimationCommand.pause
                          ? const Icon(Icons.play_arrow)
                          : const Icon(Icons.pause),
                      onPressed: () async {
                        if (indicatorAnimationController.value ==
                            IndicatorAnimationCommand.pause) {
                          indicatorAnimationController.value =
                              IndicatorAnimationCommand.resume;
                        } else if (indicatorAnimationController.value ==
                            IndicatorAnimationCommand.resume) {
                          indicatorAnimationController.value =
                              IndicatorAnimationCommand.pause;
                        }
                      },
                    ),
                    IconButton(
                      onPressed: () {
                        indicatorAnimationController.value =
                            IndicatorAnimationCommand.pause;
                        Share.share(
                            'Check out this awesome product ${widget.data.products[pageIndex].title} ${widget.data.products[pageIndex].images[storyIndex]}');
                        indicatorAnimationController.value =
                            IndicatorAnimationCommand.resume;
                      },
                      icon: const Icon(Icons.share),
                      color: Colors.white,
                    ),
                    IconButton(
                      padding: EdgeInsets.zero,
                      color: Colors.white,
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    onPressed: () {
                      indicatorAnimationController.value =
                          IndicatorAnimationCommand.pause;
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => WebViewPage()),
                      );
                      indicatorAnimationController.value =
                          IndicatorAnimationCommand.resume;
                    },
                    child: const Text(
                      'read more',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ]);
        },
        indicatorAnimationController: indicatorAnimationController,
        initialStoryIndex: (pageIndex) {
          return 0;
        },
        pageLength: widget.data.products.length,
        storyLength: (int pageIndex) {
          return widget.data.products[pageIndex].images.length;
        },
        onPageLimitReached: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

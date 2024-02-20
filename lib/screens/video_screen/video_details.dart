import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:video_player_app/utils/text_styles.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoDetailsScreen extends StatefulWidget {


  const VideoDetailsScreen({super.key});

  @override
  State<VideoDetailsScreen> createState() => _VideoDetailsScreenState();
}

class _VideoDetailsScreenState extends State<VideoDetailsScreen> {
  bool isPressed = false;
  late YoutubePlayerController _youtubePlayerController;
  List<String> videoIds = [];

  @override
  void initState() {
    super.initState();
    videoIds = getVideosForCategory;
    _youtubePlayerController = YoutubePlayerController(
      initialVideoId: videoIds.first,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _youtubePlayerController.dispose();
    super.dispose();
  }

  List<String> getVideosForCategory = [
    'GAWHzGNcTEw',
    'YPY7J-flzE8',
    '_Tk9_kPpO1U'
  ];

  List<String> videoDetails = [
    'https://img.youtube.com/vi/GAWHzGNcTEw/maxresdefault.jpg',
    'https://img.youtube.com/vi/YPY7J-flzE8/maxresdefault.jpg',

    'https://img.youtube.com/vi/_Tk9_kPpO1U/maxresdefault.jpg'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Contents'),
        ),
        body: Column(
          children: [
            isPressed == true
                ? Container(
                    padding: const EdgeInsets.all(8),
                    child: YoutubePlayer(
                      controller: _youtubePlayerController,
                      showVideoProgressIndicator: true,
                      progressIndicatorColor: Colors.amber,
                    ),
                  )
                : Container(),
            Expanded(
              child: ListView.builder(
                itemCount: videoIds.length,
                itemBuilder: (context, index) {
                  final videoId = videoIds[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isPressed == false) {
                          isPressed = true;
                        }
                        _youtubePlayerController.load(videoId);
                      });
                    },
                    child: Card(
                      elevation: 5,
                      shape: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(10)),

                      child: ListTile(
                        contentPadding: const EdgeInsets.only(
                            top: 20, left: 10, right: 10, bottom: 15),
                        leading: CachedNetworkImage(
                          imageUrl: videoDetails[index],
                          progressIndicatorBuilder: (context, url, downloadProgress) =>
                              CircularProgressIndicator(value: downloadProgress.progress),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                        title: Text(
                          'Testing',
                          style: TextStyles.smallTextStyle
                              .copyWith(color: Colors.black),
                        ),
                        trailing: const Text('9:00 min'),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ));
  }
}

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioFile extends StatefulWidget {
  final AudioPlayer? advancePlayer;
  //final String? audioPath;

  const AudioFile({super.key, this.advancePlayer});

  @override
  State<AudioFile> createState() => _AudioFileState();
}

class _AudioFileState extends State<AudioFile> {
  Duration _duration = Duration();
  Duration _position = Duration();
  final String path = "assets/audio/moneda.mp3";
  late final Source source =
      UrlSource("https://www.youtube.com/watch?v=m7Bc3pLyij0");
  bool isPlaying = false;
  bool isPaused = false;
  bool isRepeat = false;
  Color color = Colors.black;
  final List<IconData> _icons = [
    Icons.play_circle_fill,
    Icons.play_circle_filled,
  ];

  AudioPlayer player = AudioPlayer();

  @override
  void initState() {
    this.widget.advancePlayer?.onDurationChanged.listen((d) {
      setState(() {
        _duration = d;
      });
    });

    this.widget.advancePlayer?.onPositionChanged.listen((p) {
      setState(() {
        _position = p;
      });
    });
    //this.widget.advancePlayer!.setSourceUrl(path);

    this.widget.advancePlayer?.onPlayerComplete.listen((event) {
      setState(() {
        _position = Duration(seconds: 0);
        if (isRepeat == true) {
          isPlaying = true;
        } else {
          isPlaying = false;
          isRepeat = false;
        }
      });
    });

    super.initState();
  }

  Widget btnStart() {
    return IconButton(
      padding: const EdgeInsets.only(bottom: 10),
      icon: isPlaying == false
          ? Icon(
              _icons[0],
              size: 50,
              color: Colors.blue,
            )
          : Icon(_icons[1], size: 50, color: Colors.blue),
      onPressed: () {
        if (isPlaying == false) {
          widget.advancePlayer!
              .play(UrlSource(path), mode: PlayerMode.lowLatency);

          setState(() {
            isPlaying = true;
          });
        } else if (isPlaying == true) {
          widget.advancePlayer!.pause();
          setState(() {
            isPlaying = false;
          });
        }
      },
    );
  }

  Widget slider() {
    return Slider(
        activeColor: Colors.red,
        inactiveColor: Colors.grey,
        value: _position.inSeconds.toDouble(),
        min: 0.0,
        max: _duration.inSeconds.toDouble(),
        onChanged: (double value) {
          setState(() {
            changeToSecond(value.toInt());
            value = value;
          });
        });
  }

  void changeToSecond(int second) {
    Duration newDuration = Duration(seconds: second);
    this.widget.advancePlayer?.seek(newDuration);
  }

  Widget btnFast() {
    return IconButton(
      icon: ImageIcon(
        AssetImage("assets/images/forward.png"),
        size: 20,
        color: Colors.black,
      ),
      onPressed: () {
        this.widget.advancePlayer?.play(source);
      },
    );
  }

  Widget btnSlow() {
    return IconButton(
      icon: ImageIcon(
        AssetImage("assets/images/bakcword.png"),
        size: 20,
        color: Colors.black,
      ),
      onPressed: () {
        this.widget.advancePlayer?.setPlaybackRate(0.5);
      },
    );
  }

  Widget btnLoop() {
    return IconButton(
      icon: ImageIcon(
        AssetImage("assets/images/loop.png"),
        size: 20,
        color: color,
      ),
      onPressed: () {},
    );
  }

  Widget btnRepeat() {
    return IconButton(
      icon: ImageIcon(
        AssetImage("assets/images/repeat.png"),
        size: 20,
        color: color,
      ),
      onPressed: () {
        if (isRepeat == false) {
          this.widget.advancePlayer?.setReleaseMode(ReleaseMode.loop);
          setState(() {
            isRepeat = true;
            color = Colors.blue;
          });
        } else if (isRepeat == true) {
          this.widget.advancePlayer?.setReleaseMode(ReleaseMode.release);
          color = Colors.black;
          isRepeat = false;
        }
      },
    );
  }

  Widget loadAsset() {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          btnRepeat(),
          btnSlow(),
          btnStart(),
          btnFast(),
          btnLoop(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _position.toString().split(".")[0],
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  _duration.toString().split(".")[0],
                  style: TextStyle(fontSize: 16),
                )
              ],
            ),
          ),
          slider(),
          loadAsset(),
        ],
      ),
    );
  }
}

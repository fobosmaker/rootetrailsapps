import 'dart:async';

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
class AudioPlayerWidget extends StatefulWidget {
  @override
  _AudioPlayerWidgetState createState() => _AudioPlayerWidgetState();
}


enum PlayerState { stopped, playing, paused }

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {

  Duration duration;
  Duration position;

  PlayerState playerState = PlayerState.stopped;

  get isPlaying => playerState == PlayerState.playing;
  get isPaused => playerState == PlayerState.paused;
  get durationText =>
      duration != null ? duration.toString().split('.').first : '0:00:00';

  get positionText =>
      position != null ? position.toString().split('.').first : '0:00:00';

  bool isMuted = false;



  StreamSubscription _positionSubscription;
  StreamSubscription _audioPlayerStateSubscription;

  AudioPlayer audioPlayer;
  var kUrl1 = 'https://luan.xyz/files/audio/ambient_c_motion.mp3';
  var kUrl2 = 'https://luan.xyz/files/audio/nasa_on_a_mission.mp3';
  var kUrl3 = 'http://bbcmedia.ic.llnwd.net/stream/bbcmedia_radio1xtra_mf_p';
  var kUrl4 = 'https://anchor.fm/s/1c992160/podcast/play/16135671/https%3A%2F%2Fd3ctxlq1ktw2nl.cloudfront.net%2Fstaging%2F2020-6-5%2F87709948-44100-2-2f40088ccc61e.m4a';



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    audioPlayer = AudioPlayer();
    AudioPlayer.logEnabled = true;
    //initAudioPlayer();
    audioPlayer.onDurationChanged.listen((event) {
      print('max duration : $event');
      duration = event;
    });
  }

  @override
  Widget build(BuildContext context) {
    audioPlayer.onAudioPositionChanged.listen((event) {
      setState(() {
        position = event;
        print('current position : $position');
      });
    });

    audioPlayer.onPlayerCompletion.listen((event) {
      onComplete();
    });

    return /*_buildPlayer(widget.url);*/
      Scaffold(
          appBar: AppBar(
            title: Text('Streaming Audio'),
          ),
          body: Container(
              child: _buildPlayer(kUrl4)
          )
      );
  }

  Future play(String url) async {
    await audioPlayer.play(url);
    setState(() {
      playerState = PlayerState.playing;
    });
  }

  Future pause() async {
    await audioPlayer.pause();
    setState(() => playerState = PlayerState.paused);
  }

  Future stop() async {
    await audioPlayer.stop();
    setState(() {
      playerState = PlayerState.stopped;
      position = Duration();
    });
  }

  /*Future mute(bool muted) async {
    await audioPlayer.mute(muted);
    setState(() {
      isMuted = muted;
    });
  }*/

  void onComplete() {
    print('audio done');
    stop();
  }

  Widget _buildPlayer(String url) => Container(
    padding: EdgeInsets.all(16.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(mainAxisSize: MainAxisSize.min, children: [
          IconButton(
            onPressed: isPlaying ? null : () => play(url),
            iconSize: 64.0,
            icon: Icon(Icons.play_arrow),
            color: Colors.cyan,
          ),
          IconButton(
            onPressed: isPlaying ? () => pause() : null,
            iconSize: 64.0,
            icon: Icon(Icons.pause),
            color: Colors.cyan,
          ),
          IconButton(
            onPressed: isPlaying || isPaused ? () => stop() : null,
            iconSize: 64.0,
            icon: Icon(Icons.stop),
            color: Colors.cyan,
          ),
        ]),
        Text(positionText),
        Text(durationText),
        duration != null && position != null ? LinearProgressIndicator(
          value: position.inSeconds/duration.inSeconds,
        ) : SizedBox(height: 0, width: 0,)
        /*if (duration != null)
          Slider(
              value: position?.inMilliseconds?.toDouble() ?? 0.0,
              onChanged: (double value) {
                //print('current val: $value');
                return audioPlayer.seek(position);
              },
              min: 0.0,
              max: duration.inMilliseconds.toDouble()),
        if (position != null) _buildMuteButtons(),
        if (position != null) _buildProgressView()*/
      ],
    ),
  );

  Row _buildProgressView() => Row(mainAxisSize: MainAxisSize.min, children: [
    Padding(
      padding: EdgeInsets.all(12.0),
      child: CircularProgressIndicator(
        value: position != null && position.inMilliseconds > 0
            ? (position?.inMilliseconds?.toDouble() ?? 0.0) /
            (duration?.inMilliseconds?.toDouble() ?? 0.0)
            : 0.0,
        valueColor: AlwaysStoppedAnimation(Colors.cyan),
        backgroundColor: Colors.grey.shade400,
      ),
    ),
    Text(
      position != null
          ? "${positionText ?? ''} / ${durationText ?? ''}"
          : duration != null ? durationText : '',
      style: TextStyle(fontSize: 24.0),
    ),

  ]);

/*Row _buildMuteButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        if (!isMuted)
          FlatButton.icon(
            onPressed: () => mute(true),
            icon: Icon(
              Icons.headset_off,
              color: Colors.cyan,
            ),
            label: Text('Mute', style: TextStyle(color: Colors.cyan)),
          ),
        if (isMuted)
          FlatButton.icon(
            onPressed: () => mute(false),
            icon: Icon(Icons.headset, color: Colors.cyan),
            label: Text('Unmute', style: TextStyle(color: Colors.cyan)),
          ),
      ],
    );
  }*/
}

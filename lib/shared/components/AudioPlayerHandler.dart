import 'package:just_audio/just_audio.dart';
import 'package:audio_service/audio_service.dart';
import 'constants.dart';

MediaItem _item = MediaItem(
  id: 'ehyaman',
  title: Constants.currentAudioMetadata != null
      ? Constants.currentAudioMetadata.info.title
      : 'Lo-Fi Radio 24/7',
  artist: Constants.currentAudioMetadata != null
      ? Constants.currentAudioMetadata.headers.name
      : 'Only Lo-Fi',
  artUri: Uri.parse(
      'https://i.pinimg.com/236x/3d/01/f0/3d01f0a3f32778f6510f1bf59efc065f.jpg'),
);

class AudioPlayerHandler extends BaseAudioHandler {
  AudioPlayerHandler() {
    Constants.mainAudioPlayer.playbackEventStream
        .map(_transformEvent)
        .pipe(playbackState);
    mediaItem.add(_item);
  }

  @override
  Future<void> play() async {
    await Constants.mainAudioPlayer.seek(Duration(days: 30));
    Constants.mainAudioPlayer.play();
    Constants.animationController.forward();
  }

  @override
  Future<void> pause() async {
    Constants.mainAudioPlayer.pause();
    Constants.animationController.reverse();
  }

  PlaybackState _transformEvent(PlaybackEvent event) {
    return PlaybackState(
      androidCompactActionIndices: [0],
      controls: [
        Constants.mainAudioPlayer.playing
            ? MediaControl.pause
            : MediaControl.play,
      ],
      errorMessage: 'Something Wrong has Happened',
      processingState: const {
        ProcessingState.idle: AudioProcessingState.idle,
        ProcessingState.loading: AudioProcessingState.loading,
        ProcessingState.buffering: AudioProcessingState.buffering,
        ProcessingState.ready: AudioProcessingState.ready,
        ProcessingState.completed: AudioProcessingState.completed,
      }[Constants.mainAudioPlayer.processingState],
      playing: Constants.mainAudioPlayer.playing,
    );
  }
}

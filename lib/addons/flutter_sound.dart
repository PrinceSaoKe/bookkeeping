import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class AppSoundRecorder {
  final Codec _codec = Codec.pcm16WAV;
  late final String audioPath;
  final FlutterSoundRecorder _soundRecorder = FlutterSoundRecorder();

  Future<void> openSoundRecorder() async {
    var status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      // throw RecordingPermissionException('麦克风未授权！');
      print('麦克风未授权！');
    }

    audioPath = '${(await getTemporaryDirectory()).path}/audio.wav';

    // if (!await _mRecorder!.isEncoderSupported(_codec) && kIsWeb) {
    //   _codec = Codec.opusWebM;
    //   _mPath = 'tau_file.webm';
    //   if (!await _mRecorder!.isEncoderSupported(_codec) && kIsWeb) {
    //     _mRecorderIsInited = true;
    //     return;
    //   }
    // }
    await _soundRecorder.openRecorder();
    // final session = await AudioSession.instance;
    // await session.configure(
    //   AudioSessionConfiguration(
    //     avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
    //     avAudioSessionCategoryOptions:
    //         AVAudioSessionCategoryOptions.allowBluetooth |
    //             AVAudioSessionCategoryOptions.defaultToSpeaker,
    //     avAudioSessionMode: AVAudioSessionMode.spokenAudio,
    //     avAudioSessionRouteSharingPolicy:
    //         AVAudioSessionRouteSharingPolicy.defaultPolicy,
    //     avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
    //     androidAudioAttributes: const AndroidAudioAttributes(
    //       contentType: AndroidAudioContentType.speech,
    //       flags: AndroidAudioFlags.none,
    //       usage: AndroidAudioUsage.voiceCommunication,
    //     ),
    //     androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
    //     androidWillPauseWhenDucked: true,
    //   ),
    // );
  }

  void record() async {
    print('------------------------开始录音，路径：' + audioPath);
    _soundRecorder.startRecorder(
      toFile: audioPath,
      codec: _codec,
      // audioSource: theSource,
      // audioSource: AudioSource.microphone,
    );
  }

  void stopRecorder() async {
    await _soundRecorder.stopRecorder().then((value) {
      print('------------------------录音结束' + audioPath);
    });
  }
}

class AppSoundPlayer {
  final Codec _codec = Codec.pcm16WAV;
  final String _audioPath = 'audio.wav';
  FlutterSoundPlayer soundPlayer = FlutterSoundPlayer();

  openSoundPlayer() async {
    soundPlayer.openPlayer();
  }

  play() {
    soundPlayer.startPlayer(fromURI: _audioPath);
  }
}

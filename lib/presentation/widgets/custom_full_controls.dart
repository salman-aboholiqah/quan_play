import 'dart:async';

import 'package:awesome_video_player/awesome_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:url_player/core/utils/player_utils.dart';
import 'package:url_player/data/models/stream_model.dart';

class CustomFullControls extends StatefulWidget {
  final BetterPlayerController controller;
  final Function(bool visbility)? onControlsVisibilityChanged;
  final List<StreamQuality> qualities;

  const CustomFullControls({
    super.key,
    required this.controller,
    required this.qualities,
    this.onControlsVisibilityChanged,
  });

  @override
  State<CustomFullControls> createState() => _CustomFullControlsState();
}

class _CustomFullControlsState extends State<CustomFullControls>
    with SingleTickerProviderStateMixin {
  bool _visible = true;
  bool _loading = false;
  Timer? _hideTimer;
  late final Ticker _ticker;

  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;

  String _currentQuality = "";
  int exceptionCount = 0;
  @override
  void initState() {
    super.initState();

    widget.controller.addEventsListener((event) {
      if (event.betterPlayerEventType == BetterPlayerEventType.exception) {
        exceptionCount++;
        if (exceptionCount == 1) {
          _handleStreamException();
        }
      }
      if (event.betterPlayerEventType == BetterPlayerEventType.bufferingStart) {
        setState(() => _loading = true);
      } else if (event.betterPlayerEventType ==
          BetterPlayerEventType.bufferingEnd) {
        setState(() => _loading = false);
      }
    });

    _ticker = createTicker((_) => _updateVideoState())..start();
    _startHideTimer();

    if (widget.qualities.isNotEmpty) {
      _currentQuality = widget.qualities.first.name;
    }
  }

  bool _isMuted = false;

  void _toggleMute() {
    _isMuted = !_isMuted;
    widget.controller.setVolume(_isMuted ? 0 : 1);
    setState(() {});
  }

  void _toggleLock() {
    setState(() {
      isLocked = !isLocked;
    });
  }

  double _playbackSpeed = 1.0;
  void _changePlaybackSpeed(double speed) {
    setState(() {
      _playbackSpeed = speed;
    });
    widget.controller.setSpeed(speed);
    _startHideTimer();
  }

  final List<double> _playbackSpeedOptions = [0.5, 0.75, 1.0, 1.25, 1.5, 2.0];

  void _updateVideoState() {
    final controller = widget.controller.videoPlayerController;
    if (controller == null || !controller.value.initialized) return;

    final pos = controller.value.position;
    final dur = controller.value.duration ?? Duration.zero;

    if (mounted) {
      setState(() {
        _currentPosition = pos;
        _totalDuration = dur;
      });
    }
  }

  void _toggleVisibility() {
    setState(() => _visible = !_visible);
    widget.onControlsVisibilityChanged?.call(_visible);
    if (_visible) _startHideTimer();
  }

  void _startHideTimer() {
    _hideTimer?.cancel();
    _hideTimer = Timer(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() => _visible = false);
        widget.onControlsVisibilityChanged?.call(false);
      }
    });
  }

  void _handleStreamException() async {
    if (widget.qualities.length <= 1) return;
    var currentQualityModel = widget.qualities.firstWhere(
      (element) => element.name == _currentQuality,
      orElse: () => widget.qualities.first,
    );
    int currentIndex = widget.qualities.indexOf(currentQualityModel);
    int nextIndex = (currentIndex + 1) % widget.qualities.length;
    var current = widget.qualities[nextIndex];

    _switchQuality(current);
  }

  void _switchQuality(StreamQuality quality) async {
    setState(() {
      _loading = true;
      _currentQuality = quality.name;
      exceptionCount = 0;
    });
    final newSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      quality.url,
      headers: quality.headers,
      videoFormat: detectVideoFormat(quality.url),
      drmConfiguration:
          quality.drm?.license != null
              ? BetterPlayerDrmConfiguration(
                drmType: getDrmType(quality.drm?.type ?? 'clearkey'),
                clearKey: quality.drm?.license,
              )
              : null,
      useAsmsSubtitles: false,
      useAsmsTracks: false,
    );
    bool isPlaying = widget.controller.isPlaying() ?? false;
    if (isPlaying) {
      await widget.controller.pause();
    }

    await widget.controller.clearCache();
    await widget.controller.setupDataSource(newSource);
    await widget.controller.play();

    setState(() {
      _loading = false;
    });
  }

  @override
  void dispose() {
    _ticker.dispose();
    _hideTimer?.cancel();
    super.dispose();
  }

  void _seekForward() {
    final newPosition = _currentPosition + Duration(seconds: 10);
    widget.controller.seekTo(newPosition);
    _startHideTimer();
  }

  void _seekBackward() {
    final newPosition = _currentPosition - Duration(seconds: 10);
    widget.controller.seekTo(
      newPosition < Duration.zero ? Duration.zero : newPosition,
    );
    _startHideTimer();
  }

  bool isLocked = false;
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !isLocked,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop && isLocked) {
          _toggleVisibility();
        }
      },
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _toggleVisibility,
        child: Stack(
          children: [
            if (_loading)
              const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),

            if (_visible) _buildTopBar(),
            if (_visible && !isLocked) _buildBottomBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          // ignore: deprecated_member_use
          colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child:
                !isLocked
                    ? Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      child:
                          widget.qualities.length <= 1
                              ? Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              )
                              : Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                    ),
                                  ),
                                  ...widget.qualities.map(
                                    (q) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 4,
                                      ),
                                      child: _buildQualityButton(q),
                                    ),
                                  ),
                                ],
                              ),
                    )
                    : SizedBox(),
          ),
          !isLocked
              ? IconButton(
                icon: Icon(
                  _isMuted ? Icons.volume_off : Icons.volume_up,
                  color: Colors.white,
                ),
                onPressed: _toggleMute,
              )
              : SizedBox(),

          !isLocked
              ? PopupMenuButton<double>(
                icon: Icon(Icons.speed, color: Colors.white),
                itemBuilder:
                    (context) =>
                        _playbackSpeedOptions
                            .map(
                              (speed) => PopupMenuItem<double>(
                                value: speed,
                                child: Text(
                                  '${speed}x',
                                  style: TextStyle(
                                    fontWeight:
                                        _playbackSpeed == speed
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                onSelected: _changePlaybackSpeed,
              )
              : SizedBox(),
          IconButton(
            icon: Icon(
              isLocked ? Icons.lock_outline : Icons.lock_open_outlined,
              color: Colors.white,
            ),
            onPressed: _toggleLock,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    final controller = widget.controller;

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            // ignore: deprecated_member_use
            colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              child: SizedBox(
                height: 30,
                child: BetterPlayerMaterialVideoProgressBar(
                  controller.videoPlayerController,
                  controller,
                  colors: BetterPlayerProgressColors(
                    playedColor: Color(0xFFFFB533),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _formatDuration(_currentPosition),
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                    fontFeatures: [FontFeature.tabularFigures()],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.replay_10, color: Colors.white),
                  onPressed: _seekBackward,
                ),
                InkWell(
                  onTap: () {
                    if (controller.isPlaying()!) {
                      controller.pause();
                    } else {
                      controller.play();
                    }
                    _startHideTimer();
                  },
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      controller.isPlaying()!
                          ? Icons.pause_rounded
                          : Icons.play_arrow_rounded,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.forward_10, color: Colors.white),
                  onPressed: _seekForward,
                ),
                Text(
                  _formatDuration(_totalDuration),
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                    fontFeatures: [FontFeature.tabularFigures()],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQualityButton(StreamQuality quality) {
    final isSelected = _currentQuality == quality.name;
    return GestureDetector(
      onTap: () => _switchQuality(quality),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          // ignore: deprecated_member_use
          color: isSelected ? Color(0xFFFFB533) : Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.white30),
        ),
        child: Text(
          quality.name,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  String _formatDuration(Duration d) {
    twoDigits(int n) => n.toString().padLeft(2, "0");
    return "${twoDigits(d.inMinutes)}:${twoDigits(d.inSeconds % 60)}";
  }
}

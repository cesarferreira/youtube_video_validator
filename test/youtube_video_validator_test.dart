import 'dart:async';
import 'package:test/test.dart';
import 'package:youtube_video_validator/youtube_video_validator.dart';

void main() {
  final List<String> validYoutubeVideoURLs = [
    'https://www.youtube.com/watch?v=ou6Tt5w9B-Y',
    'www.youtube.com/watch?v=ou6Tt5w9B-Y',
    'youtube.com/watch?v=ou6Tt5w9B-Y',
    'https://youtu.be/ou6Tt5w9B-Y',
    'youtu.be/ou6Tt5w9B-Y',
    'youtu.be/ou6Tt5w9B-Y',
  ];

  final List<String> inValidYoutubeVideoURLs = [
    'https://www.youtube.net/watch?v=ou6Tt5w9B-Y',
    'https://wwwyoutube.com/watch?v=ou6Tt5w9B-Y',
    'https://www.youtube.com/',
    'www.youtu.be/?ou6Tt5w9B-Y',
    'https://youtube/?ou6Tt5w9B-Y',
  ];

  test('Validate throws error on null url', () {
    expect(
      () => YoutubeVideoValidator.validateUrl(null),
      throwsA(const TypeMatcher<ArgumentError>()),
    );
  });

  test('Validate validAddresses are Youtube Video URLs', () {
    for (var actual in validYoutubeVideoURLs) {
      expect(YoutubeVideoValidator.validateUrl(actual), isTrue, reason: 'URL: $actual');
    }
  });

  test('Validate invalidAddresses are invalid emails', () {
    for (var actual in inValidYoutubeVideoURLs) {
      expect(YoutubeVideoValidator.validateUrl(actual), isFalse, reason: 'URL: $actual');
    }
  });

  final List<String> validYoutubeVideoIDs = [
    'rtuywS2fG2Y',
    'dsCpY42V3TE',
    'ou6Tt5w9B-Y',
    'Vxl5jUltHBo',
  ];

  final List<String> inValidYoutubeVideoIDs = [
    'ou6Tt-5w9B',
    'aa-ss-dd-c-v',
    'ou6Tt5w9B--',
    'rtuywS2fG2Z',
  ];

  test('Validate throws error on null videoID', () {
    expect(
      () => YoutubeVideoValidator.validateID(null),
      throwsA(const TypeMatcher<ArgumentError>()),
    );
  });

  test('Validate validYoutubeVideoIDs are Youtube Video IDs', () async {
    await Future.forEach(
      validYoutubeVideoIDs,
      (String actual) async => expectLater(await YoutubeVideoValidator.validateID(actual), isTrue, reason: 'Video ID: $actual'),
    );
  });

  test('Validate inValidYoutubeVideoIDs are Youtube Video IDs', () async {
    await Future.forEach(
      inValidYoutubeVideoIDs,
      (String actual) async => expectLater(await YoutubeVideoValidator.validateID(actual), isFalse, reason: 'Video ID: $actual'),
    );
  });

  test('Validate validYoutubeVideoIDs are Youtube Video IDs (using loadData)', () async {
    final String actual = validYoutubeVideoIDs[0];

    await YoutubeVideoValidator.validateID(actual, loadData: true);

    await expectLater(YoutubeVideoValidator.video.id, equals(actual), reason: 'Video Data: ${YoutubeVideoValidator.video.toString()}');
  });
}

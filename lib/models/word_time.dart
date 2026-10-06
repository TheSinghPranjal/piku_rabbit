/// Word Time. Ten three-letter words, each a full-screen classroom still.
///
/// There is no lesson video: the app speaks the letters, then the word, with
/// on-device text-to-speech. A later pass can drop in Vibes video loops
/// beside these stills without changing the word order.
abstract final class WordTimeLesson {
  static const folder = 'assets/images/word-lesson';

  /// flutter_tts rate, 0.0 (slowest) to 1.0 (fastest).
  /// About 0.5 is a normal pace; 0.4 is a little slower for young children.
  static const speechRate = 0.4;

  /// Quiet gap between one spoken letter and the next.
  static const letterPause = Duration(milliseconds: 400);

  /// Highlight value while the whole word is spoken.
  static const wholeWord = -1;

  static const words = <WordTimeWord>[
    WordTimeWord(word: 'CAT', asset: '$folder/piku-word-cat.jpg'),
    WordTimeWord(word: 'DOG', asset: '$folder/piku-word-dog.jpg'),
    WordTimeWord(word: 'MAT', asset: '$folder/piku-word-mat.jpg'),
    WordTimeWord(word: 'BAT', asset: '$folder/piku-word-bat.jpg'),
    WordTimeWord(word: 'RAT', asset: '$folder/piku-word-rat.jpg'),
    WordTimeWord(word: 'HAT', asset: '$folder/piku-word-hat.jpg'),
    WordTimeWord(word: 'SUN', asset: '$folder/piku-word-sun.jpg'),
    WordTimeWord(word: 'CUP', asset: '$folder/piku-word-cup.jpg'),
    WordTimeWord(word: 'BUS', asset: '$folder/piku-word-bus.jpg'),
    WordTimeWord(word: 'PEN', asset: '$folder/piku-word-pen.jpg'),
  ];

  /// Letters one at a time, then the whole word with a cheerful ending.
  static List<WordNarrationCue> cuesFor(String word) {
    final letters = word.split('');
    return [
      for (var i = 0; i < letters.length; i++)
        WordNarrationCue(spoken: letters[i], highlight: i),
      WordNarrationCue(spoken: '$word!', highlight: wholeWord),
    ];
  }
}

/// One three-letter word and its classroom still.
class WordTimeWord {
  const WordTimeWord({required this.word, required this.asset});

  final String word;
  final String asset;

  List<String> get letters => word.split('');
}

/// One beat of the narration: what is spoken, and which letter lights up.
class WordNarrationCue {
  const WordNarrationCue({required this.spoken, required this.highlight});

  final String spoken;

  /// Letter index, or [WordTimeLesson.wholeWord] for the full word.
  final int highlight;
}

/// Which word is on screen. Independent of speech, so tests can walk it.
class WordTimeProgress {
  const WordTimeProgress({this.index = 0});

  final int index;

  WordTimeWord get word => WordTimeLesson.words[index];

  bool get isLast => index >= WordTimeLesson.words.length - 1;

  /// `1/10` style counter.
  String get label => '${index + 1}/${WordTimeLesson.words.length}';

  WordTimeProgress advance() {
    if (isLast) return this;
    return WordTimeProgress(index: index + 1);
  }
}

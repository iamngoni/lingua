import 'dart:convert';

class Letter {
  final String letter;
  final String image;
  Letter({
    this.letter,
    this.image,
  });

  Letter copyWith({
    String letter,
    String image,
  }) {
    return Letter(
      letter: letter ?? this.letter,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'letter': letter,
      'image': image,
    };
  }

  factory Letter.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Letter(
      letter: map['letter'],
      image: map['image'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Letter.fromJson(String source) => Letter.fromMap(json.decode(source));

  @override
  String toString() => 'Letter(letter: $letter, image: $image)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Letter &&
      o.letter == letter &&
      o.image == image;
  }

  @override
  int get hashCode => letter.hashCode ^ image.hashCode;
}
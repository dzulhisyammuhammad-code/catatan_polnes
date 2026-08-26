class Catatan {
  final String id;
  final String judul;
  final String isi;
  final bool selesai;
  final DateTime dibuatPada;

  const Catatan({
    required this.id,
    required this.judul,
    required this.isi,
    this.selesai = false,
    required this.dibuatPada,
  });

  Catatan copyWith({String? judul, String? isi, bool? selesai}) {
    return Catatan(
      id: id,
      judul: judul ?? this.judul,
      isi: isi ?? this.isi,
      selesai: selesai ?? this.selesai,
      dibuatPada: dibuatPada,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Catatan &&
        other.id == id &&
        other.judul == judul &&
        other.isi == isi &&
        other.selesai == selesai;
  }

  @override
  int get hashCode => Object.hash(id, judul, isi, selesai);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'judul': judul,
      'isi': isi,
      'selesai': selesai,
      'dibuatPada': dibuatPada.toIso8601String(),
    };
  }

  factory Catatan.fromMap(Map<String, dynamic> map) {
    return Catatan(
      id: map['id'] as String,
      judul: map['judul'] as String,
      isi: map['isi'] as String,
      selesai: map['selesai'] as bool,
      dibuatPada: DateTime.parse(map['dibuatPada'] as String),
    );
  }

  String get ringkasan {
    if (isi.length <= 40) return isi;
    return '${isi.substring(0, 40)}...';
  }

  bool get baruSaja {
    return DateTime.now().difference(dibuatPada).inHours < 24;
  }
}

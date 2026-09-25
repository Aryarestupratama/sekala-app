/// Teks TEMPLATE Studi Kasus — hardcode di Flutter (bukan disimpan di DB),
/// nama wabah disisipkan otomatis (progress.md, "Alur 4 layar").
///
/// Yang BUKAN template (diisi admin lewat API): judul kasus, deskripsi,
/// teks tantangan, deskripsi alasan, judul/deskripsi 5 opsi, feedback,
/// dan data badge. Jangan dipindah ke sini.
///
/// `wabah` = `Year.title` dari tahun tempat section studi kasus berada
/// (Schema.md `years.title`, mis. "Wabah Flu Spanyol"), dipakai APA ADANYA
/// — kalau judul year sudah berawalan "Wabah", hasil kalimatnya tetap
/// natural ("...Pengendalian Wabah Flu Spanyol").
class CaseStudyTexts {
  const CaseStudyTexts._();

  // === Layar 1: Opening ===
  static const openingEyebrow = 'SIMULASI PROBLEM-BASED LEARNING';

  static String openingTitle(String wabah) =>
      'Keputusan Strategis Gugus Tugas: Menentukan Prioritas Upaya '
      'Pengendalian ${_name(wabah)}';

  static const playerRoleHeading = 'PERAN PEMAIN';
  static const playerRoleBody =
      'Anda adalah Ahli Kesehatan Masyarakat—epidemiolog dalam Gugus '
      'Tugas—di garda terdepan penanganan ancaman wabah di Indonesia.';

  static const rulesHeading = 'ATURAN MAIN';
  static const rulesBody =
      'Bukan soal tebak benar atau salah. Analisis masalah kritis, '
      'tentukan urutan tiga tindakan, lalu pertanggungjawabkan keputusan '
      'Anda.';

  static const startBriefingCta = 'Mulai briefing kasus';

  // === Layar 2: Briefing Kasus ===
  static const briefingEyebrow = 'BRIEFING KASUS UTAMA';

  /// Lead-in tebal di kotak tantangan. Template — teks setelahnya
  /// (`challenge_text`) diisi admin.
  static const challengeLeadIn = 'Tantangan Anda:';

  static const openMatrixCta = 'Buka matriks prioritas';

  /// Buang awalan "Tantangan Anda:" kalau admin sudah menuliskannya di
  /// dalam `challenge_text`, supaya tidak tampil dobel dengan
  /// [challengeLeadIn].
  static String challengeBody(String raw) {
    return raw
        .trim()
        .replaceFirst(RegExp(r'^tantangan anda\s*:\s*', caseSensitive: false), '');
  }

  // === Layar 3: Ruang Keputusan ===
  static const decisionEyebrow = 'RUANG KEPUTUSAN';
  static String stepLabel(int step) => 'Langkah $step dari 2';

  // Langkah 1 — susun prioritas
  static const rankTitle = 'Susun skala prioritas upaya pengendalian';

  /// Teks resmi sesuai progress.md ("Alur 4 layar") — JANGAN dipersingkat.
  /// Versi ringkas sempat dipakai sementara saat diskusi relayout, tapi
  /// itu menyimpang dari dokumen yang sudah disepakati; dikembalikan ke
  /// teks penuh di sini.
  static String rankInstruction(String wabah) =>
      'Berdasarkan analisis situasi krisis ${_name(wabah)}, tentukan dan '
      'urutkan tiga langkah pengendalian utama yang paling mendesak '
      'dilakukan pertama kali oleh instansi kesehatan masyarakat. Klik '
      'kartu sesuai urutan prioritas Anda.';
  static const priorityHeading = 'Urutan prioritas';
  static const resetCta = 'Susun ulang';
  static const slotEmpty = 'Belum dipilih';
  static String pickHeading(int count) => 'Pilih dari $count opsi';
  static const continueCta = 'Lanjut';

  // Langkah 2 — alasan
  static const reasonStepTitle = 'Pertanggungjawabkan keputusan Anda';
  static const summaryHeading = 'Urutan prioritas Anda';
  static const editCta = 'Ubah';
  static const reasonLabel = 'Analisis singkat Anda wajib diisi';
  static const reasonPlaceholder = 'Tulis analisis Anda di sini...';
  static const reasonHintLocked = 'Tulis analisis untuk mengaktifkan submit.';
  static const reasonHintReady = 'Siap dikirim.';
  static const submitCta = 'Submit analisis';

  // Hasil salah (bottom sheet) & error
  static const incorrectEyebrow = 'BELUM TEPAT';
  static const incorrectFallback =
      'Susunan prioritas Anda belum tepat. Tinjau kembali urutannya, lalu '
      'coba lagi.';
  static const retryCta = 'Coba lagi';
  static const submitError =
      'Gagal mengirim analisis. Periksa koneksi Anda lalu coba lagi.';

  // Konfirmasi keluar
  static const leaveTitle = 'Keluar dari Ruang Keputusan?';
  static const leaveBody =
      'Susunan prioritas dan analisis yang sudah Anda isi belum tersimpan.';
  static const leaveStay = 'Tetap di sini';
  static const leaveConfirm = 'Keluar';

  // === Layar 4: Badge ===
  static const badgeEyebrow = 'MISI SELESAI \u00b7 RESPONS SISTEMATIS';

  static String badgeTitle(String wabah) =>
      'Selamat! Anda Menuntaskan Studi Kasus Respons ${_name(wabah)}';

  static const badgeNextCta = 'Lanjut ke materi berikutnya';

  /// Tombol sekunder — HANYA muncul saat masuk ke layar Badge lewat jalur
  /// "sudah completed" (bukan setelah baru saja submit benar). Mengerjakan
  /// ulang TIDAK memberi badge baru (submit tetap idempotent di backend,
  /// `completeSectionIfNeeded` pakai firstOrCreate) — cuma untuk latihan.
  static const badgeRetryCta = 'Kerjakan ulang studi kasus';

  /// Fallback kalau judul year kosong — supaya kalimat tidak bolong.
  static String _name(String wabah) {
    final trimmed = wabah.trim();
    return trimmed.isEmpty ? 'Wabah' : trimmed;
  }
}
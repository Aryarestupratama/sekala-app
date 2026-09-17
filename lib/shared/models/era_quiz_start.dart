import 'package:freezed_annotation/freezed_annotation.dart';
import 'era_quiz_question.dart';

part 'era_quiz_start.freezed.dart';
part 'era_quiz_start.g.dart';

/// MENGGANTIKAN `era_quiz.dart` (dihapus) — shape response
/// `GET /api/eras/{era}/quiz` BERUBAH TOTAL dari versi sebelumnya.
///
/// REVISI BESAR: kuis sumatif era TIDAK LAGI punya bank soal sendiri —
/// soal ditarik OTOMATIS dari kuis FORMATIF (quiz_questions) milik tiap
/// year dalam era ini, didistribusikan proporsional (mis. 3 year -> 7/7/6
/// soal) sampai total EraQuiz::ATTEMPT_QUESTION_COUNT (20), lalu diacak
/// urutannya. Endpoint ini dipanggil ULANG setiap kali user MEMULAI kuis
/// (termasuk retake) — soal & urutan BISA BERBEDA tiap kali dipanggil.
///
/// Shape:
/// ```json
/// {
///   "era_quiz_id": 3,
///   "passing_grade": 75,
///   "question_count": 20,
///   "questions": [ { "id": 12, "order": 1, "question": "...", "options": [...] }, ... ]
/// }
/// ```
///
/// TIDAK ADA field `id`/`era_id`/`is_published` di sini lagi (beda dari
/// `era_quiz.dart` versi lama) — response ini murni "paket soal untuk
/// dikerjakan", bukan representasi Eloquent model `EraQuiz`. Kalau perlu
/// tahu status publish, itu urusan gate akses backend (403/404 kalau
/// belum published/belum unlocked), bukan field di sini.
///
/// `passingGrade`/`questionCount` WAJIB ditampilkan ke user SEBELUM masuk
/// soal pertama (requirement "minimum passing grade ditampilkan sebelum
/// masuk halaman quiz") — sama seperti kuis formatif.
///
/// PENTING UNTUK IMPLEMENTASI FLUTTER: karena random terjadi ULANG setiap
/// endpoint ini dipanggil, `questions` dari response ini WAJIB di-cache di
/// state lokal begitu user mulai mengerjakan (mis. simpan di provider/
/// controller state), dan endpoint ini TIDAK BOLEH dipanggil ulang secara
/// diam-diam di tengah sesi (mis. saat app resume/rebuild) — kalau
/// dipanggil ulang, user akan dapat set soal BARU yang beda dari yang
/// sudah dia lihat/jawab sebagian di halaman-halaman sebelumnya. Hanya
/// panggil ulang endpoint ini kalau memang user secara sadar memulai
/// SESI BARU (mis. tap "Mulai Kuis" atau "Kerjakan Ulang" dari roadmap).
@freezed
abstract class EraQuizStart with _$EraQuizStart {
  const factory EraQuizStart({
    @JsonKey(name: 'era_quiz_id') required int eraQuizId,
    @JsonKey(name: 'passing_grade') required int passingGrade,
    @JsonKey(name: 'question_count') required int questionCount,
    @Default(<EraQuizQuestion>[]) List<EraQuizQuestion> questions,
  }) = _EraQuizStart;

  factory EraQuizStart.fromJson(Map<String, dynamic> json) =>
      _$EraQuizStartFromJson(json);
}
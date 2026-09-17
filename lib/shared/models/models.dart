export 'user.dart';
export 'era.dart';
export 'era_ref.dart';
export 'year.dart';
export 'content_block_type.dart';
export 'content_block.dart';
export 'vaccine_card.dart';
export 'vaccine_detail.dart';
export 'card_list_response.dart';
export 'section_summary.dart';
export 'section_year.dart';
export 'section.dart';
export 'home_progress.dart';

// --- Rangkuman Interaktif (year summary) ---
// Menggantikan Year.summaryImageUrl (infografis statis) — pola
// "correct statement" mirip H5P Single Choice Set, 7 poin tetap per year.
export 'year_summary_status.dart';
export 'year_summary_option.dart';
export 'year_summary_point.dart';
export 'year_summary_completion.dart';
export 'year_summary_attempt.dart';
export 'year_summary_point_check_result.dart';
export 'year_summary_submit_result.dart';

// --- Kuis formatif (year) ---
export 'quiz_question_option.dart';
export 'quiz_question.dart';
export 'quiz.dart';
export 'quiz_show_response.dart';
export 'quiz_answer_check_result.dart';
export 'quiz_retry_response.dart';

// --- Kuis sumatif era ("final boss") ---
// REVISI BESAR: era_quiz.dart (lama) sudah DIHAPUS, diganti era_quiz_start.dart
// — soal sekarang ditarik dari bank formatif per year, bukan bank sendiri.
export 'era_quiz_start.dart';
export 'era_quiz_question.dart';
export 'era_quiz_question_option.dart';
export 'era_quiz_score.dart';
export 'era_quiz_result_response.dart';
export 'era_quiz_recap_item.dart';
export 'era_quiz_recap_option.dart';
export 'era_quiz_recap_response.dart';
export 'era_quiz_recap_year.dart';
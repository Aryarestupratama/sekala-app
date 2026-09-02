import 'year.dart';

/// Gabungan `data` (list Year) + `meta` (progress agregat era) dari
/// GET /api/public/eras/{era}/years — lihat Architecture.md §4.7 &
/// YearController.php::index() (`meta.completed_years`/`total_years`).
///
/// Bukan freezed (cuma wrapper hasil parsing manual di
/// HistoryRepositoryImpl, nggak butuh copyWith/equality kompleks).
class EraRoadmap {
  const EraRoadmap({
    required this.years,
    required this.completedYears,
    required this.totalYears,
  });

  final List<Year> years;
  final int completedYears;
  final int totalYears;
}
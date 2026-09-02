import '../../../shared/models/era.dart';
import '../../../shared/models/section.dart';
import '../../../shared/models/year.dart';
import '../../../shared/models/era_roadmap.dart';

abstract class HistoryRepository {
  /// GET /api/public/eras — endpoint publik, guest & user login bisa akses
  /// (R-GUEST-01, R-AUTH-07).
  Future<List<Era>> fetchEras();

  /// GET /api/public/eras/{era:slug}/years — INFO-01, cuma tahun dengan
  /// minimal 1 section published, diurutkan kronologis oleh backend.
  Future<EraRoadmap> fetchYears(String eraSlug);

  /// GET /api/public/sections/{section} — INFO-02. Draft di-treat 404
  /// oleh backend (R-CMS-01), jadi 404 di sini juga berarti section
  /// belum publish (bukan berarti section nggak pernah ada).
  Future<Section> fetchSectionDetail(int sectionId);

  /// POST /api/sections/{section}/complete — trigger "selesai baca"
  /// (INFO-03, R-PROG-02). WAJIB auth:sanctum + verified, idempotent di
  /// sisi backend (R-PROG-03) jadi aman dipanggil berkali-kali dari client.
  Future<void> completeSection(int sectionId);
}

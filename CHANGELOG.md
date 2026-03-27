# Changelog

All notable changes to ProteinTracker will be documented here.

---

## [1.1.0] – 2026-03-27

### Fixed
- Widget no longer lags up to 60 seconds behind the app — it now refreshes instantly every time you log an entry
- Widget calorie label corrected from `c` to `kcal`
- Spacing and readability improvements on the small widget

### Added
- **Medium widget size (`systemMedium`)** — a wider, horizontal layout showing protein, calories, and water side by side with icons and labels
- `.gitignore` added to keep Xcode-generated files and macOS artifacts out of the repo

### Removed
- `TrackerWidgetLiveActivity.swift` — unused Xcode boilerplate (Dynamic Island placeholder)
- `TrackerWidgetControl.swift` — unused Xcode boilerplate (Timer control placeholder)
- `AppIntent.swift` — unused Xcode boilerplate (Favourite Emoji placeholder)

---

## [1.0.0] – 2025-08-26

### Added
- Initial release
- Track daily protein (g), calories (kcal), and water (ml)
- +/- buttons for quick logging
- Auto-resets all values at midnight
- Home screen widget (`systemSmall`) showing current daily totals
- Data shared between app and widget via App Group (`UserDefaults`)

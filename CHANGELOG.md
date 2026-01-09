# Changelog

## 0.2.0 - 2026-01-08
- Updated `ViewState` to be fully generic: `ViewState<Content, ErrorState, EmptyState>`
- Renamed display types to `ErrorDisplayModel` and `EmptyDisplayModel`
- Improved `StateDrivenView` initializers (default `empty`/`error` placeholders when using the display models)
- Refined helpers (`map`, `flatMap`, state accessors) to support the generic state
- Updated and improved examples across iOS, macOS, tvOS and watchOS (modern navigation + less repetitive code)
- Increased unit test coverage (helpers, map, flatMap, and display models)
- Updated README and documentation to match the new API

## 0.1.0 - 2026-01-01
- Initial public release
- `ViewState` and `StateDrivenView`
- Default placeholders for loading/empty/error
- Examples: iOS, macOS, tvOS, watchOS
- Minimum platforms: iOS 17, macOS 14, tvOS 17, watchOS 10

## 0.3.0 - 2026-01-09
- Add package-localized resources and Spanish translations
- Add `L10n` type-safe generated localization API and generator (`Tools/generate_localized_strings.swift`)
- Add SwiftPM build-tool plugin and Makefile target to generate localizations during CI and builds
- Use `Bundle.module` for explicit package resource lookup; updated localization helper
- Replace hard-coded strings in `EmptyDisplayModel` and `ErrorDisplayModel` with localized accessors
- Update example app Info.plist with `CFBundleLocalizations` to enable package resource selection
- Remove temporary runtime debug prints and add tests for localization
- Ignore local `build/` artifacts in `.gitignore`

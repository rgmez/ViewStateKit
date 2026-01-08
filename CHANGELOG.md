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

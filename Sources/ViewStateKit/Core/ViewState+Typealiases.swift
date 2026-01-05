//
//  ViewState+Typealiases.swift
//  ViewStateKit
//
//  Created by Roberto Gómez on 5/1/26.
//

import Foundation

// MARK: - ViewState specializations

/// A `ViewState` specialization for screens that cannot fail.
///
/// This type encodes “no error state” at the type level by using `Never` as the failure type. In practice this means:
/// - The `.error` case cannot be constructed in well-typed code.
/// - Consumers can omit failure handling in many contexts (or treat it as unreachable).
///
/// Example:
/// ```
/// typealias SearchState = ViewStateWithoutError<[User], EmptyDisplayModel>
/// ```
public typealias ViewStateWithoutError<Content, Empty> = ViewState<Content, Never, Empty>

/// A `ViewState` specialization for screens that can never be empty.
///
/// This type encodes “no empty state” at the type level by using `Never` as the empty type. In practice this means:
/// - The `.empty` case cannot be constructed in well-typed code.
/// - Screens using this state must either be `.content`, `.loading`, `.idle`, or `.error`.
///
/// Example:
/// ```
/// typealias ProfileState = ViewStateWithoutEmpty<User, ErrorDisplayModel>
/// ```
public typealias ViewStateWithoutEmpty<Content, Failure> = ViewState<Content, Failure, Never>

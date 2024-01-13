//
//  AsyncStyle+Pulse.swift
//  ButtonKit
//
//  MIT License
//
//  Copyright (c) 2024 Thomas Durand
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import SwiftUI

public struct PulseAsyncButtonStyle: AsyncButtonStyle {
    let disable: Bool

    public init(disableOnLoading: Bool = false) {
        self.disable = disableOnLoading
    }

    public func makeButton(configuration: ButtonConfiguration) -> some View {
        configuration.button
            .compositingGroup()
            .opacity(configuration.isLoading ? 0.5 : 1)
            .animation(.linear(duration: 1).repeatForever(), value: configuration.isLoading)
            .disabled(disable && configuration.isLoading)
    }
}

extension AsyncButtonStyle where Self == PulseAsyncButtonStyle {
    public static var pulse: some AsyncButtonStyle {
        PulseAsyncButtonStyle()
    }
}

#Preview {
    AsyncButton {
        try await Task.sleep(nanoseconds: 30_000_000_000)
    } label: {
        Text("Pulse")
    }
    .buttonStyle(.borderedProminent)
    .asyncButtonStyle(.pulse)
}
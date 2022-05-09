//
//  Style.swift
//  OMDB_FitGrid
//
//  Created by Yurii Mamurko on 08.05.2022.
//

import UIKit

struct Style<View: NSObject> {
    let style: (View) -> Void

    init(_ style: @escaping (View) -> Void) {
        self.style = style
    }

    static func compose(_ styles: Style<View>...)-> Style<View> {
        return Style { view in
            for style in styles {
                style.style(view)
            }
        }
    }

    func apply(to view: View) {
        style(view)
    }
}

protocol Appliable: NSObject {
    associatedtype View

    func apply<View>(_ style: Style<View>)
}

extension Appliable {
    func apply<View>(_ style: Style<View>) {
        guard let view = self as? View else {
            print("Could not apply style for \(View.self) to \(type(of: self))")
            return
        }
        style.apply(to: view)
    }
}

extension UIView: Appliable {
    typealias View = UIView
    convenience init<View>(style: Style<View>) {
        self.init(frame: .zero)
        apply(style)
    }
}

extension CALayer: Appliable {
    typealias View = CALayer
    convenience init<View>(style: Style<View>) {
        self.init()
        apply(style)
    }
}

//
//  LayoutConstraint+ext.swift
//
//  Created by Shimin lyu on 22/3/2021.
//
// Ref: https://www.objc.io/blog/2018/10/30/auto-layout-with-key-paths/

/*
 Example of usage:
 
 let v1 = UIView()
 v1.backgroundColor = .red
 v1.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
 let v2 = UIView()
 v2.backgroundColor = .green

 v1.addSubview(v2, constraints:[
     equal(\.centerYAnchor, \.bottomAnchor),
     equal(\.leftAnchor, constant: 10), equal(\.rightAnchor, constant: -10),
     equal(\.heightAnchor, constant: 100)
 ])
 */

import UIKit

typealias Constraint = (UIView, UIView) -> NSLayoutConstraint

func equal<L, Axis>(_ to: KeyPath<UIView, L>, constant: CGFloat = 0) -> Constraint where L: NSLayoutAnchor<Axis> {
    return equal(to, to, constant: constant)
}

func equal<L, Axis>(_ from: KeyPath<UIView, L>, _ to: KeyPath<UIView, L>, constant: CGFloat = 0) -> Constraint where L: NSLayoutAnchor<Axis> {
    return { view1, view2 in
        view1[keyPath: from].constraint(equalTo: view2[keyPath: to], constant: constant)
    }
}

func equal<L>(_ keyPath: KeyPath<UIView, L>, constant: CGFloat) -> Constraint where L: NSLayoutDimension {
    return { view1, _ in
        view1[keyPath: keyPath].constraint(equalToConstant: constant)
    }
}

extension UIView {
    func addSubview(_ other: UIView, constraints: [Constraint]) {
        other.translatesAutoresizingMaskIntoConstraints = false
        addSubview(other)
        addConstraints(constraints.map { $0(other, self) })
    }
}


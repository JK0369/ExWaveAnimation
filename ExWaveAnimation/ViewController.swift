//
//  ViewController.swift
//  ExWaveAnimation
//
//  Created by Jake.K on 2022/06/28.
//

import UIKit

class ViewController: UIViewController {
  private enum Const {
    static let contentSize = CGSize(width: 120, height: 120)
    static var waveSize: CGSize {
      CGSize(width: Self.contentSize.width + 50, height: Self.contentSize.height + 50)
    }
  }
  
  private let contentsView: RoundView = {
    let view = RoundView()
    view.backgroundColor = .blue
    view.alpha = 0.05
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  private let waveView: RoundView = {
    let view = RoundView()
    view.backgroundColor = .blue
    view.alpha = 0.15
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  var shouldBeAnimated = true {
    didSet {
      guard self.shouldBeAnimated else { return }
      self.animate()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.addSubview(self.contentsView)
    self.view.addSubview(self.waveView)
    
    NSLayoutConstraint.activate([
      self.contentsView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
      self.contentsView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
      self.contentsView.widthAnchor.constraint(equalToConstant: Const.contentSize.width),
      self.contentsView.heightAnchor.constraint(equalToConstant: Const.contentSize.height),
    ])
    NSLayoutConstraint.activate([
      self.waveView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
      self.waveView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
      self.waveView.widthAnchor.constraint(equalToConstant: Const.contentSize.width),
      self.waveView.heightAnchor.constraint(equalToConstant: Const.contentSize.height),
    ])
    
    self.animate()
  }
  
  private func animate(_ flag: Bool = true) {
    guard self.shouldBeAnimated else { return }
    self.view.layoutIfNeeded()
    
    if flag {
      self.waveView.removeConstraints(self.waveView.constraints)
      NSLayoutConstraint.activate([
        self.waveView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        self.waveView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        self.waveView.widthAnchor.constraint(equalToConstant: Const.waveSize.width),
        self.waveView.heightAnchor.constraint(equalToConstant: Const.waveSize.height),
      ])
    } else {
      self.waveView.removeConstraints(self.waveView.constraints)
      NSLayoutConstraint.activate([
        self.waveView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        self.waveView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        self.waveView.widthAnchor.constraint(equalToConstant: Const.contentSize.width),
        self.waveView.heightAnchor.constraint(equalToConstant: Const.contentSize.height),
      ])
    }
    
    UIView.animate(
      withDuration: 0.5,
      delay: 0,
      options: [.curveEaseInOut, .beginFromCurrentState],
      animations: self.view.layoutIfNeeded,
      completion: {
        guard $0 else { return }
        self.animate(!flag)
      }
    )
  }
}

//
//  RoundView.swift
//  ExWaveAnimation
//
//  Created by Jake.K on 2022/06/28.
//

import UIKit

class RoundView: UIView {
  override func layoutSubviews() {
    super.layoutSubviews()
    self.clipsToBounds = true
    self.layer.cornerRadius = self.bounds.height / 2.0
  }
}

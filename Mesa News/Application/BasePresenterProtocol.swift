//
//  BasePresenter.swift
//  Mesa News
//

import Foundation

@objc protocol BasePresenterProtocol {
    @objc func attach(view: NSObjectProtocol)
    @objc func detach()
}

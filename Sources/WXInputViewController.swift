//
//  WXInputViewController.swift
//  WXInputViewController
//
//  Created by xushuifeng on 2020/3/14.
//

import UIKit

public class WXInputViewController: UIViewController {
    
    public var inputBar: WXInputBar!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
        registerNotifications()
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func registerNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardDidShow(_:)),
                                               name: UIResponder.keyboardDidShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillChangeFrame(_:)),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(_:)),
                                               name: UIResponder.keyboardDidHideNotification,
                                               object: nil)
    }
    
    public func dismiss() {
        if inputBar.inputTextView.isFirstResponder {
            inputBar.inputTextView.resignFirstResponder()
        } else {
            
        }
    }
}

// MARK: - Subviews
extension WXInputViewController {
    
    private func configureSubviews() {
        inputBar = WXInputBar(frame: .zero)
        view.addSubview(inputBar)
        inputBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            inputBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            inputBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            inputBar.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -500)
        ])
    }
}

// MARK: - Events
extension WXInputViewController {
    
    @objc private func keyboardDidShow(_ notification: Notification) {
        
    }
    
    @objc private func keyboardWillChangeFrame(_ notification: Notification) {
        
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        
    }
}

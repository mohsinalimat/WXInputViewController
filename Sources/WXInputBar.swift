//
//  WXInputBar.swift
//  WXInputViewController
//
//  Created by xushuifeng on 2020/3/14.
//

import UIKit

public class WXInputBar: UIView {
    
    static var safeInsets: UIEdgeInsets {
        return UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.safeAreaInsets ?? .zero
    }
    
    public let containerView: UIView
    
    public let bottomView: UIView
    
    public let voiceButton: UIButton
    
    public let stickerButton: UIButton
    
    public let moreButton: UIButton
    
    public let inputTextView: WXInputTextView
    
    public var inputTextViewHeightConstraint: NSLayoutConstraint!
    
    public override init(frame: CGRect) {
        
        containerView = UIView()
        
        voiceButton = UIButton(type: .system)
        voiceButton.tintColor = .black
        voiceButton.setImage(UIImage(named: "icons_outlined_voice"), for: .normal)
        
        stickerButton = UIButton(frame: .zero)
        stickerButton.setImage(UIImage(named: "icons_outlined_sticker"), for: .normal)
        
        moreButton = UIButton(frame: .zero)
        moreButton.setImage(UIImage(named: "icons_outlined_add2"), for: .normal)
        
        inputTextView = WXInputTextView(frame: .zero)
        inputTextView.font = UIFont.systemFont(ofSize: 17)
        inputTextView.textContainerInset = UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 8)
        inputTextView.layer.cornerRadius = 6
        inputTextView.layer.masksToBounds = true
        inputTextView.tintColor = .red
        
        bottomView = UIView()
        
        super.init(frame: frame)
        
        backgroundColor = UIColor(red: 245.0/255, green: 246.0/255, blue: 247.0/255, alpha: 1.0)
        
        addSubview(containerView)
        containerView.addSubview(voiceButton)
        containerView.addSubview(stickerButton)
        containerView.addSubview(inputTextView)
        containerView.addSubview(moreButton)
        addSubview(bottomView)
        
        configureConstraints()
        inputTextView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        voiceButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            voiceButton.widthAnchor.constraint(equalToConstant: 40),
            voiceButton.heightAnchor.constraint(equalToConstant: 40),
            voiceButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 6),
            voiceButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8)
        ])
        
        stickerButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stickerButton.widthAnchor.constraint(equalToConstant: 40),
            stickerButton.heightAnchor.constraint(equalToConstant: 40),
            stickerButton.trailingAnchor.constraint(equalTo: moreButton.leadingAnchor, constant: -3),
            stickerButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8)
        ])
        
        inputTextView.translatesAutoresizingMaskIntoConstraints = false
        inputTextView.leadingAnchor.constraint(equalTo: voiceButton.trailingAnchor, constant: 3).isActive = true
        inputTextView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8).isActive = true
        inputTextView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8).isActive = true
        inputTextView.trailingAnchor.constraint(equalTo: stickerButton.leadingAnchor, constant: -3).isActive = true
        inputTextViewHeightConstraint = inputTextView.heightAnchor.constraint(equalToConstant: 40)
        inputTextViewHeightConstraint.isActive = true
        
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            moreButton.widthAnchor.constraint(equalToConstant: 40),
            moreButton.heightAnchor.constraint(equalToConstant: 40),
            moreButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -3),
            moreButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8)
        ])
        
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            bottomView.topAnchor.constraint(equalTo: containerView.bottomAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: WXInputBar.safeInsets.bottom)
        ])
    }
}

// MARK: - UITextViewDelegate
extension WXInputBar: UITextViewDelegate {
    
    public func textViewDidChange(_ textView: UITextView) {
        guard let lineHeight = textView.font?.lineHeight else {
            return
        }
        
        let maxHeight = ceil(lineHeight * CGFloat(4) + textView.textContainerInset.top + textView.textContainerInset.bottom)
        let sizeToFit = CGSize(width: textView.bounds.width, height: UIView.layoutFittingExpandedSize.height)
        let contentHeight = ceil(textView.sizeThatFits(sizeToFit).height)
        textView.isScrollEnabled = contentHeight > maxHeight
        let newHeight = min(contentHeight, maxHeight)
        let oldHeight = inputTextViewHeightConstraint.constant
        let diff = newHeight - oldHeight
        if abs(diff) > 0.1 {
            
            inputTextViewHeightConstraint.constant = newHeight
        }
    }
    
}

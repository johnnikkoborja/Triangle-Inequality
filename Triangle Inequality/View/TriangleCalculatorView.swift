//
//  TriangleCalculatorView.swift
//  Triangle Inequality
//
//  Created by John Nikko Borja on 9/12/22.
//

import Foundation
import UIKit

class TriangleCalculatorView: NSObject {
    
    let headertextLabel = UILabel()
    let noteTextLabel = UILabel()
    let inputTextView = UITextView()
    let resultTextLabel = UILabel()
    let resultValueTextLabel = UILabel()
    let submitButton = UIButton()
    
    var viewModel: TriangleCalculatorViewModel?
    
    override init() {
        super.init()
        styleUI()
    }
    
    private func styleUI() {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.lineSpacing = 8
        
        // Header Label
        let headertextLabelAttributes = NSMutableAttributedString(string: R.string.localizable.homeHeader(),
                                                                     attributes: [ NSAttributedString.Key.paragraphStyle: paragraphStyle])
        headertextLabelAttributes.addAttributes([NSAttributedString.Key.font: UIFont(name: R.string.localizable.fontChalkduster(), size: 18.0)!,
                                          NSAttributedString.Key.foregroundColor: UIColor.black],
                                                   range: NSRange(location: 0, length: headertextLabelAttributes.length))
        headertextLabel.attributedText = headertextLabelAttributes
        
        // Text Input
        let inputTextViewAttributes = NSMutableAttributedString(string: R.string.localizable.homeInputPlaceholder(),
                                                                     attributes: [ NSAttributedString.Key.paragraphStyle: paragraphStyle])
        inputTextViewAttributes.addAttributes([NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .headline),
                                          NSAttributedString.Key.foregroundColor: UIColor.lightGray],
                                                   range: NSRange(location: 0, length: inputTextViewAttributes.length))
        inputTextView.attributedText = inputTextViewAttributes
        inputTextView.addButtonToolbar(onDone: (target: self, action: #selector(doneButtonToolBarTapped)))
        inputTextView.keyboardType = .numbersAndPunctuation
        inputTextView.layer.borderColor = UIColor.black.cgColor
        inputTextView.layer.borderWidth = 1.0
        inputTextView.isScrollEnabled = false
        
        // Note Label
        let noteTextLabelAttributes = NSMutableAttributedString(string: R.string.localizable.homeNote(),
                                                                     attributes: [ NSAttributedString.Key.paragraphStyle: paragraphStyle])
        noteTextLabelAttributes.addAttributes([NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .footnote),
                                          NSAttributedString.Key.foregroundColor: UIColor.lightGray],
                                                   range: NSRange(location: 0, length: noteTextLabelAttributes.length))
        noteTextLabel.attributedText = noteTextLabelAttributes
        
        // Result Label
        let resultTextLabelAttributes = NSMutableAttributedString(string: R.string.localizable.homeResultLabel(),
                                                                     attributes: [ NSAttributedString.Key.paragraphStyle: paragraphStyle])
        resultTextLabelAttributes.addAttributes([NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .body),
                                          NSAttributedString.Key.foregroundColor: UIColor.lightGray],
                                                   range: NSRange(location: 0, length: resultTextLabelAttributes.length))
        resultTextLabel.attributedText = resultTextLabelAttributes
        
        // Result Value
        let resultValueTextLabelAttributes = NSMutableAttributedString(string: " ",
                                                                     attributes: [ NSAttributedString.Key.paragraphStyle: paragraphStyle])
        resultValueTextLabelAttributes.addAttributes([NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .subheadline),
                                          NSAttributedString.Key.foregroundColor: UIColor.lightGray],
                                                   range: NSRange(location: 0, length: resultValueTextLabelAttributes.length))
        resultValueTextLabel.attributedText = resultValueTextLabelAttributes
    
        // Button
        submitButton.setTitle(R.string.localizable.homeButtonTitle(), for: .normal)
        submitButton.backgroundColor = .systemBlue
        submitButton.setTitleColor(UIColor.init(white: 1, alpha: 0.3), for: .disabled)
        submitButton.setTitleColor(UIColor.init(white: 1, alpha: 1), for: .normal)
        submitButton.addTarget(self, action: #selector(self.buttonTapped), for: .touchUpInside)
        
        viewModel = TriangleCalculatorViewModel()
    }
    
    // Actions
    @objc func doneButtonToolBarTapped() {
        inputTextView.resignFirstResponder()
    }
    
    @objc func buttonTapped(sender : UIButton) {
        let inputtedSides = inputTextView.text
        guard let data = viewModel?.manipulateFormData(data: inputtedSides ?? "") else { return }
        viewModel?.combinationsWithoutRepetition(from: data, size: 3)
        viewModel?.checkResult()
    }
}

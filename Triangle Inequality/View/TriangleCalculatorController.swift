//
//  TriangleCalculatorController.swift
//  Triangle Inequality
//
//  Created by John Nikko Borja on 9/12/22.
//

import UIKit
import RxSwift
import RxCocoa

class TriangleCalculatorController: UIViewController {
    
    var triangleCalculatorView: TriangleCalculatorView!
    private var viewModel: TriangleCalculatorViewModel?
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        triangleCalculatorView = TriangleCalculatorView()
        viewModel = triangleCalculatorView.viewModel
        
        setupUI()
        setupObservables()
    }
    
    private func setupUI() {
        
        triangleCalculatorView.inputTextView.delegate = self
        
        view.addSubview(triangleCalculatorView.headertextLabel)
        view.addSubview(triangleCalculatorView.inputTextView)
        view.addSubview(triangleCalculatorView.noteTextLabel)
        view.addSubview(triangleCalculatorView.resultTextLabel)
        view.addSubview(triangleCalculatorView.resultValueTextLabel)
        view.addSubview(triangleCalculatorView.submitButton)
        
        // Constraints
        triangleCalculatorView.headertextLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 50, left: 0, bottom: 50, right: 0))
        triangleCalculatorView.inputTextView.anchor(top: triangleCalculatorView.headertextLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 50, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 38))
        triangleCalculatorView.noteTextLabel.anchor(top: triangleCalculatorView.inputTextView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        
        triangleCalculatorView.resultTextLabel.anchor(top: nil, leading: view.leadingAnchor, bottom: triangleCalculatorView.resultValueTextLabel.topAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 10, right: 0))
        triangleCalculatorView.resultValueTextLabel.anchor(top: nil, leading: view.leadingAnchor, bottom: triangleCalculatorView.submitButton.topAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 30, right: 0))
        triangleCalculatorView.resultValueTextLabel.anchorSize(to: triangleCalculatorView.resultTextLabel)
        triangleCalculatorView.submitButton.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 20, bottom: 50, right: 20))
    }
    
    private func setupObservables() {
        viewModel?.isTriangleInequality
        .asDriver()
        .skip(1)
        .drive(onNext: { [weak self] isTriangleInequality in
            guard let self = self else { return }
            self.triangleCalculatorView.resultValueTextLabel.text = isTriangleInequality ? "True" : "False"
            self.triangleCalculatorView.resultValueTextLabel.textColor = isTriangleInequality ? .systemGreen : .systemRed
            print(isTriangleInequality)
        })
        .disposed(by: disposeBag)
        
        triangleCalculatorView.inputTextView.rx.text
            .subscribe(onNext: { [weak self] (text) in
                guard let self = self else { return }
                self.triangleCalculatorView.submitButton.isEnabled =
                (text != R.string.localizable.homeInputPlaceholder() && !self.triangleCalculatorView.inputTextView.text.isEmpty)
        }).disposed(by: disposeBag)
    }
}

extension TriangleCalculatorController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let aSet = NSCharacterSet(charactersIn:"0123456789,").inverted
        let compSepByCharInSet = text.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return text == numberFiltered
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: view.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        
        textView.constraints.forEach({ (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        })
    }
}

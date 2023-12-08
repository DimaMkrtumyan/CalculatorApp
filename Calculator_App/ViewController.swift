//
//  ViewController.swift
//  Calculator_App
//
//  Created by Dmitriy Mkrtumyan on 09.08.23.
//

import UIKit

final class ViewController: UIViewController {
    // MARK: - Operations ENUM
    enum Operation { case none, division, substraction, addition, multiplication }
    
    // MARK: - Data
    private let defaultCalcSigns = ["÷", "x", "-", "+", "="]
    private let defaultCalcSymbols = [",", "0", "3", "2", "1", "6", "5", "4", "9", "8", "7", "%", "±", "AC"]
    private var currentOperation: Operation = .none
    private var firstNumberInt: Int?
    private var firstNumberDouble: Double?
    private var signFlag: Bool = true
    private var resultSingleCharFlag = false
    
    // MARK: - UI elements
    lazy private var resultTextField: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.text = "0"
        textfield.textColor = .white
        textfield.font = .systemFont(ofSize: 80)
        textfield.textAlignment = .right
        textfield.delegate = self
        return textfield
    }()
    lazy private var defaultCalcCollectionView: UICollectionView = {
        let collectionView = UICollectionView()
        return collectionView
    }()
    private let defaultCalcLayout = UICollectionViewFlowLayout()
    
    // MARK: - UI setup methods
    private func setupSubviews() {
        view.addSubview(resultTextField)
        view.addSubview(defaultCalcCollectionView)
    }
    
    private func resultTextFieldConfig() {
        resultTextField.addCustomConstraints(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.centerXAnchor, paddingTop: 150, width: view.bounds.width - 10, height: 100)
    }
    
    private func setupCollectionLayout() {
        defaultCalcCollectionView = UICollectionView(frame: .zero, collectionViewLayout: defaultCalcLayout)
        defaultCalcLayout.minimumLineSpacing = 12
        defaultCalcLayout.minimumInteritemSpacing = 12
        defaultCalcLayout.collectionView?.showsVerticalScrollIndicator = false
        defaultCalcLayout.collectionView?.showsHorizontalScrollIndicator = false
        defaultCalcLayout.collectionView?.isScrollEnabled = false
        defaultCalcLayout.collectionView?.isUserInteractionEnabled = true
    }
    
    private func defaultCollectionConfig() {
        defaultCalcCollectionView.addCustomConstraints(top: resultTextField.bottomAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, left: view.safeAreaLayoutGuide.leadingAnchor, right: view.safeAreaLayoutGuide.trailingAnchor, paddingTop: 0, paddingBottom: 0, width: view.bounds.width)
        defaultCalcCollectionView.dataSource = self
        defaultCalcCollectionView.delegate = self
        defaultCalcCollectionView.backgroundColor = .clear
        defaultCalcCollectionView.register(DefaultCalcCell.self, forCellWithReuseIdentifier: "DefaultCalcCell")
    }
    
    private func setupGesture() {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(sender:)))
        swipeGesture.direction = .left
        resultTextField.addGestureRecognizer(swipeGesture)
    }
    
    // MARK: - Overrided methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupCollectionLayout()
        setupSubviews()
        setupGesture()
        resultTextFieldConfig()
        defaultCollectionConfig()
    }
    
    // MARK: - objc methods
    @objc
    func didSwipe(sender: UIGestureRecognizer) {
        print("Swiped!")
        guard let text = resultTextField.text else { return }
        if text != "0" && !(text.isEmpty) {
            resultTextField.text?.removeLast()
        }
        if resultTextField.text?.count == 0 {
            resultTextField.text = "0"
        }
    }
    
    @objc
    func digitTapped(sender: CustomButton) {
        switch sender.tag {
        case 0...9: // MARK: 0...9 Digits Actions implementation
            if resultTextField.text == "0" || resultTextField.text == nil {
                resultTextField.text = "\(sender.tag)"
            } else if let text = resultTextField.text {
                resultTextField.text = "\(text)\(sender.tag)"
            }
        case 10: // MARK: - AC Action implementation
            resultTextField.text = "0"
            signFlag = true
        case 11: // MARK: -  +/- Toggle Action implementation
            let sign: Character = "-"
            print(signFlag)
            if let text = resultTextField.text {
                switch signFlag {
                case true:
                    guard text != "0" else { return }
                    let index = text.index(text.startIndex, offsetBy: 0)
                    resultTextField.text?.insert(sign, at: index)
                    signFlag.toggle()
                case false:
                    resultTextField.text?.removeFirst()
                    signFlag.toggle()
                }
            }
        case 12: // MARK: % button implementation
            if let text = resultTextField.text, text != "0", let convertedText = Double(text) {
                let result = convertedText.truncatingRemainder(dividingBy: 100) != 0
                switch result {
                case true: // Double
                    let doubleResult = convertedText / 100
                    resultTextField.text = String(doubleResult)
                case false: // Int
                    let intResult = Int(convertedText / 100)
                    resultTextField.text = String(intResult)
                }
            }
        case 13: // MARK: Decimal Point - checking and insert
            let decimalPoint = "."
            if resultTextField.text != nil {
                if !(resultTextField.text!.contains(where: {$0 == Character(decimalPoint)})) {
                    resultTextField.text! += decimalPoint
                }
            }
        default:
            print("Default")
        }
    }
    
    @objc
    func operationTapped(sender: CustomButton) {
        switch sender.tag {
        case 14:
            currentOperation = .division
            if let text = resultTextField.text {
                // MARK: Decimal Point implementations - Checking first number for decimal point
                if text.contains(where: { $0 == "." }) {
                    let doubleResult = Double(text)
                    firstNumberDouble = doubleResult
                } else {
                    let integerResult = Int(text)
                    firstNumberInt = integerResult
                }
            }
            resultTextField.text = "0"
        case 15:
            currentOperation = .multiplication
            if let text = resultTextField.text {
                // MARK: Decimal Point implementations - Checking first number for decimal point
                if text.contains(where: { $0 == "." }) {
                    let doubleResult = Double(text)
                    firstNumberDouble = doubleResult
                } else {
                    let integerResult = Int(text)
                    firstNumberInt = integerResult
                }
            }
            resultTextField.text = "0"
        case 16:
            currentOperation = .substraction
            if let text = resultTextField.text {
                // MARK: Decimal Point implementations - Checking first number for decimal point
                if text.contains(where: { $0 == "." }) {
                    let doubleResult = Double(text)
                    firstNumberDouble = doubleResult
                } else {
                    let integerResult = Int(text)
                    firstNumberInt = integerResult
                }
            }
            resultTextField.text = "0"
        case 17:
            currentOperation = .addition
            if let text = resultTextField.text {
                // MARK: Decimal Point implementations - Checking first number for decimal point
                if text.contains(where: { $0 == "." }) {
                    let doubleResult = Double(text)
                    firstNumberDouble = doubleResult
                } else {
                    let integerResult = Int(text)
                    firstNumberInt = integerResult
                }
            }
            resultTextField.text = "0"
        case 18: // =
            if let text = resultTextField.text {
                switch currentOperation {
                case .division:
                    // MARK: Decimal Point implementations - Checking second number for decimal point
                    if text.contains(where: { $0 == "." }) || firstNumberDouble != nil {
                        let doubleResult = Double(text)
                        let result = firstNumberDouble! / doubleResult!
                        resultTextField.text = String(result)
                    } else {
                        let integerResult = Int(text)
                        // MARK: - Checking result for floating point before Division operation
                        if firstNumberInt! % integerResult! == 0 {
                            let result = firstNumberInt! / integerResult!
                            resultTextField.text = String(result)
                        } else {
                            let result = Double(firstNumberInt!) / Double(integerResult!)
                            resultTextField.text = String(result)
                        }
                    }
                case .substraction:
                    // MARK: Decimal Point implementations - Checking second number for decimal point
                    if text.contains(where: { $0 == "." }) || firstNumberDouble != nil {
                        let doubleResult = Double(text)
                        let result = firstNumberDouble! - doubleResult!
                        resultTextField.text = String(result)
                    } else {
                        let integerResult = Int(text)
                        let result = firstNumberInt! - integerResult!
                        resultTextField.text = String(result)
                    }
                case .addition:
                    // MARK: Decimal Point implementations - Checking second number for decimal point
                    if text.contains(where: { $0 == "." }) || firstNumberDouble != nil {
                        let doubleResult = Double(text)
                        let result = firstNumberDouble! + doubleResult!
                        resultTextField.text = String(result)
                    } else {
                        let integerResult = Int(text)
                        let result = firstNumberInt! + integerResult!
                        resultTextField.text = String(result)
                    }
                case .multiplication:
                    // MARK: Decimal Point implementations - Checking second number for decimal point
                    if text.contains(where: { $0 == "." }) || firstNumberDouble != nil {
                        let doubleResult = Double(text)
                        let result = firstNumberDouble! * doubleResult!
                        resultTextField.text = String(result)
                    } else {
                        let integerResult = Int(text)
                        let result = firstNumberInt! * integerResult!
                        resultTextField.text = String(result)
                    }
                case .none:
                    break
                }
            }
        default:
            print("Default")
        }
    }

}

// MARK: - Extension for UICollectionView
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        19
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCalcCell", for: indexPath) as? DefaultCalcCell {
            let row = indexPath.row
            cell.digitButton.layer.cornerRadius = 0.5 * cell.bounds.width
            let reversedSymbols = Array(defaultCalcSymbols.reversed())
            
            switch row {
            case 0: // AC
                cell.setupTitle(label: reversedSymbols[0])
                cell.setupCell(titleColor: .black, backgroundColor: #colorLiteral(red: 0.7061325908, green: 0.7061325908, blue: 0.7061325908, alpha: 1))
                cell.digitButton.tag = 10
                cell.digitButton.addTarget(self, action: #selector(digitTapped(sender:)), for: .touchUpInside)
                return cell
            case 1: // +/-
                cell.setupTitle(label: reversedSymbols[1])
                cell.setupCell(titleColor: .black, backgroundColor: #colorLiteral(red: 0.7061325908, green: 0.7061325908, blue: 0.7061325908, alpha: 1))
                cell.digitButton.tag = 11
                cell.digitButton.addTarget(self, action: #selector(digitTapped(sender:)), for: .touchUpInside)
                return cell
            case 2: // %
                cell.setupTitle(label: reversedSymbols[2])
                cell.setupCell(titleColor: .black, backgroundColor: #colorLiteral(red: 0.7061325908, green: 0.7061325908, blue: 0.7061325908, alpha: 1))
                cell.digitButton.tag = 12
                cell.digitButton.addTarget(self, action: #selector(digitTapped(sender:)), for: .touchUpInside)
                return cell
            case 4: // 7
                cell.setupTitle(label: reversedSymbols[3])
                cell.digitButton.tag = 7
                cell.digitButton.addTarget(self, action: #selector(digitTapped(sender:)), for: .touchUpInside)
                return cell
            case 5: // 8
                cell.setupTitle(label: reversedSymbols[4])
                cell.setupCell(titleColor: .white)
                cell.digitButton.tag = 8
                cell.digitButton.addTarget(self, action: #selector(digitTapped(sender:)), for: .touchUpInside)
                return cell
            case 6: // 9
                cell.setupTitle(label: reversedSymbols[5])
                cell.setupCell(titleColor: .white)
                cell.digitButton.tag = 9
                cell.digitButton.addTarget(self, action: #selector(digitTapped(sender:)), for: .touchUpInside)
                return cell
            case 8: // 4
                cell.setupTitle(label: reversedSymbols[6])
                cell.setupCell(titleColor: .white)
                cell.digitButton.tag = 4
                cell.digitButton.addTarget(self, action: #selector(digitTapped(sender:)), for: .touchUpInside)
                return cell
            case 9: // 5
                cell.setupTitle(label: reversedSymbols[7])
                cell.setupCell(titleColor: .white)
                cell.digitButton.tag = 5
                cell.digitButton.addTarget(self, action: #selector(digitTapped(sender:)), for: .touchUpInside)
                return cell
            case 10: // 6
                cell.setupTitle(label: reversedSymbols[8])
                cell.setupCell(titleColor: .white)
                cell.digitButton.tag = 6
                cell.digitButton.addTarget(self, action: #selector(digitTapped(sender:)), for: .touchUpInside)
                return cell
            case 12: // 1
                cell.setupTitle(label: reversedSymbols[9])
                cell.setupCell(titleColor: .white)
                cell.digitButton.tag = 1
                cell.digitButton.addTarget(self, action: #selector(digitTapped(sender:)), for: .touchUpInside)
                return cell
            case 13: // 2
                cell.setupTitle(label: reversedSymbols[10])
                cell.setupCell(titleColor: .white)
                cell.digitButton.tag = 2
                cell.digitButton.addTarget(self, action: #selector(digitTapped(sender:)), for: .touchUpInside)
                return cell
            case 14: // 3
                cell.setupTitle(label: reversedSymbols[11])
                cell.setupCell(titleColor: .white)
                cell.digitButton.tag = 3
                cell.digitButton.addTarget(self, action: #selector(digitTapped(sender:)), for: .touchUpInside)
                return cell
            case 16: // 0
                cell.setupTitle(label: reversedSymbols[12])
                cell.setupCell(titleColor: .white)
                cell.digitButton.layer.cornerRadius = 0.5 * ((cell.bounds.width / 2) - 11)
                cell.digitButton.tag = 0
                cell.digitButton.addTarget(self, action: #selector(digitTapped(sender:)), for: .touchUpInside)
                return cell
            case 17: // ,
                cell.setupTitle(label: reversedSymbols[13])
                cell.setupCell(titleColor: .white)
                cell.digitButton.tag = 13
                cell.digitButton.addTarget(self, action: #selector(digitTapped(sender:)), for: .touchUpInside)
                return cell
            default:
                cell.setupCell(titleColor: .white, backgroundColor: #colorLiteral(red: 1, green: 0.6865338683, blue: 0.007479981985, alpha: 1))
                switch row {
                case 3: // division
                    cell.setupTitle(label: defaultCalcSigns[0])
                    cell.digitButton.tag = 14
                    cell.digitButton.addTarget(self, action: #selector(operationTapped(sender:)), for: .touchUpInside)
                    return cell
                case 7: // multiplication
                    cell.setupTitle(label: defaultCalcSigns[1])
                    cell.digitButton.tag = 15
                    cell.digitButton.addTarget(self, action: #selector(operationTapped(sender:)), for: .touchUpInside)
                    return cell
                case 11: // substraction
                    cell.setupTitle(label: defaultCalcSigns[2])
                    cell.digitButton.tag = 16
                    cell.digitButton.addTarget(self, action: #selector(operationTapped(sender:)), for: .touchUpInside)
                    return cell
                case 15: // addition
                    cell.setupTitle(label: defaultCalcSigns[3])
                    cell.digitButton.tag = 17
                    cell.digitButton.addTarget(self, action: #selector(operationTapped(sender:)), for: .touchUpInside)
                    return cell
                case 18: // =
                    cell.setupTitle(label: defaultCalcSigns[4])
                    cell.digitButton.tag = 18
                    cell.digitButton.addTarget(self, action: #selector(operationTapped(sender:)), for: .touchUpInside)
                    return cell
                default:
                    break
                }
            }
        }
        
        return UICollectionViewCell()
    }
}

extension ViewController: UICollectionViewDelegate {
}

// MARK: - Delegate FlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let columns: CGFloat = 4
        let collectionViewWidth = collectionView.bounds.width
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let singleItemInset = layout.minimumInteritemSpacing
        let itemsInsets = singleItemInset * (columns - 1)
        let adjustedSize = collectionViewWidth - itemsInsets
        
        switch indexPath.row {
        case 16:
            let eachCellWidth = (adjustedSize / 2) + singleItemInset
            return CGSize(width: eachCellWidth, height: (eachCellWidth / 2) - singleItemInset)
        default:
            let eachCellWidth = adjustedSize / columns
            return CGSize(width: eachCellWidth, height: eachCellWidth)
        }
    }
}

// MARK: - Extension for UITextField
extension ViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == resultTextField {
            return false
        }
        return true
    }
}

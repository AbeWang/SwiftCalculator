import UIKit

enum Operator {
	case NONE, ADD, SUB, MUL, DIV
}

class CalculatorViewController: UIViewController {

	// First Row
	var constraintsForFirstRow: AnyObject[]?
	@IBOutlet var sevenButton: UIButton!
	@IBOutlet var eightButton: UIButton!
	@IBOutlet var nineButton: UIButton!
	@IBOutlet var divButton: UIButton!

	// Second Row
	var constraintsForSecondRow: AnyObject[]?
	@IBOutlet var fourButton: UIButton!
	@IBOutlet var fiveButton: UIButton!
	@IBOutlet var sixButton: UIButton!
	@IBOutlet var mulButton: UIButton!

	// Third Row
	var constraintsForThirdRow: AnyObject[]?
	@IBOutlet var oneButton: UIButton!
	@IBOutlet var twoButton: UIButton!
	@IBOutlet var threeButton: UIButton!
	@IBOutlet var subButton: UIButton!

	// Fourth Row
	var constraintsForFourthRow: AnyObject[]?
	@IBOutlet var dotButton: UIButton!
	@IBOutlet var zeroButton: UIButton!
	@IBOutlet var equlButton: UIButton!
	@IBOutlet var addButton: UIButton!

	@IBOutlet var viewerLabel: UILabel!
	var previousNumeric: NSMutableString! = NSMutableString(string: "0")
	var currentNumeric: NSMutableString! = NSMutableString(string: "0")
	var operatorType: Operator = .NONE

	// For Layout Constraint
	override func viewWillLayoutSubviews() {
		let buttonWidth = 55.0
		let unusedHorizontalSpace: CGFloat = self.view.bounds.size.width - (buttonWidth * 4)
		let spaceBetweenEachButton: NSNumber = NSNumber(double: unusedHorizontalSpace / 5)

		if constraintsForFirstRow {
			self.view.removeConstraints(constraintsForFirstRow)
			self.view.removeConstraints(constraintsForSecondRow)
			self.view.removeConstraints(constraintsForThirdRow)
			self.view.removeConstraints(constraintsForFourthRow)
		}

		constraintsForFirstRow = NSLayoutConstraint.constraintsWithVisualFormat("H:|-(space)-[seven]-(space)-[eight]-(space)-[nine]-(space)-[div]-(space)-|", options: NSLayoutFormatOptions.AlignAllCenterY, metrics: NSDictionary(object: spaceBetweenEachButton, forKey: "space"), views: NSDictionary(objects: [sevenButton, eightButton, nineButton, divButton], forKeys: ["seven", "eight", "nine", "div"]))
		constraintsForSecondRow = NSLayoutConstraint.constraintsWithVisualFormat("H:|-(space)-[four]-(space)-[five]-(space)-[six]-(space)-[mul]-(space)-|", options:NSLayoutFormatOptions.AlignAllCenterY, metrics: NSDictionary(object: spaceBetweenEachButton, forKey: "space"), views: NSDictionary(objects: [fourButton, fiveButton, sixButton, mulButton], forKeys: ["four", "five", "six", "mul"]))
		constraintsForThirdRow = NSLayoutConstraint.constraintsWithVisualFormat("H:|-(space)-[one]-(space)-[two]-(space)-[three]-(space)-[sub]-(space)-|", options:NSLayoutFormatOptions.AlignAllCenterY, metrics: NSDictionary(object: spaceBetweenEachButton, forKey: "space"), views: NSDictionary(objects: [oneButton, twoButton, threeButton, subButton], forKeys: ["one", "two", "three", "sub"]))
		constraintsForFourthRow = NSLayoutConstraint.constraintsWithVisualFormat("H:|-(space)-[dot]-(space)-[zero]-(space)-[equl]-(space)-[add]-(space)-|", options:NSLayoutFormatOptions.AlignAllCenterY, metrics: NSDictionary(object: spaceBetweenEachButton, forKey: "space"), views: NSDictionary(objects: [dotButton, zeroButton, equlButton, addButton], forKeys: ["dot", "zero", "equl", "add"]))

		self.view.addConstraints(constraintsForFirstRow)
		self.view.addConstraints(constraintsForSecondRow)
		self.view.addConstraints(constraintsForThirdRow)
		self.view.addConstraints(constraintsForFourthRow)
	}

	@IBAction func pressNumericAction(sender: AnyObject) {
		if currentNumeric.isEqualToString("0") {
			currentNumeric.setString(sender.currentTitle)
		}
		else {
			currentNumeric.appendString(sender.currentTitle)
		}
		viewerLabel.text = currentNumeric
	}

	@IBAction func pressOperatorAction(sender: AnyObject) {
		if operatorType != .NONE {
			self.pressEqualAction(nil)
		}
		else {
			previousNumeric.setString(currentNumeric)
			currentNumeric.setString("0")
		}

		var operatorString: NSString = sender.currentTitle

		switch operatorString {
			case "+":
				operatorType = .ADD
			case "-":
				operatorType = .SUB
			case "X":
				operatorType = .MUL
			case "/":
				operatorType = .DIV
			default:
				operatorType = .NONE
		}
	}

	@IBAction func pressDecimalAction(sender: AnyObject) {
		if currentNumeric.rangeOfString(".").location == NSNotFound {
			currentNumeric.appendString(".")
			viewerLabel.text = currentNumeric
		}
	}

	@IBAction func pressClearAction(sender: AnyObject) {
		previousNumeric.setString("0")
		currentNumeric.setString("0")
		operatorType = .NONE
		viewerLabel.text = previousNumeric
	}

	@IBAction func pressEqualAction(sender: AnyObject!) {
		if operatorType == .NONE {
			return
		}

		var previousNumber: NSDecimalNumber = NSDecimalNumber(string: previousNumeric)
		var currentNumber: NSDecimalNumber = NSDecimalNumber(string: currentNumeric)
		var formatter: NSNumberFormatter = NSNumberFormatter()
		formatter.maximumFractionDigits = 4
		formatter.minimumIntegerDigits = 1

		switch operatorType {
			case .ADD:
				previousNumeric.setString(formatter.stringFromNumber(previousNumber.decimalNumberByAdding(currentNumber)))
			case .SUB:
				previousNumeric.setString(formatter.stringFromNumber(previousNumber.decimalNumberBySubtracting(currentNumber)))
			case .MUL:
				previousNumeric.setString(formatter.stringFromNumber(previousNumber.decimalNumberByMultiplyingBy(currentNumber)))
			case .DIV:
				previousNumeric.setString(formatter.stringFromNumber(previousNumber.decimalNumberByDividingBy(currentNumber)))
			default:
				previousNumeric.setString("0")
		}

		viewerLabel.text = previousNumeric
		currentNumeric.setString("0")
		operatorType = .NONE
	}
}

import UIKit

enum Operator {
	case NONE, ADD, SUB, MUL, DIV
}

class CalculatorViewController: UIViewController {

	var constraintForFirstColumn: [AnyObject]!
	var constraintForSecondColumn: [AnyObject]!
	var constraintForThirdColumn: [AnyObject]!
	var constraintForFourthColumn: [AnyObject]!

	var constraintsForFirstRow: [AnyObject]!
	var constraintsForSecondRow: [AnyObject]!
	var constraintsForThirdRow: [AnyObject]!
	var constraintsForFourthRow: [AnyObject]!

	@IBOutlet var zeroButton: UIButton!
	@IBOutlet var oneButton: UIButton!
	@IBOutlet var twoButton: UIButton!
	@IBOutlet var threeButton: UIButton!
	@IBOutlet var fourButton: UIButton!
	@IBOutlet var fiveButton: UIButton!
	@IBOutlet var sixButton: UIButton!
	@IBOutlet var sevenButton: UIButton!
	@IBOutlet var eightButton: UIButton!
	@IBOutlet var nineButton: UIButton!

	@IBOutlet var addButton: UIButton!
	@IBOutlet var subButton: UIButton!
	@IBOutlet var mulButton: UIButton!
	@IBOutlet var divButton: UIButton!

	@IBOutlet var dotButton: UIButton!
	@IBOutlet var equlButton: UIButton!

	@IBOutlet var viewerLabel: UILabel!
	@IBOutlet var clearButton: UIButton!

	var previousNumeric: NSMutableString! = NSMutableString(string: "0")
	var currentNumeric: NSMutableString! = NSMutableString(string: "0")
	var operatorType: Operator = .NONE

	override func viewWillLayoutSubviews() {

		/* Horizontal Constraint */

		let buttonWidth = 55.0
		let unusedHorizontalSpace = Double(CGRectGetWidth(self.view.bounds)) - Double(buttonWidth * 4)
		let spaceBetweenEachButtonForHorizontal = NSNumber(double: unusedHorizontalSpace / 5)

		let horizontalVisualFormat: String = "H:|-(space)-[b1]-(space)-[b2]-(space)-[b3]-(space)-[b4]-(space)-|"
		let horizontalButtonKeys = ["b1", "b2", "b3", "b4"]
		let horizontalSpaceMetrics = NSDictionary(object: spaceBetweenEachButtonForHorizontal, forKey: "space")

		if constraintsForFirstRow != nil {
			self.view.removeConstraints(constraintsForFirstRow)
			self.view.removeConstraints(constraintsForSecondRow)
			self.view.removeConstraints(constraintsForThirdRow)
			self.view.removeConstraints(constraintsForFourthRow)
		}

		constraintsForFirstRow = NSLayoutConstraint.constraintsWithVisualFormat(horizontalVisualFormat, options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: horizontalSpaceMetrics, views: NSDictionary(objects: [sevenButton, eightButton, nineButton, divButton], forKeys: horizontalButtonKeys))
		constraintsForSecondRow = NSLayoutConstraint.constraintsWithVisualFormat(horizontalVisualFormat, options:NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: horizontalSpaceMetrics, views: NSDictionary(objects: [fourButton, fiveButton, sixButton, mulButton], forKeys: horizontalButtonKeys))
		constraintsForThirdRow = NSLayoutConstraint.constraintsWithVisualFormat(horizontalVisualFormat, options:NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: horizontalSpaceMetrics, views: NSDictionary(objects: [oneButton, twoButton, threeButton, subButton], forKeys: horizontalButtonKeys))
		constraintsForFourthRow = NSLayoutConstraint.constraintsWithVisualFormat(horizontalVisualFormat, options:NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: horizontalSpaceMetrics, views: NSDictionary(objects: [dotButton, zeroButton, equlButton, addButton], forKeys: horizontalButtonKeys))

		self.view.addConstraints(constraintsForFirstRow)
		self.view.addConstraints(constraintsForSecondRow)
		self.view.addConstraints(constraintsForThirdRow)
		self.view.addConstraints(constraintsForFourthRow)

		/* Vertical Constraint */

		let unusedVerticalSpace = Double(CGRectGetHeight(self.view.bounds)) - Double(CGRectGetMaxY(viewerLabel.frame)) - Double(buttonWidth * 5)
		let spaceBetweenEachButtonForVertical: NSNumber = NSNumber(double: unusedVerticalSpace / 6)
		let topSpace: NSNumber = NSNumber(double: unusedVerticalSpace / 6 + Double(CGRectGetMaxY(viewerLabel.frame)))

		let verticalVisualFormat = "V:|-(topSpace)-[b1]-(space)-[b2]-(space)-[b3]-(space)-[b4]-(space)-[b5]-(space)-|"
		let verticalButtonKeys = ["b1", "b2", "b3", "b4", "b5"]
		let verticalSpaceMetrics = NSDictionary(objects: [topSpace, spaceBetweenEachButtonForVertical], forKeys: ["topSpace", "space"])

		if constraintForFirstColumn != nil {
			self.view.removeConstraints(constraintForFirstColumn)
			self.view.removeConstraints(constraintForSecondColumn)
			self.view.removeConstraints(constraintForThirdColumn)
			self.view.removeConstraints(constraintForFourthColumn)
		}

		constraintForFirstColumn = NSLayoutConstraint.constraintsWithVisualFormat(verticalVisualFormat, options:NSLayoutFormatOptions.DirectionLeadingToTrailing , metrics: verticalSpaceMetrics, views:NSDictionary(objects: [clearButton, sevenButton, fourButton, oneButton, dotButton], forKeys: verticalButtonKeys))
		constraintForSecondColumn = NSLayoutConstraint.constraintsWithVisualFormat(verticalVisualFormat, options:NSLayoutFormatOptions.DirectionLeadingToTrailing , metrics: verticalSpaceMetrics, views:NSDictionary(objects: [clearButton, eightButton, fiveButton, twoButton, zeroButton], forKeys: verticalButtonKeys))
		constraintForThirdColumn = NSLayoutConstraint.constraintsWithVisualFormat(verticalVisualFormat, options:NSLayoutFormatOptions.DirectionLeadingToTrailing , metrics: verticalSpaceMetrics, views:NSDictionary(objects: [clearButton, nineButton, sixButton, threeButton, equlButton], forKeys: verticalButtonKeys))
		constraintForFourthColumn = NSLayoutConstraint.constraintsWithVisualFormat(verticalVisualFormat, options:NSLayoutFormatOptions.DirectionLeadingToTrailing , metrics: verticalSpaceMetrics, views:NSDictionary(objects: [clearButton, divButton, mulButton, subButton, addButton], forKeys: verticalButtonKeys))

		self.view.addConstraints(constraintForFirstColumn)
		self.view.addConstraints(constraintForSecondColumn)
		self.view.addConstraints(constraintForThirdColumn)
		self.view.addConstraints(constraintForFourthColumn)
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

		var previousNumber = NSDecimalNumber(string: previousNumeric)
		var currentNumber = NSDecimalNumber(string: currentNumeric)
		var formatter = NSNumberFormatter()
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

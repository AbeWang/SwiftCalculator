import UIKit

enum Operator {
	case NONE, ADD, SUB, MUL, DIV
}

class CalculatorViewController: UIViewController {

	@IBOutlet var viewerLabel: UILabel!
	var previousNumeric: NSMutableString! = NSMutableString(string: "0")
	var currentNumeric: NSMutableString! = NSMutableString(string: "0")
	var operatorType: Operator = .NONE

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

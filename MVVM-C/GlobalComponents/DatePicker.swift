import UIKit

class DatePicker {
    
    private var datePicker: UIDatePicker?
    
    func showDatePicker(completion: @escaping (_ date: String) -> Void) {
        
        if let controller = UIWindow.getTopViewController() {
            let alert = UIAlertController(title: "Pick Date", message: "\n\n\n\n\n\n\n\n\n\n\n", preferredStyle: .actionSheet)
            datePicker = UIDatePicker(frame: CGRect(x:0, y:40, width: controller.view.frame.size.width, height: 250))
            datePicker?.datePickerMode = .date
            datePicker?.maximumDate = Date()
            alert.view.addSubview(datePicker!)
            let doneAction = UIAlertAction(title: "Done", style: .destructive) { [weak self] (action) in
                if let dateString = self?.datePicker?.date.dateAndTimetoString(format: .MMMddyyyy) {
                    completion(dateString)
                }
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(doneAction)
            alert.addAction(cancelAction)
            controller.present(alert, animated: true, completion: nil)
        }
    }
}

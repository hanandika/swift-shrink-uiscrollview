import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //hide keyboard when user tap outside textfield
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
          target: self,
          action: #selector(self.dismissKeyboard)
        )
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        //add NotificationCenter for keyboardWillShowNotification and keyboardWillHideNotification
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        //get keyboard size
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            //get and set scrollview content inset
            var contentInset:UIEdgeInsets = self.scrollView.contentInset
            contentInset.bottom = keyboardSize.size.height
            scrollView.contentInset = contentInset
            
            //re-layout
            self.view.layoutIfNeeded()
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        // reset content inset
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
        
        //re-layout
        self.view.layoutIfNeeded()
    }
}

//
//  MailService.swift
//  CoppaPai
//
//  Created by Neil McGrogan on 4/28/25.
//

import Foundation
import MessageUI

@available(iOS 13.0, *)
public class MailHelper: NSObject, MFMailComposeViewControllerDelegate {
    public static let shared = MailHelper()
    private override init() { }
    
    public func sendEmail(subject: String, body: String, to: String){
        guard MFMailComposeViewController.canSendMail() else {
            print("Cannot send mail")
            return
        }
        let mailComposeViewController = MFMailComposeViewController()
        mailComposeViewController.mailComposeDelegate = self
        mailComposeViewController.setToRecipients([to])
        mailComposeViewController.setSubject(subject)
        mailComposeViewController.setMessageBody(body, isHTML: false)
        MailHelper.getRootViewController()?.present(mailComposeViewController, animated: true, completion: nil)
    }
    
    public static func getRootViewController() -> UIViewController? {
        guard let firstScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return nil
        }
        guard let firstWindow = firstScene.windows.first else {
            return nil
        }
        let viewController = firstWindow.rootViewController
        return viewController
    }
    
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?)
    {
        switch (result) {
        case .sent:
            print("email sent.")
            break
        case .cancelled:
            print("email cancelled.")
            break
        case .failed:
            print("failed sending email")
            break
        default:
            break
        }
        controller.dismiss(animated: true, completion: nil)
    }
}

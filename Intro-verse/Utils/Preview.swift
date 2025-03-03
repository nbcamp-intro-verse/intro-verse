//
//  Preview.swift
//  Intro-verse
//
//  Created by Seungho Jang on 3/3/25.
//

#if DEBUG && os(iOS)
import SwiftUI
extension UIViewController {
    private struct Preview: UIViewControllerRepresentable {
        let viewController: UIViewController
        
        func makeUIViewController(context: Context) -> UIViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewController, context: Context){
            
        }
    }
    
    func toPreview() -> some View {
        Preview(viewController: self)
    }
}
#endif

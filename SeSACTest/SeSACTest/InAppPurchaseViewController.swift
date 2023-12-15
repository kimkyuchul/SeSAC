//
//  InAppPurchaseViewController.swift
//  SeSACTest
//
//  Created by 김규철 on 2023/12/15.
//

import UIKit
import StoreKit

class InAppPurchaseViewController: UIViewController {
    
    @IBOutlet weak var productLabel: UILabel!
    
    //1. 인앱 상품 ID 정의
    var productIdentifier: Set<String> = ["com.ios.StoreKitTest.RemoveAd"]
    
    var productArray = Array<SKProduct>()
    var product: SKProduct?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestProductData()
    }
    
    //2. productIdentifier에 정의된 상품 아이디가 실제로 존재하는지 (상품 ID 정보 가져오기) + 사용자의 디바이스가 인앱 결제가 가능한 지
    func requestProductData() {
        // 사용자의 디바이스가 인앱 결제 가능 확인
        if SKPaymentQueue.canMakePayments() {
            print("인앱 결제 가능")
            //3. 인앱 상품에 대한 조회
            let request = SKProductsRequest(productIdentifiers: productIdentifier)
            request.delegate = self
            request.start() // 인앱 상품 조회 시작
        } else {
            print("In App Purchase Not Enabled")
        }
    }
    
    @IBAction func BuyButtonClicked(_ sender: UIButton) {
        // 5. 구매 버튼 클릭
        // 응답에 따라 어떻게 처리할지
        //        let payment = SKPayment(product: productArray[0])
        let payment = SKPayment(product: product!)
        SKPaymentQueue.default().add(payment)
        //        SKPaymentQueue.default().add(self)
    }
    
}

extension InAppPurchaseViewController: SKProductsRequestDelegate {
    
    // 4. 인앱 상품 정보 조회
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        
        let products = response.products
        
        if !products.isEmpty {
            
            for item in products {
                productArray.append(item)
                product = item
                
                print(item.productIdentifier)
                print(item.localizedTitle)
                print(item.price)
                print(item.priceLocale)
            }
        }
    }
}

// SKPaymentTransactionObserver: 구매 승인, 취소에 대한 프로토콜.
extension InAppPurchaseViewController: SKPaymentTransactionObserver {
    
    func receiptVaildation(transaction: SKPaymentTransaction, productIdentifier: String) {
        
        // 구매 영수증 정보
        let receiptFillURL = Bundle.main.appStoreReceiptURL
        let receiptData = try? Data(contentsOf: receiptFillURL!)
        let receiptString = receiptData?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        
        print(receiptString)
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
        for transaction in transactions {
            
            switch transaction.transactionState {
            case .purchasing:
                // 구매 중
                print("purchasing")
            case .purchased:
                // 완벽하게 구매 완료
                print("purchased")
                // 상품의 productIdentifier를 조회 (영수증 조회)
                print(transaction.payment.productIdentifier)
                receiptVaildation(transaction: transaction, productIdentifier: transaction.payment.productIdentifier)
            case .failed:
                // 통장 잔액 부족 등으로 결제 실패
                print("failed")
                // 결제가 실패하였으니, 기존의 작업(transaction)을 끝내도록
                SKPaymentQueue.default().finishTransaction(transaction)
            case .restored:
                // 구매 복원
                print("restored")
            case .deferred:
                print("deferred")
            @unknown default:
                print("default")
            }
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, removedTransactions transactions: [SKPaymentTransaction]) {
        print("removedTransactions")
    }
}

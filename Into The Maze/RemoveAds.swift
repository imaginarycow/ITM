//
//  RemoveAds.swift
//  Into The Maze
//
//  Created by ramiro beltran on 8/10/16.
//  Copyright © 2016 Ramiro Beltran. All rights reserved.
//

import Foundation
import StoreKit

let product_Id = "net.beliro.Maze.removeAds"
let productIdentifiers = Set(["net.beliro.Maze.removeAds"])
var list = [SKProduct]()

extension MainMenuScene:  SKProductsRequestDelegate, SKPaymentTransactionObserver{
    
    func checkIfIapsEnabled() {
        
        if(SKPaymentQueue.canMakePayments()) {
            print("IAP is enabled, loading")
            var productID:NSSet = NSSet(objects: product_Id)
            let request: SKProductsRequest = SKProductsRequest(productIdentifiers: productID as! Set<String>)
            request.delegate = self
            request.start()
        } else {
            print("please enable IAPS")
        }

    }
    
    func paymentQueue(queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction])    {
        print("Received Payment Transaction Response from Apple");
        
        for transaction in transactions {
            //if let trans:SKPaymentTransaction = transaction as? SKPaymentTransaction{
            switch transaction.transactionState {
                
            case .Purchased:
                print("Product Purchased")
                queue.finishTransaction(transaction)
                deliverProduct(transaction)
                break
            case .Failed:
                failedTransaction(transaction)
                print("Purchased Failed")
                let alert = UIAlertView(title: "Purchase failed", message: "Please try again.", delegate: nil, cancelButtonTitle: "OK")
                alert.show()
            case .Restored:
                restoreTransaction(transaction)
                queue.finishTransaction(transaction)
                break
            case .Deferred:
                break
            case .Purchasing:
                break
            default:
                break
            }
        }
        
    }
    
    func restoreTransaction(transaction: SKPaymentTransaction) {
        guard let productIdentifier = transaction.originalTransaction?.payment.productIdentifier else { return }
        
        print("restoreTransaction... \(productIdentifier)")
        SKPaymentQueue.defaultQueue().finishTransaction(transaction)
    }
    
    func failedTransaction(transaction: SKPaymentTransaction) {
        print("failedTransaction...")
        if transaction.error!.code != SKErrorCode.PaymentCancelled.rawValue {
            print("Transaction Error: \(transaction.error?.localizedDescription)")
        }
        
        SKPaymentQueue.defaultQueue().finishTransaction(transaction)
    }
    
    func productsRequest (request: SKProductsRequest, didReceiveResponse response: SKProductsResponse) {
        print("got the request from Apple")
        var products = response.products
        print("products available = \(products.count)")
        if (products.count != 0) {
            for product in products {
                list.append(product as SKProduct)
            }
        }
    }
    
    func deliverProduct(transaction:SKPaymentTransaction) {
        
        if transaction.payment.productIdentifier == "net.beliro.Maze.removeAds" {
            print("remove ads purchased")
            // Unlock Feature
            removeAds()
            let alert = UIAlertView(title: "Thank You", message: "Ads will be removed.", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        }
        
    }
    
    func restorePurchases() {
        SKPaymentQueue.defaultQueue().addTransactionObserver(self)
        SKPaymentQueue.defaultQueue().restoreCompletedTransactions()
    }

    func paymentQueueRestoreCompletedTransactionsFinished(queue: SKPaymentQueue) {
        print("Transactions Restored")

        var purchasedItemIDS = []
        for transaction:SKPaymentTransaction in queue.transactions {

            if transaction.payment.productIdentifier == product_Id
            {
                print("remove ads purchase restored")
                // Unlock Feature
                removeAds()
            }
           
        }

        let alert = UIAlertView(title: "Thank You", message: "Your purchase(s) were restored.", delegate: nil, cancelButtonTitle: "OK")
        alert.show()
    }
    
    func finishTransaction(trans:SKPaymentTransaction) {
        print("finish trans")
        SKPaymentQueue.defaultQueue().finishTransaction(trans)
    }
    
    func buyProduct(str:String) {
        if list.count > 0 {
            for p in list {
                if p.productIdentifier == str {
                    let payment = SKPayment(product: p)
                    SKPaymentQueue.defaultQueue().addTransactionObserver(self)
                    SKPaymentQueue.defaultQueue().addPayment(payment)
                }
            }
            
        }
        
    }
    
    
}// End Extension

func removeAds() {
    
    adsRemoved = true
    gameData.setBool(adsRemoved, forKey: "adsRemoved")
    gameData.synchronize()
    
}





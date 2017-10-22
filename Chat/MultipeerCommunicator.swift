//
//  MultipeerCommunicator.swift
//  Chat
//
//  Created by Air on 20.10.17.
//  Copyright © 2017 Dasha. All rights reserved.
//

protocol Communicator {
    func sendMessage(string: String, to userID: String?, completionHandler: ((_ success : Bool, _ error: Error?) -> ())?)
    weak var delegate : CommunicatorDelegate? {get set}
    var online: Bool {get set}
}




import Foundation
import MultipeerConnectivity

class MultipeerCommunicator: NSObject,   Communicator {
    
    weak var delegate: CommunicatorDelegate?
    
    var online: Bool = false
    
    private let serviceType = "tinkoff-chat"
    
    private let myPeerId = MCPeerID(displayName: UIDevice.current.name)
    
    private let serviceAdvertiser: MCNearbyServiceAdvertiser
    private let serviceBrowser: MCNearbyServiceBrowser
    
    var sessions = [String: MCSession]()
    
    override init() {
        
        self.serviceAdvertiser = MCNearbyServiceAdvertiser(peer: myPeerId, discoveryInfo: ["userName": "d.a.roi"], serviceType: serviceType)
        
        self.serviceBrowser = MCNearbyServiceBrowser(peer: myPeerId, serviceType: serviceType)
        
        super.init()
        
        serviceAdvertiser.delegate = self
        serviceAdvertiser.startAdvertisingPeer()
        
        serviceBrowser.delegate = self
        serviceBrowser.startBrowsingForPeers()
    }
    
    
    
    func sendMessage(string: String, to userID: String?, completionHandler: ((_ success : Bool, _ error: Error?) -> ())?) {
        var string1 = "Hello"
        do {
            if let session = sessions[userID ?? ""] {
                let message = "{\"eventType\":\"TextMessage\", \"messageId\":\"\(generateMessageId())\", \"text\": \"\(string1)\"}"
                try session.send(message.data(using: .utf8)!, toPeers: session.connectedPeers, with: .reliable)
                completionHandler?(true, nil)
            }
        } catch {
            completionHandler?(false, error)
        }
    }
    
    func generateMessageId() -> String {
        let string = "\(arc4random_uniform(UINT32_MAX)) + \(Date.timeIntervalSinceReferenceDate) + \(arc4random_uniform(UINT32_MAX))".data(using: .utf8)?.base64EncodedString()
        return string!
    }
    
}


extension MultipeerCommunicator: MCNearbyServiceAdvertiserDelegate {
    
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: Error) {
        delegate?.failedToStartAdvertising(error: error)
    }
    
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        
        var userName: String?

        do {
            if let context = context {
                if let json  = try JSONSerialization.jsonObject(with: context, options: []) as? Dictionary<String, String> {
                    userName = json["userName"]
                }
            }
        } catch {
            print(error)
        }

        let session = MCSession(peer: self.myPeerId, securityIdentity: nil, encryptionPreference: .none)
        session.delegate = self
        
        self.sessions[peerID.displayName] = session
        
        delegate?.didFoundUser(userID: peerID.displayName, userName: userName)
        
        invitationHandler(true, session)
    }
}


extension MultipeerCommunicator: MCNearbyServiceBrowserDelegate {
    
    func browser(_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: Error) {
        delegate?.failedToStartBrosingForUsers(error: error)
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {

        if self.sessions[peerID.displayName] == nil {
            let session = MCSession(peer: self.myPeerId, securityIdentity: nil, encryptionPreference: .none)
            session.delegate = self
            
            self.sessions[peerID.displayName] = session
            
            let userName = info?["userName"]
            
            let context = "{\"userName\": \"\(userName ?? "")\"}"
            browser.invitePeer(peerID, to: session, withContext: context.data(using: .utf8), timeout: 30)
            
            delegate?.didFoundUser(userID: peerID.displayName, userName: userName)
        }
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        delegate?.didLostUser(userID: peerID.displayName)
    }
    
}

extension MultipeerCommunicator: MCSessionDelegate {
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        if state == .notConnected {
            sessions[peerID.displayName] = nil
            delegate?.didLostUser(userID: peerID.displayName)
            session.cancelConnectPeer(peerID)
        }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        print("I recieved")
        
        do {
            if let json = try? JSONSerialization.jsonObject(with: data, options: []) as! [String: String] {
                if let message = json["text"]{
                    delegate?.didReceiveMessage(text: message, fromUser: peerID.displayName, toUser: myPeerId.displayName)
                }
            }
        }
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
    }
}















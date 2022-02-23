//
//  ApiComponentSendable.swift
//  TestApp
//
//  Created by cm0620 on 2022/2/23.
//

import Foundation

protocol ApiComponentSendable {
    func sendRequest(request: URLRequest, queue: DispatchQueue, handler: @escaping (Data?, URLResponse?, Error?) -> Void)
}

extension ApiComponentSendable {
    
    /// 發送Request(使用初始決策)
    func send<Req: Request>(
        request: Req,
        queue: DispatchQueue,
        handler: @escaping (Swift.Result<Req.Response, Error>) -> Void)
    {
        send(request: request,
             decisions: request.decisions,
             queue: queue,
             handler: handler)
    }
    
    /// 發送Request(使用特定決策)
    func send<Req: Request>(
        request: Req,
        decisions: [Decision],
        queue: DispatchQueue,
        handler: @escaping (Swift.Result<Req.Response, Error>) -> Void)
    {
        // 建立Request
        let urlRequest: URLRequest
        do {
            urlRequest = try request.buildRequest()
        } catch {
            handler(.failure(error))
            return
        }
        
        // 通知發送Request事件
        let startDate = Date()
        print("🌐 [\(Req.self)][\(urlRequest.method?.rawValue ?? "")]: \(urlRequest.url?.absoluteString.removingPercentEncoding ?? "")")
        
        // 發送Request
        sendRequest(request: urlRequest, queue: queue){
            (data, response, error) in
            
            // 通知收到Request事件
            var executionTime = Date().timeIntervalSince(startDate)
            executionTime = Double(round(1000 * executionTime) / 1000)
            print("⏰ [\(Req.self)][ReceiveTime]: \(executionTime)s - \(urlRequest.url?.absoluteString.removingPercentEncoding ?? "")")
            
            // 錯誤: 有Error
            if let error = error {
                print("📦 [\(Req.self)][ReceiveError]: \(error)")
                handler(.failure(ApiComponentError.apiFailure(data: data, response: response, error: error)))
                return
            }
            
            // 錯誤: 沒有HTTPURLResponse
            guard let response = response, let httpResponse = response as? HTTPURLResponse else {
                handler(.failure(ApiComponentError.nonHTTPResponse))
                return
            }

            let dataStr: String = {
                if let data = data {
                    return String(data: data, encoding: .utf8) ?? "No Utf8 Data.(無法解析!!)"
                } else {
                    return "Data Nil.(沒有Data!!)"
                }
            }()
            print("📦 [\(Req.self)][StatusCode = \(httpResponse.statusCode)][ReceiveData]: \(dataStr)")
            
            self.handleDecision(
                request: request,
                queue: queue,
                data: data,
                response: httpResponse,
                nowDecisions: decisions,
                decisionRecords: [],
                handler: handler
            )
        }
    }
    
    /// 處理決策
    func handleDecision<Req: Request>(
        request: Req,
        queue: DispatchQueue,
        data: Data?,
        response: HTTPURLResponse,
        nowDecisions: [Decision],
        decisionRecords: [DecisionRecord<Req>],
        handler: @escaping (Swift.Result<Req.Response, Error>) -> Void)
    {
        guard !nowDecisions.isEmpty else {
            print("決策設定錯誤，無法回傳成功還是失敗!!!⚠️⚠️⚠️")
            return
        }
        
        // 取出目前決策
        var nowDecisions = nowDecisions
        let current = nowDecisions.removeFirst()
        
        // 是否應用決策
        guard current.shouldApply(request: request, data: data, response: response) else {
            var decisionRecords = decisionRecords
            decisionRecords.append(DecisionRecord(decision: current, isApply: false, action: nil))
            handleDecision(request: request,
                           queue: queue,
                           data: data,
                           response: response,
                           nowDecisions: nowDecisions,
                           decisionRecords: decisionRecords,
                           handler: handler)
            return
        }
        
        // 判斷決策
        current.apply(request: request, data: data, response: response) { action in
            
            var decisionRecords = decisionRecords
            decisionRecords.append(DecisionRecord(decision: current, isApply: true, action: action))
            
            switch action {
            case .continueWith(let data, let response):
                self.handleDecision(request: request,
                                    queue: queue,
                                    data: data,
                                    response: response,
                                    nowDecisions: nowDecisions,
                                    decisionRecords: decisionRecords,
                                    handler: handler)
            case .restartWith(let decisions):
                self.send(request: request, decisions: decisions, queue: queue, handler: handler)
            case .errored(let error):
                self.printDecisionRecords(records: decisionRecords)
                handler(.failure(error))
            case .done(let response):
                self.printDecisionRecords(records: decisionRecords)
                handler(.success(response))
            }
        }
    }
    
    /// 顯示決策結果
    func printDecisionRecords<Req: Request>(records: [DecisionRecord<Req>]){
        let allRecordStrings = records.map{ record -> String in
            let decision = String(describing: record.decision)
            let isApply = record.isApply ? "❗️" : "❕"
            if let action = record.action{
               let actionDescribing = String(describing: action)
                return "{\(decision)\(isApply)}[\(actionDescribing)]"
            } else {
                return "{\(decision)\(isApply)}"
            }
        }
        print("🚥 [\(Req.self)][Decisions]: \(allRecordStrings.joined(separator: " -> "))")
    }
}

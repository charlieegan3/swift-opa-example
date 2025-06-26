import SwiftOPA
import Foundation
import AST
import Rego


// Prepare query to check the example policy
let rawQuery = "data.example.allow"

// Create input documents
let rawInput = #"{"foo": "bar"}"#.data(using: .utf8)!
let inputDocument = try AST.RegoValue(jsonData: rawInput)

let rawInput2 = #"{"foo": "baz"}"#.data(using: .utf8)!
let inputDocument2 = try AST.RegoValue(jsonData: rawInput2)

func evaluateOPA() async throws {
    let bundlePath = OPA.Engine.BundlePath(name: "bundle", url: URL(fileURLWithPath: "./bundle_extracted"))
    var engine = OPA.Engine(bundlePaths: [bundlePath])

    let preparedQuery = try await engine.prepareForEvaluation(query: rawQuery)

    // Evaluate first query
    let resultSet = try await preparedQuery.evaluate(input: inputDocument)
    let result = try resultSet.jsonString
    print("Query result with foo: bar - \(result)")

    // Evaluate second query
    let resultSet2 = try await preparedQuery.evaluate(input: inputDocument2)
    let result2 = try resultSet2.jsonString
    print("Query result with foo: baz - \(result2)")
}

// Run the evaluation
await withCheckedContinuation { continuation in
    Task {
        do {
            try await evaluateOPA()
        } catch {
            print("Error: \(error)")
        }
        continuation.resume()
    }
}

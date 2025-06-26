# SwiftOPA Example

A simple Swift example project demonstrating how to use
[Open Policy Agent (OPA)](https://www.openpolicyagent.org/)
with the [SwiftOPA library](https://github.com/open-policy-agent/swift-opa).
This example is based
on the [swift-opa](https://github.com/open-policy-agent/swift-opa) project.

## Overview

This example shows how to evaluate OPA policies in Swift applications. The project includes:

- A simple Rego policy that allows requests where `input.foo == "bar"`
- A Swift application that evaluates the policy with different inputs
- Docker support for running the application

## Project Structure

- `Sources/main.swift` - Main Swift application
- `bundle/policy.rego` - OPA policy definition
- `Package.swift` - Swift package configuration
- `Makefile` - Build and run commands

## Requirements

- OPA CLI (for building policy bundles)
- Swift 6.0+ (or Docker as an alternative)

## Usage

### Building the Policy Bundle

```bash
make bundle_build
```

This command builds the OPA policy bundle using `opa build --target=plan --entrypoint=example/allow bundle/` and extracts it to `bundle_extracted/`. SwiftOPA requires a compiled plan, which is created using the `--target=plan` option.

### Running with Docker

```bash
make docker_run
```

This runs the Swift application in a Docker container with Swift 6.0.

### Running Locally

```bash
make run
```

## Policy

The example policy in `bundle/policy.rego` allows requests where the input contains `foo: "bar"`:

```rego
package example

allow if {
    input.foo == "bar"
}
```

The Swift application tests this policy with two different inputs:

- `{"foo": "bar"}` - Should return `true`
- `{"foo": "baz"}` - Should return `false`


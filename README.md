# s_factory

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Development Guide

### Setup

1. Install dependencies

```bash
flutter pub get
```

2. Run the app

```bash
flutter run
```

### Deploy to Firebase (if you change the queries)

```bash
firebase deploy --only dataconnect
```

### Generate GraphQL Code (if you change the queries)

```bash
firebase dataconnect:sdk:generate
```

### SQL Proxy (for connect database with DBeaver)

```bash
cloud-sql-proxy fir-factory-45cec:asia-southeast1:fir-factory-45cec-instance
```

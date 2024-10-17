# Order Demo using SwiftData with Solid Architecture

A trivial app used to demonstrate how to use `SwiftData` in a way that doesn't violate separation of concerns (SOC).

Each branch is ordered and shows the evolution of the app from starting a new project with `SwiftData` through several bug fixes and finally a refactor to move data access out of the view.

While `SwiftData` is a convenient and powerful framework that Apple will continue to enhance, and is valuable to embrace, the convention promoted mixes UI code with data access. Bugs and issues typically appear as `SwiftUI` failures that are often difficult to track down and resolve. This also makes testing complex as views are tightly dependent on external SQLite persisted data and executions produce durable side effects. 

Separating data acesss into isolated classes that are injected as protocol dependencies provides that opportunity to easily configure test scenarios using mock implementations of protocols and provides opportunities for instrumentation and advanced debugging where `SwiftData` property wrappers in `SwiftUI` views fall short. A few of the _magical_ update features of `SwiftUI` intergration are not propogated outside of `SwiftUI` but these are easily remedied. This example project does not demonstrate testing as the trivial nature of the app doesn't lend to meaningful examples. Perhaps I'll add this in the future...

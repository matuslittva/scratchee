Scratchee

iOS Scratch Card Assignment

Minimum Deployment Target: iOS 17

⸻

✅ Overview

Scratchee is a small SwiftUI application implementing the assignment requirements for modeling a scratch card lifecycle:
	•	Unscratched → Scratched → Activated
	•	Scratching simulates a heavy operation (2 seconds)
	•	The scratch operation is cancellable when the user leaves the screen
	•	Activation calls the remote API and updates the card state based on version comparison
	•	Critical logic is covered by unit tests

Architecture follows a clean layering:
`Data → Domain → Presentation`

Navigation is implemented without coordinators, using a simple NavigationStack with dependency injection via AppFactory.

⸻

✅ Features

🔹 Home Screen
	•	Displays the current card state
	•	Button to navigate to Scratch screen
	•	Button to navigate to Activation screen (enabled only when applicable)
	•	Real-time state updates via ObserveCardStateUseCase

🔹 Scratch Screen
	•	Performs a simulated heavy scratch operation (2s)
	•	Operation is cancelled automatically when user leaves the screen
	•	On success, card transitions to .scratched(code)
	•	Clean cancellation handling using a stored Task in ScratchViewModel

🔹 Activation Screen
	•	Activation calls:
GET https://api.o2.sk/version
	•	If ios field > 6.1 → card becomes .activated
	•	Otherwise an error alert is shown
	•	Activation does not cancel if the view closes (as required)

⸻

✅ Architecture

Data Layer
	•	HTTPClient abstraction with a live implementation
	•	VersionRepositoryLive and CardsRepositoryLive
	•	DTOs separated from domain models

Domain Layer
	•	Entities: CardState, Version (with safe version comparison logic)
	•	Repositories protocols
	•	Use cases:
	•	ScratchCardUseCase
	•	ActivateCardUseCase
	•	ObserveCardStateUseCase

Presentation Layer

SwiftUI MVVM:
	•	HomeViewModel, ScratchViewModel, ActivationViewModel
	•	Views for each screen
	•	Square card UI in Home view
	•	Navigation via RootFlow and AppFactory for dependency injection

⸻

✅ Testing

All critical logic is unit tested:
	•	Version parsing & comparison
	•	VersionRepository
	•	CardsRepository spy
	•	Use cases (scratch, activate, observe)
	•	ViewModels
	•	Cancellation behavior (including scratch cancellation)

Spies are implemented as actors where needed to avoid data races with Swift 6 actor isolation.

⸻

✅ Requirements
	•	✅ iOS 17+
	•	✅ SwiftUI
	•	✅ Async/Await
	•	✅ Swift Concurrency (actors, Task cancellation)
	•	✅ Clean, testable architecture

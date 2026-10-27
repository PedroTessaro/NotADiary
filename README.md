<div align="center">

<img src="docs/icon.jpg" width="140" alt="NotADiary app icon" style="border-radius: 28px;"/>

# NotADiary

### An emotional journal for iOS that goes beyond words.

Capture how you feel with text, photos, music, and **haptic feedback** that turns
every emotion into a physical sensation, guided by a little puppy mascot that
mirrors your mood.

<br/>

[![Platform](https://img.shields.io/badge/iOS-26.0+-000000?logo=apple&logoColor=white)](https://www.apple.com/ios/)
[![Swift](https://img.shields.io/badge/Swift-5-FA7343?logo=swift&logoColor=white)](https://swift.org)
[![SwiftUI](https://img.shields.io/badge/SwiftUI-0080FF?logo=swift&logoColor=white)](https://developer.apple.com/xcode/swiftui/)
[![CloudKit](https://img.shields.io/badge/CloudKit-iCloud-3693F3?logo=icloud&logoColor=white)](https://developer.apple.com/icloud/cloudkit/)
[![License](https://img.shields.io/badge/License-MIT-3DA639)](LICENSE)

<br/>

<a href="https://apps.apple.com/br/app/notadiary/id6753695305">
  <img src="https://developer.apple.com/app-store/marketing/guidelines/images/badge-download-on-the-app-store.svg" height="56" alt="Download on the App Store"/>
</a>

</div>

---

## Table of Contents

- [About](#about)
- [Screenshots](#screenshots)
- [Meet the Mascot](#meet-the-mascot)
- [Features](#features)
- [Tech Stack](#tech-stack)
- [Requirements](#requirements)
- [Project Structure](#project-structure)
- [Getting Started](#getting-started)
- [Team](#team)
- [License](#license)

---

## About

**NotADiary** ("not a diary") is a journaling app focused on emotional check-ins.
The idea is simple: instead of just writing, you tie each entry to an **emotion**, a
**song** and **photos**, and the device itself *responds* to that emotion through
vibration patterns (haptics) carefully designed for each feeling.

A mascot follows along with every entry, shifting its mood to match the emotion you
log, giving your journal real personality.

---

## Screenshots

<div align="center">

| Log your feelings | Learn about yourself | Share what you love |
|:---:|:---:|:---:|
| <img src="docs/screenshots/log-feelings.png" width="240"/> | <img src="docs/screenshots/learn-about-yourself.png" width="240"/> | <img src="docs/screenshots/share-with-loved-ones.png" width="240"/> |

</div>

---

## Meet the Mascot

The puppy reacts to your entry with **12 mood states** (six base emotions, each
with an *ultra* variant). Here are the six core moods:

<div align="center">

| Happiness | Sadness | Anger |
|:---:|:---:|:---:|
| <img src="docs/mascots/happiness.png" width="150"/> | <img src="docs/mascots/sadness.png" width="150"/> | <img src="docs/mascots/anger.png" width="150"/> |
| **Fear** | **Surprise** | **Love** |
| <img src="docs/mascots/fear.png" width="150"/> | <img src="docs/mascots/surprise.png" width="150"/> | <img src="docs/mascots/love.png" width="150"/> |

</div>

---

## Features

- **Journal entries**: title, text, date and the emotion of the moment.
- **Emotional mascot**: a character that mirrors the entry's mood, with 12 states (happiness, anger, surprise, fear, love, sadness, and their intense variants).
- **Emotional haptics**: unique vibration patterns built with **Core Haptics** for each emotion (e.g. a "heartbeat" for love, a "tremor" for fear, an "explosion" for anger).
- **Apple Music integration**: search and attach a song to each entry via **MusicKit**, with in-app playback and **Music Haptics** support.
- **Photos**: attach images to your entries in a visual gallery.
- **iCloud sync**: all entries and preferences are stored and synced with **CloudKit**.
- **Reminders**: schedule notifications to remember to log your day.
- **Shareable cards**: export and share entries as a custom `.card` document type.
- **Onboarding**: a welcome flow with name setup and notification configuration.

---

## Tech Stack

| Area | Technology |
|------|-----------|
| UI | SwiftUI |
| Persistence / Sync | CloudKit (iCloud) |
| Music | MusicKit · MediaPlayer · AVFoundation |
| Haptics | Core Haptics · MediaAccessibility (Music Haptics) |
| Notifications | UserNotifications |
| Architecture | MVVM |

> There is also exploratory work integrating **HealthKit (State of Mind)** to log mood in the Health app.

---

## Requirements

- **iOS 26.0** or later
- Xcode 26 or later
- An iCloud account (for sync)
- An Apple Music subscription (for the music features)

---

## Project Structure

```
NotADiary/
├── NotADiaryApp.swift          # Entry point
├── Models/
│   ├── JournalModels/          # JournalEntry, Entry, Mascot, Image
│   ├── ShareModels/            # Card (Transferable / UTType)
│   ├── MusicKitModels/         # Music Haptics
│   ├── HealthKitModels/        # State of Mind (exploratory)
│   ├── EmotionHapticEngine.swift  # Per-emotion vibration patterns
│   ├── NotificationsModel.swift
│   └── PreferenceModel.swift
├── ViewModels/
│   ├── CloudKitVM/             # Entry & preference sync
│   ├── MusicKitVM/             # Music player and search
│   ├── JournalVM/              # Mascot logic
│   ├── ShareVM/                # Card generation & conversion
│   └── HealthKitVM/
├── Views/
│   ├── OnboardingViews/        # Name & notification setup flow
│   ├── JournalViews/           # List, create, edit and view entries
│   ├── ShareViews/             # Shareable card
│   └── Components/             # Reusable components (mascot, music, photos…)
├── Extensions/
└── Assets/                     # Colors, mascots (SVG) and icons
```

The architecture follows the **MVVM** pattern, cleanly separating data models,
presentation logic (ViewModels with `@Observable`/`ObservableObject`) and the
SwiftUI views.

---

## Getting Started

**Requirements:** Xcode 26+, an iCloud account, and an Apple Music subscription for music features.

```bash
# Clone the repository
git clone https://github.com/EnzoFerroni/NotADiary.git
cd NotADiary

# Open the project in Xcode
open NotADiary.xcodeproj
```

Pick a simulator or device and run with **⌘R**. (CloudKit, MusicKit and Haptics work best on a real device.)

---

## Team

<div align="center">
  <table>
    <tr>
      <td align="center" width="20%">
        <a href="https://github.com/EnzoFerroni"><img src="https://github.com/EnzoFerroni.png" width="90" alt="Enzo Ferroni"/></a>
        <br/><sub><b>Enzo Ferroni</b></sub><br/><br/>
        <a href="https://github.com/EnzoFerroni"><img src="https://skillicons.dev/icons?i=github" alt="GitHub"/></a>
        <a href="https://www.linkedin.com/in/enzoferroni/"><img src="https://skillicons.dev/icons?i=linkedin" alt="LinkedIn"/></a>
      </td>
      <td align="center" width="20%">
        <a href="https://github.com/LosadaT"><img src="https://github.com/LosadaT.png" width="90" alt="Francisco Losada"/></a>
        <br/><sub><b>Francisco Losada</b></sub><br/><br/>
        <a href="https://github.com/LosadaT"><img src="https://skillicons.dev/icons?i=github" alt="GitHub"/></a>
        <a href="https://www.linkedin.com/in/francisco-losada-totaro/"><img src="https://skillicons.dev/icons?i=linkedin" alt="LinkedIn"/></a>
      </td>
      <td align="center" width="20%">
        <a href="https://github.com/gsgonca"><img src="https://github.com/gsgonca.png" width="90" alt="Gabriel Gonçalves"/></a>
        <br/><sub><b>Gabriel Gonçalves</b></sub><br/><br/>
        <a href="https://github.com/gsgonca"><img src="https://skillicons.dev/icons?i=github" alt="GitHub"/></a>
        <a href="https://www.linkedin.com/in/gabriel-s-gon%C3%A7alves/"><img src="https://skillicons.dev/icons?i=linkedin" alt="LinkedIn"/></a>
      </td>
      <td align="center" width="20%">
        <a href="https://github.com/PedroTessaro"><img src="https://github.com/PedroTessaro.png" width="90" alt="Pedro Tessaro"/></a>
        <br/><sub><b>Pedro Tessaro</b></sub><br/><br/>
        <a href="https://github.com/PedroTessaro"><img src="https://skillicons.dev/icons?i=github" alt="GitHub"/></a>
        <a href="https://www.linkedin.com/in/pedrotessaro/"><img src="https://skillicons.dev/icons?i=linkedin" alt="LinkedIn"/></a>
      </td>
      <td align="center" width="20%">
        <a href="https://github.com/hyauss"><img src="https://github.com/hyauss.png" width="90" alt="Vinicius Marques"/></a>
        <br/><sub><b>Vinicius Marques</b></sub><br/><br/>
        <a href="https://github.com/hyauss"><img src="https://skillicons.dev/icons?i=github" alt="GitHub"/></a>
        <a href="https://www.linkedin.com/in/vinicius-marques-966918274/"><img src="https://skillicons.dev/icons?i=linkedin" alt="LinkedIn"/></a>
      </td>
    </tr>
  </table>
</div>

---

## License

Released under the [MIT License](LICENSE). © 2026 Enzo Ferroni, Francisco Losada, Gabriel Gonçalves, Pedro Tessaro and Vinicius Marques.

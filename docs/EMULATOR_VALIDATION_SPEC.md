# EMULATOR_VALIDATION_SPEC.md — Chrug MVP Phase 1

## Overview

Comprehensive validation checklist for testing Chrug MVP Phase 1 on iOS and Android emulators before release.

**Goal:** Ensure feature parity, performance, and reliability across all target devices.

---

## Target Device Matrix

### iOS (Mandatory Testing)

| Device | OS | Screen Size | Notes |
|--------|----|----|-------|
| iPhone 15 Pro | 17.5+ | 6.1" | Flagship baseline |
| iPhone 15 | 17.5+ | 6.1" | Standard model |
| iPhone 14 | 16.0+ | 6.1" | Older stable version |
| iPhone SE | 15.0+ | 4.7" | Small form factor |
| iPad Pro | 17.5+ | 11" / 12.9" | Tablet testing |

**Emulator Settings:**
- Orientation: Portrait + Landscape
- Network: Wi-Fi enabled + Disabled
- Memory: At least 4GB allocated
- Storage: At least 10GB free

### Android (Mandatory Testing)

| Device | OS | Screen Size | Aspect Ratio | Notes |
|--------|----|----|-------|-------|
| Pixel 8 | 14+ | 6.2" | 20:9 | Flagship baseline |
| Pixel 7a | 13+ | 6.1" | 20:9 | Mid-range reference |
| Samsung Galaxy S23 | 13+ | 6.1" | 20:9 | Common Android device |
| Samsung Galaxy Tab S9 | 13+ | 11" | 16:10 | Tablet testing |
| OnePlus 12 | 14+ | 6.7" | 20:9 | Curved display |
| Motorola Edge | 12+ | 6.7" | 20:9 | Budget model |

**Emulator Settings:**
- Orientation: Portrait + Landscape
- Network: Wi-Fi enabled + Disabled
- Memory: At least 4GB allocated
- Storage: At least 10GB free

---

## Pre-Testing Setup

### iOS Emulator Setup

```bash
# Install latest Xcode
xcode-select --install

# List available iOS simulators
xcrun simctl list devices

# Create new simulator (if needed)
xcrun simctl create "iPhone 15 Pro" \
  com.apple.CoreSimulator.SimDeviceType.iPhone-15-Pro \
  com.apple.CoreSimulator.SimRuntime.iOS-17-5

# Erase simulator (clean state)
xcrun simctl erase "iPhone 15 Pro"

# Boot simulator
xcrun simctl boot "iPhone 15 Pro"

# Verify simulator is running
xcrun simctl list devices | grep Booted
```

### Android Emulator Setup

```bash
# List available Android Virtual Devices
emulator -list-avds

# Create new AVD (if needed)
android create avd -n "Pixel8" -t "android-34" \
  -b x86_64 -c 2G -d 5.5in

# Start emulator
emulator -avd Pixel8 -memory 4096 -netdelay none -netspeed full

# Verify emulator is running
adb devices
```

### Environment Variables

```bash
# Add to ~/.bashrc or ~/.zshrc
export FLUTTER_HOME=$HOME/flutter
export PATH=$PATH:$FLUTTER_HOME/bin
export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
export ANDROID_AVD_HOME=$HOME/.android/avd
export JAVA_HOME=$(/usr/libexec/java_home)
```

---

## Pre-Build Validation

### Code Quality Checks

```bash
# Run analyzer
flutter analyze

# Expected: No errors, only warnings (if any)
# If errors found: Fix before testing
```

### Dependencies Verification

```bash
# Get all dependencies
flutter pub get

# Check for outdated packages
flutter pub outdated

# Verify pub.dev packages are accessible
flutter pub upgrade
```

### Build Verification

```bash
# Verify iOS build
flutter build ios --analyze-size

# Verify Android build
flutter build apk --analyze-size

# Check for build errors
# Expected: "✓ Built <file>.ipa" or "✓ Built <file>.apk"
```

---

## Functional Testing Checklist

### Phase 1: Authentication Flow

**Signup Flow**
- [ ] **Splash Screen**
  - [ ] Displays for exactly 2-3 seconds
  - [ ] Dumbbell icon centered
  - [ ] No user input during display
  - [ ] Transitions smoothly to next screen

- [ ] **First-Time User Screen**
  - [ ] Profile icon visible (top-left, grayed)
  - [ ] Notification bell visible (top-right, grayed)
  - [ ] "Create New Program" card visible
  - [ ] "How to get started?" section visible
  - [ ] "Watch Video" button functional
  - [ ] "Login or Signup!" text clickable
  - [ ] Bottom bar icons visible (but disabled)

- [ ] **Signup Screen**
  - [ ] Greek myth art background displays correctly
  - [ ] Dumbbell icon centered
  - [ ] "Continue with Apple" button visible (iOS only)
  - [ ] Email input field functional
  - [ ] Black arrow button appears on typing
  - [ ] Keyboard appears when tapping input
  - [ ] Email validation (accepts any input, Phase 1)
  - [ ] "Privacy Policy" + "Terms of Service" links visible

- [ ] **Account Verification Screen**
  - [ ] Displays correct email: "example@mail.com"
  - [ ] 6 digit input fields render correctly
  - [ ] Auto-focus on first field, keyboard appears
  - [ ] Digits auto-advance to next field
  - [ ] Auto-submit on 6th digit entered (after 500ms)
  - [ ] Loading spinner appears during verification
  - [ ] "Didn't receive the code? Resend" link appears
  - [ ] Resend button disabled for 30 seconds after click
  - [ ] Countdown timer displays correctly
  - [ ] "Edit email" link appears after 1st failed attempt

- [ ] **Apple Sign-In** (iOS only)
  - [ ] "Continue with Apple" button triggers native dialog
  - [ ] Dialog shows Apple account selection
  - [ ] Successful sign-in navigates to Workout Days screen
  - [ ] Failed/canceled sign-in returns to signup screen

---

### Phase 2: Workout System

**Program Creation**
- [ ] **Create Program Modal**
  - [ ] Bottom sheet slides up smoothly (300ms)
  - [ ] Input field focused, keyboard appears
  - [ ] User types program name: "Push/Pull/Legs"
  - [ ] Create button enabled (turns dark) after typing
  - [ ] Suggestion bubbles appear below input
  - [ ] Tapping suggestion pre-fills input
  - [ ] Tap "Create" proceeds to exercise selection

- [ ] **Select Exercise Screen**
  - [ ] Back arrow visible, clickable
  - [ ] "Next" button disabled (grayed) initially
  - [ ] Search bar functional, filters in real-time
  - [ ] Filter bubbles (Chest, Back, Leg, Tricep) work
  - [ ] Three dots on exercise card shows preview
  - [ ] Checkbox fills when exercise selected
  - [ ] "Next" button enables when ≥1 exercise selected
  - [ ] Can select multiple exercises
  - [ ] Can scroll through exercise list
  - [ ] Exercise images load correctly (no broken images)

**Workout Logging**
- [ ] **Workout Days Screen**
  - [ ] Program name displays (top-center)
  - [ ] "Change Program >" link clickable
  - [ ] Day cards display with names
  - [ ] Card tap navigates to Workout Day screen
  - [ ] Notification bell shows count (if notifications enabled)
  - [ ] Share icon opens iOS/Android share sheet
  - [ ] Empty state shows if no days

- [ ] **Workout Day Screen**
  - [ ] Back arrow navigates back
  - [ ] Day name displays (e.g., "Day 1")
  - [ ] "rename day?" link functional, opens modal
  - [ ] Exercise cards list all exercises
  - [ ] Up/Down arrows reorder exercises
  - [ ] Tap exercise card navigates to Exercise Details
  - [ ] "+ Add Exercise" button floating (bottom-right)
  - [ ] Tapping button opens Select Exercise modal

- [ ] **Exercise Details Screen**
  - [ ] Exercise name displays as title
  - [ ] Exercise image/video loads and displays
  - [ ] "Watch tutorial" button functional (plays mock video)
  - [ ] "Change rest time" button opens modal with preset times
  - [ ] Set history displays timestamped entries
  - [ ] "+ Add Set" floating button always visible
  - [ ] "Quick Tip" text visible (gray, informational)

**Set Logging**
- [ ] **Add Set Modal**
  - [ ] Modal slides up from bottom (300ms)
  - [ ] Reps field auto-focused (black border, keyboard appears)
  - [ ] Tap field and type: "8" (reps)
  - [ ] Weight field functional: "185" (weight kg)
  - [ ] -/+ buttons change values by 1 (reps) or 2.5 (weight)
  - [ ] Optional fields collapsed initially
  - [ ] Tap "RIR" expands, shows 4 buttons (0, 1, 2, 3+)
  - [ ] Tap "Tempo" expands, shows 3 buttons (Normal, Slow Eccentric, Paused)
  - [ ] "Add Notes" button functional (text input appears)
  - [ ] "Record Set" button disabled (gray) until both fields filled
  - [ ] Number pad visible below (digits 0-9 + clear)
  - [ ] X button (top-right) closes modal without saving

- [ ] **Set Recording**
  - [ ] Tap "Record Set" (when enabled)
  - [ ] Modal closes (fade-out 200ms)
  - [ ] Set added to history
  - [ ] Rest timer starts automatically
  - [ ] Toast "Set recorded" appears (optional)

**Rest Timer**
- [ ] **Rest Timer Pill**
  - [ ] Appears floating (bottom-right)
  - [ ] Loading circle (left) visible
  - [ ] Countdown display (center): "3:00" → "0:00"
  - [ ] Updates every second (countdown visible)
  - [ ] "Next Set" text visible (right)
  - [ ] Three dots menu (options: skip, extend, adjust)
  - [ ] X button closes pill
  - [ ] Timer can be dragged (iOS) or repositioned (optional)
  - [ ] When 0:00 reached: haptic feedback, circle refills
  - [ ] User can tap "+ Add Set" while timer running
  - [ ] Timer persists if screen transitions

---

### Phase 3: Nutrition System

**Food Logging**
- [ ] **Food Logger Screen**
  - [ ] "Today" dropdown visible (center-top)
  - [ ] Circular progress ring displays
  - [ ] Center shows "Remaining" calories
  - [ ] Left shows "Goal", right shows "Eaten"
  - [ ] Progress fills as meals added
  - [ ] Macro bars display (Protein, Carbs, Fat, Fiber)
  - [ ] Protein bar emphasized (larger)
  - [ ] Meals list shows in reverse chronological order (newest first)
  - [ ] Meal entries show: name, timestamp, macros, calories
  - [ ] Edit button visible on each meal (optional)
  - [ ] "+ Add Food" floating button (blue, bottom-right)

**Date Selection**
- [ ] **Date Picker Modal**
  - [ ] Tap "Today" dropdown → modal slides up
  - [ ] Calendar grid displays (SUN-SAT columns)
  - [ ] Today's date highlighted (blue circle)
  - [ ] Month/year visible (top)
  - [ ] Left/right arrows for previous/next month
  - [ ] Tap date → selects it
  - [ ] Food Logger updates with new date's meals
  - [ ] Modal closes on selection

**Food Search & Add**
- [ ] **Add Food Screen**
  - [ ] Back arrow navigates back
  - [ ] Search bar functional, filters in real-time
  - [ ] "All" tab shows database foods
  - [ ] "My Foods" tab shows custom foods
  - [ ] History section shows recently logged foods
  - [ ] All section shows database foods
  - [ ] Tap "+ Add" → food added to meals
  - [ ] Toast "Food is added" appears
  - [ ] Can add multiple foods without returning
  - [ ] Scale icon visible (no function, Phase 1)

**Custom Food Creation**
- [ ] **Create Custom Food**
  - [ ] Tap "+ Create" in My Foods section
  - [ ] Form appears: Name, Calories, Protein, Carbs, Fat
  - [ ] Fill in fields (e.g., "Protein Shake", 250, 30, 10, 5)
  - [ ] Save button enabled when all fields filled
  - [ ] Tap "Save" → custom food added to My Foods list
  - [ ] Custom food appears in list with checkmark icon

---

### Phase 4: AI Coach

**Chat Interface**
- [ ] **AI Coach Screen**
  - [ ] Hamburger menu (top-left) clickable
  - [ ] "AI Coach" title visible (center)
  - [ ] "New Chat" button (top-right) creates new conversation
  - [ ] Message area shows messages
  - [ ] User messages: right-aligned, dark bubble
  - [ ] AI messages: left-aligned, light bubble
  - [ ] Timestamps visible on messages
  - [ ] Empty state: "What can I help with?" text + optional buttons
  - [ ] Input field: "Ask anything" placeholder
  - [ ] Send icon (right, black) appears on typing
  - [ ] "+" button (left) for file upload

**Messaging**
- [ ] **Type & Send Message**
  - [ ] Tap input field, keyboard appears
  - [ ] Type: "Should I deload?"
  - [ ] Text appears in input
  - [ ] Send icon becomes enabled (dark)
  - [ ] Tap send icon
  - [ ] Message appears in chat (right-aligned)
  - [ ] Input clears
  - [ ] Loading brief shows
  - [ ] AI response appears (left-aligned) after ~500ms
  - [ ] Continue conversation naturally

**Chat History**
- [ ] **Hamburger Menu**
  - [ ] Tap hamburger icon
  - [ ] Sidebar slides in from left (300ms)
  - [ ] "Chat History" visible
  - [ ] List of past chats (or empty if first chat)
  - [ ] Tap chat → loads that conversation
  - [ ] "+ New Chat" button creates new chat
  - [ ] Sidebar closes (slide-left) when selecting chat
  - [ ] Swipe left to close sidebar

---

### Phase 5: Profile & Settings

**Profile Management**
- [ ] **Profile Sidebar**
  - [ ] Tap profile icon (any screen)
  - [ ] Sidebar slides in from left (300ms)
  - [ ] User name visible (top)
  - [ ] Settings icon visible (top-right)
  - [ ] Menu items: Profile, Uploads, Measurements, etc.
  - [ ] Tap menu item → navigates to screen
  - [ ] Tap outside sidebar → closes (swipe also works)

- [ ] **Profile Screen**
  - [ ] Back arrow visible
  - [ ] Profile picture (circle, center)
  - [ ] Editable fields: Name, Email, Height, Weight, etc.
  - [ ] Tap field → focus (keyboard appears)
  - [ ] Edit values
  - [ ] Tap elsewhere → auto-saves
  - [ ] Toast "Profile updated" (optional)

**Measurements**
- [ ] **Measurements Screen**
  - [ ] Back arrow visible
  - [ ] "Add Measurements" button prominent
  - [ ] Empty state or timeline of entries
  - [ ] Tap "Add Measurements" → form modal
  - [ ] Form has 13 fields (Neck, Shoulders, Chest, etc.)
  - [ ] Fill in measurements
  - [ ] Save → added to timeline
  - [ ] Timeline shows entries newest-first
  - [ ] Can tap entry to expand details

**Integrations**
- [ ] **Integrations Screen**
  - [ ] Back arrow visible
  - [ ] Grid of integration cards (Apple Health, Whoop, etc.)
  - [ ] Each card shows: icon, name, "Connect" button
  - [ ] Tap "Connect" → native permission dialog (iOS/Android)
  - [ ] After "Allow": card shows "Connected ✓" + last synced time
  - [ ] "Sync Now" button functional (brief sync animation)
  - [ ] "Disconnect" button works (resets to "Connect")

---

### Phase 6: Uploads & Files

**Uploads Screen**
- [ ] **View Uploads**
  - [ ] Back arrow visible
  - [ ] "Upload Report" button prominent
  - [ ] Empty state or list of uploads
  - [ ] Each upload: thumbnail, name, date, delete button

- [ ] **Upload File**
  - [ ] Tap "Upload Report"
  - [ ] File picker opens (Camera, Photo Library, Files)
  - [ ] Select file
  - [ ] Returns to Uploads screen
  - [ ] New file appears in list
  - [ ] Toast "Report uploaded"

---

### Phase 7: Help & Feedback

**FAQs**
- [ ] **Help Screen**
  - [ ] "FAQs" card clickable
  - [ ] "Contact Form" card clickable
  - [ ] Tap FAQs → navigates to FAQs screen

- [ ] **FAQs Screen**
  - [ ] Back arrow visible
  - [ ] Accordion list of questions
  - [ ] First question expanded by default
  - [ ] Tap question → toggle expand/collapse
  - [ ] Chevron icon rotates (down when expanded, up when collapsed)

**Contact Form**
- [ ] **Contact Form Screen**
  - [ ] Back arrow visible
  - [ ] "Select Subject" dropdown
  - [ ] Textarea "How can we help you?"
  - [ ] "Add Screenshot" file upload (optional)
  - [ ] Checkbox "I agree to be contacted"
  - [ ] "Submit" button (gray initially)
  - [ ] Fill all required fields
  - [ ] Submit button becomes enabled (dark)
  - [ ] Tap Submit → toast "Thank you for contacting us"

**Feedback**
- [ ] **Feedback Screen**
  - [ ] Back arrow visible
  - [ ] Textarea for feedback
  - [ ] "Add Screenshot" optional
  - [ ] Submit button (gray→dark when ≥10 chars)
  - [ ] Tap Submit → toast "Thank you for your feedback"

---

## Performance Testing

### Launch Performance

```bash
# Measure app startup time
flutter run --profile
# Expected: < 2 seconds to home screen
```

### Screen Transitions

| Transition | Target | Status |
|-----------|--------|--------|
| Back arrow | < 200ms | ✅ Verify smooth animation |
| Tab switch | < 200ms | ✅ Verify no stutter |
| Modal open | < 300ms | ✅ Verify smooth slide-up |
| List scroll | 60 FPS | ✅ Verify no jank |
| Image load | < 500ms | ✅ Verify no blank space |

### Database Performance

```dart
test('1000 sets load in < 500ms', () async {
  // Measure query performance
  final stopwatch = Stopwatch()..start();
  final sets = await db.getSets(exerciseId: 'bench_1');
  stopwatch.stop();
  expect(stopwatch.elapsedMilliseconds, lessThan(500));
});
```

---

## Memory & Storage Testing

### Memory Usage

**iOS:**
- Expected: < 100MB at startup
- Expected: < 200MB with 1000 meals logged
- Measure via Xcode Memory Debugger

**Android:**
- Expected: < 120MB at startup
- Expected: < 220MB with 1000 meals logged
- Measure via Android Studio Profiler

```bash
# Android memory profiling
adb shell dumpsys meminfo com.chrug.app
```

### Storage Usage

- Expected: < 200MB app size (iOS .ipa + Android .apk)
- Documents directory: < 100MB for typical user data
- Cache: Auto-cleaned, < 50MB

---

## Network Testing

### Offline Verification

- [ ] **All features work offline:**
  - [ ] Launch app (no network)
  - [ ] Log sets → saved locally
  - [ ] Log meals → saved locally
  - [ ] Chat with AI → hardcoded responses work
  - [ ] View past data → all available offline
  - [ ] No error messages/crashes

- [ ] **Network Loss During Operation:**
  - [ ] Logging set mid-operation
  - [ ] Network disconnects mid-save
  - [ ] Data saved locally, no crash
  - [ ] User can continue

### Network Availability Detection

- [ ] **Connection Restored:**
  - [ ] No automatic sync (Phase 1)
  - [ ] No sync queue (Phase 1)
  - [ ] Data remains local

---

## UI/UX Testing

### Orientation Changes

- [ ] **Portrait → Landscape:**
  - [ ] All screens rotate correctly
  - [ ] No content cutoff
  - [ ] UI scales appropriately
  - [ ] Tabs/navigation accessible

- [ ] **Landscape → Portrait:**
  - [ ] Smooth transition
  - [ ] State preserved (scroll position, form input)

### Accessibility

- [ ] **Tap Targets:**
  - [ ] All buttons ≥ 44pt × 44pt
  - [ ] Input fields ≥ 44pt height
  - [ ] Measure with accessibility inspector

- [ ] **Text Contrast:**
  - [ ] All text ≥ 4.5:1 contrast ratio
  - [ ] Use Accessibility Inspector (iOS) or Accessibility Scanner (Android)

- [ ] **Font Sizes:**
  - [ ] Body text ≥ 16pt
  - [ ] Labels ≥ 12pt
  - [ ] Headings ≥ 18pt

### Dark Mode

- [ ] **Phase 1 Status:** Not implemented
- [ ] **Phase 2:** Add dark mode support (future)

---

## Data Integrity Testing

### Data Persistence

- [ ] **Restart App:**
  - [ ] Log set → restart app → set still there
  - [ ] Add meal → restart app → meal still there
  - [ ] Create program → restart app → program still there

- [ ] **Force Quit:**
  - [ ] Simulate app crash
  - [ ] Relaunch → all data intact
  - [ ] No data loss

### Database Validation

```dart
test('Database schema valid', () async {
  final db = await AppDatabase.create();
  
  // Verify tables exist
  expect(db.userCount() >= 0, isTrue);
  expect(db.setCount() >= 0, isTrue);
  expect(db.mealCount() >= 0, isTrue);
});
```

---

## Edge Case Testing

### Large Data Sets

- [ ] **1000+ Sets Logged:**
  - [ ] App loads without crashing
  - [ ] Scrolling is smooth (60 FPS)
  - [ ] Search/filter still fast (< 500ms)

- [ ] **1000+ Foods Logged:**
  - [ ] Daily totals calculate correctly
  - [ ] Meal list scrolls smoothly
  - [ ] No data corruption

- [ ] **Multiple Large Programs:**
  - [ ] Program switching instant
  - [ ] No data loss or mix-up

### Unusual Input

- [ ] **Special Characters:**
  - [ ] Program name: "Test™ Program (v2.0)"
  - [ ] Food name: "Café Au Lait"
  - [ ] Notes: "Max reps! 🎉"
  - [ ] No crashes, displays correctly

- [ ] **Very Large Numbers:**
  - [ ] Reps: 999
  - [ ] Weight: 999.9 kg
  - [ ] Calories: 99,999
  - [ ] Displays correctly, no truncation

- [ ] **Empty/Minimal Input:**
  - [ ] Program with no days
  - [ ] Day with no exercises
  - [ ] No data loss, sensible defaults

---

## Sign-Off Checklist

### Final Validation (Before Release)

- [ ] All 26 features tested on iOS emulator
- [ ] All 26 features tested on Android emulator
- [ ] All 6 screen orientations tested (portrait/landscape on 3 devices minimum)
- [ ] Performance targets met (all < target times)
- [ ] Memory usage < limits
- [ ] Storage usage < limits
- [ ] Offline functionality verified
- [ ] Data persistence verified
- [ ] No crashes on happy path
- [ ] No crashes on edge cases
- [ ] No console errors/warnings
- [ ] UI polished, no visual glitches
- [ ] Accessibility standards met
- [ ] All links functional (deep links, share, etc.)
- [ ] All buttons/inputs functional

### Sign-Off

```
Tested by: [Name]
Date: [Date]
Device Matrix: iOS [devices], Android [devices]
Coverage: 100% of 26 features
Crashes: 0
Blockers: None
Release Ready: ✅ YES / ❌ NO (list blockers)
```

---

## Post-Launch Monitoring

### App Store Monitoring

- [ ] **Crash Rate Dashboard**
  - [ ] Target: < 0.1% crash rate
  - [ ] Monitor via Sentry daily
  - [ ] Alert if > 0.5%

- [ ] **User Feedback**
  - [ ] Monitor ratings on App Store
  - [ ] Respond to critical reviews
  - [ ] Track feature requests

- [ ] **Performance Metrics**
  - [ ] Monitor via PostHog/Firebase
  - [ ] Set logging latency
  - [ ] Food search latency
  - [ ] Alert if degradation


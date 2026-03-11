# UI_BEHAVIOR_SPEC.md — Chrug MVP Phase 1

## Overview

This document specifies detailed interactive behavior, animation timings, state transitions, and edge case handling for all screens and components in Chrug MVP Phase 1.

---

## Interaction Patterns & Behavior

### Global Patterns

#### **Button State Machine**
All buttons follow this state pattern:
- **Default** (enabled, tappable)
  - Background: dark navy/black
  - Text: white
  - Opacity: 1.0
  - Tap feedback: haptic feedback + animation scale (0.95x)

- **Disabled** (not tappable)
  - Background: light gray (#E0E0E0)
  - Text: medium gray (#999999)
  - Opacity: 0.5
  - Tap feedback: none

- **Loading** (processing)
  - Background: dark navy/black
  - Animation: subtle pulsing (opacity 0.8 → 1.0, repeat 0.5s)
  - Tap feedback: disabled during loading
  - Optional: show small spinner left of text

- **Pressed** (during tap)
  - Scale: 0.95x
  - Duration: 100ms
  - Haptic: light impact feedback

#### **Form Field Behavior**
- **Default state**
  - Border: light gray (#D0D0D0), 1pt
  - Background: white
  - Text: dark (#333333)
  - Placeholder: medium gray (#999999)

- **Active (focused)**
  - Border: dark navy (#001F3F), 2pt
  - Background: white
  - Cursor visible
  - Placeholder: fades out

- **Filled**
  - Border: dark navy (#001F3F), 2pt
  - Background: white
  - Text: dark (#333333)

- **Error**
  - Border: red (#E63946), 2pt
  - Background: light red (#FFE5E5)
  - Error message appears below field
  - Text: red (#E63946)

- **Success**
  - Border: green (#06A77D), 1pt
  - Background: light green (#E8F5F0)
  - Optional: checkmark icon right

#### **Modal & Bottom Sheet Behavior**

**Fade-In Animation:**
- Duration: 300ms
- Curve: ease-in-out
- Background overlay: transparent → semi-transparent black (0.4)
- Content opacity: 0 → 1

**Slide-Up Animation (Bottom Sheet):**
- Duration: 300ms
- Curve: ease-out
- Content translates: +500pt (bottom) → 0 (final position)
- Happens simultaneously with fade-in

**Fade-Out Animation (Close):**
- Duration: 200ms
- Curve: ease-in
- Background overlay: semi-transparent black → transparent
- Content opacity: 1 → 0

**X Button Behavior:**
- Always top-right corner (thumb-optimized)
- Size: 44x44pt (tap target)
- Icon: "×" or "✕" (standard)
- Tap: close modal, discard unsaved data (no confirmation)

#### **List Scrolling Behavior**
- **Momentum scrolling** enabled
- Deceleration rate: normal (default iOS)
- **Pull-to-refresh** disabled (Phase 1)
- **Scroll indicator** visible (right edge, gray)
- **Fade edges** at top/bottom (optional, subtle)

---

## SCREEN-BY-SCREEN BEHAVIOR

---

## AUTH STACK

### **SplashScreen**
**Behavior:**
- Display for exactly 2-3 seconds (randomized between 2s and 3s)
- No user interaction (all taps ignored)
- Background: solid black (#000000)
- Dumbbell icon: white, centered, no animation
- After delay: auto-navigate based on auth state (no fade/transition, instant)

**Edge Cases:**
- User force-quits app during splash → on relaunch, splash shows again
- If splash duration exceeds 3s → no timeout, continues waiting
- No network available → splash still displays, auto-navigate happens (no network check)

---

### **FirstTimeUserScreen**

**Visual State:**
- Profile icon (top-left): light gray circle with person icon
- Notification bell (top-right): light gray, disabled (appears grayed out)
- "Login or Signup!" text: underlined, tappable
- "Create New Program" card: white, rounded, shadow
- "How to get started?" section: bottom, with dumbbell illustration
- Bottom bar: fully visible and functional

**Behavior:**

**Tap "Login or Signup!"**
- Instant fade transition (200ms)
- Navigate to SignupScreen
- "Login or Signup!" text changes color briefly (visual feedback) before transition

**Tap "Create New Program"**
- Bottom sheet modal slides up (300ms)
- Calls ProgramManagementStack/CreateProgramModal
- User can still see FirstTimeUserScreen behind semi-transparent overlay

**Tap "Watch Video"**
- Opens video player (modal or full-screen)
- Video: mock video, 56 seconds total
- Controls: play/pause, timeline scrubber, time display
- Back arrow (top-left) closes video

**Tap Profile Icon (top-left)**
- Toast appears: "Please sign up to access profile"
- Or: navigates to FirstTimeUserScreen (no change, already here)

**Tap Notification Bell (top-right)**
- Toast appears: "Please sign up to view notifications"
- Or: button is disabled (visually grayed)

**Tap Bottom Bar Icons (AI Coach, Food Log)**
- Toast appears: "Please sign up to use this feature"
- OR: all bottom bar taps navigate to SignupScreen automatically

---

### **SignupScreen**

**Visual State:**
- Greek myth art background (high-quality, fills entire background)
- Dumbbell icon: white, centered
- "Continue with Apple" button: white background, black text, Apple logo left
- Divider: "or" text with horizontal lines
- Email input field: white, placeholder "example@mail.com"
- Black arrow button (right side of input): hidden by default, appears on typing

**Behavior:**

**Screen Load:**
- Background image loads (may show loading skeleton while loading)
- Buttons enabled immediately

**Tap "Continue with Apple"**
- Triggers native Apple Sign-In flow (iOS system UI)
- Loading spinner appears (brief moment)
- On success: auto-navigate to MainStack/WorkoutTab (no email verification needed for Apple)
- On cancel: return to SignupScreen (no error message)
- On failure: error toast "Sign-in failed. Try again."

**Email Input Focus:**
- Keyboard appears
- Input border turns dark (focus state)
- Email icon appears left of input (visual hint)
- Placeholder text fades

**Email Input Typing:**
- Real-time validation (optional, Phase 1 accepts any input):
  - If email is valid format → black arrow button appears right
  - If email is invalid → arrow button remains hidden OR appears grayed
- Text appears as typed
- Clear button ("×") may appear right of input to clear quickly

**Tap Black Arrow Button:**
- Input must have valid email format
- Button disables (grayed) during request
- Loading spinner in button (small, white)
- Back-end simulates 1-2 second delay
- On success: navigate to AccountVerificationScreen, pass email as prop
- On failure: error toast "Email not found" or "Error. Try again."

**Tap Back Arrow (top-left):**
- Navigate back to FirstTimeUserScreen
- Discard email input (no save)

**Keyboard Behavior:**
- Return key on keyboard: acts same as arrow button tap (submit email)
- Done key: acts same as arrow button tap

---

### **AccountVerificationScreen**

**Visual State:**
- Small shield icon (top)
- "Verify email" heading
- "Enter the 6 digits code we just sent you to example@mail.com" text
- 6 empty input fields (each ~40pt square)
- "Didn't receive the code? Resend or Edit email" link (bottom)
- Timer countdown: "You can request a new code in 00:30" (if resend was tapped)
- Loading spinner (when auto-submitting)

**Behavior:**

**Field Focus & Auto-Advance:**
- First field auto-focuses on screen load (keyboard visible)
- Each field accepts only 1 digit (0-9)
- On digit entry: automatically moves focus to next field
- Visual feedback: field border darkens on entry
- Backspace on empty field: moves focus back to previous field (standard iOS behavior)

**Auto-Submit on 6 Digits:**
- When all 6 fields filled: automatic 500ms delay, then submit
- Loading spinner appears center
- Keyboard dismisses
- Submit button disabled (though no visible submit button)

**Verification Success:**
- Fields briefly highlight green
- Loading spinner shows "✓" checkmark (1s animation)
- Auto-navigate to MainStack/WorkoutTab (200ms fade transition)
- Email address is now registered, user is authenticated

**Verification Failure:**
- Fields highlight red
- Error message appears: "Invalid code. Try again."
- Toast: "Code is invalid"
- Fields clear to empty
- Focus returns to first field
- Keyboard may remain visible

**Failed Attempts Counter:**
- After 3 failed attempts: "Edit email" link becomes visible/enabled
- User can tap "Edit email" to change email address
- Resend timer also becomes visible after 1st attempt

**Tap "Resend" Link:**
- Link text changes to grayed (disabled) during cooldown
- 30-second countdown timer displays: "You can request a new code in 00:30"
- Timer counts down: 00:29, 00:28, ... 00:01, 00:00
- When timer reaches 0: "Resend" link becomes active (blue) again
- Tapping "Resend": simulates sending new code, resets timer to 30 seconds
- Toast: "Code sent to example@mail.com"

**Tap "Edit email" Link:**
- Navigate back to SignupScreen
- Email field pre-filled with previous email
- Allow user to change email
- On resubmit: new verification code sent, return to AccountVerificationScreen with new email

**Tap Back Arrow:**
- Navigate back to SignupScreen
- Fields retain input (optional: clear or retain for convenience)

**Keyboard Behavior:**
- Number pad keyboard (iOS default)
- Return/Done key: acts like 6th digit (if fields are filled, submits)

**Edge Cases:**
- User enters digit in field, then taps in another non-sequential field → focus jumps to that field, paste mode disabled
- User copy-pastes all 6 digits at once → accepted, auto-submit triggered
- User taps field multiple times → rapid focus changes (normal behavior)
- Network is unavailable → verification may timeout, error toast "Network error"

---

## MAIN STACK - WORKOUT TAB

### **WorkoutDaysScreen**

**Visual State:**
- Profile icon (top-left, gray circle): tappable, opens ProfileSidebar
- Program name displayed (center top)
- Notification bell (top-right): tappable, shows notification count if > 0
- Share icon (paper plane, top-right): tappable, opens iOS share sheet
- "Change Program >" link (right of program name)
- Full-width day cards (scrollable list)
  - Each card: day name + dumbbell icon + sets completed (optional badge)
  - Card shadow: subtle drop shadow
  - Card tap: navigate to WorkoutDayScreen

**Behavior:**

**Screen Load:**
- Program data loads from local SQLite
- Day list populates immediately (no loading spinner)
- If no program selected: show empty state with "Create New Program" card prominent

**Pull-to-Refresh:**
- Disabled in Phase 1 (no backend sync)

**Tap Day Card:**
- Card briefly highlights (scale 1.02x, 100ms)
- Haptic feedback: light impact
- Navigate to WorkoutDayScreen with dayId
- Smooth push transition (200ms slide from right)

**Tap "Change Program >":**
- Full-screen modal appears (fade-in 300ms)
- Shows ChangeProgramModal
- Overlay dims background (semi-transparent black, 0.4)

**Tap Profile Icon (top-left):**
- Sidebar slides in from left (300ms)
- ProfileSidebar overlay appears
- Tap outside sidebar: closes it (swipe gesture also works)

**Tap Notification Bell:**
- Navigate to NotificationsScreen
- Notification count badge clears (if visible)

**Tap Share Icon:**
- iOS native share sheet slides up from bottom
- Share options: Messages, Mail, AirDrop, Copy Link, etc.
- Program name + deep link pre-filled
- User selects option or taps Cancel to dismiss

**Add Workout Day (Floating Button):**
- "Create New Program" appears if no days exist
- OR "Add Day" floating button if days exist
- Tap: shows add day form or creates new day
- New day auto-named "Day N" (where N = next number)

**Empty State:**
- If no program selected: "Login or Signup!" heading + "Create New Program" card
- Tap card: same as "Create New Program" from sidebar

**Long-Press Day Card (Optional):**
- Menu appears: Edit, Delete, Share, Duplicate
- Delete confirmation: "Are you sure? This can't be undone."
- Edit: inline rename modal

---

### **WorkoutDayScreen**

**Visual State:**
- Back arrow (top-left): navigate back to WorkoutDaysScreen
- "Day 1" title (center)
- "rename day?" link (right): tappable, opens rename modal
- "Start your workout!" heading
- "Click on an exercise to start instantly" subtitle (gray, small)
- Full-width exercise cards (scrollable)
  - Each card: exercise name (left), last set info (right), up/down arrows (right)
  - Card tap: navigate to ExerciseDetailsScreen
- Floating black "+ Add Exercise" button (bottom-right)

**Behavior:**

**Screen Load:**
- Day data + exercises load from SQLite
- Cards populate immediately
- Up/down arrow handles appear on hover (iOS: always visible)

**Tap Exercise Card:**
- Card briefly highlights (opacity 0.8, scale 1.02x)
- Haptic feedback: light impact
- Navigate to ExerciseDetailsScreen with exerciseId
- Smooth push transition (200ms)

**Tap "rename day?" Link:**
- Small text input modal appears (or inline edit)
- Current name pre-filled
- User edits name: "Day 1" → "Push Day"
- Tap outside or Done key: save name to SQLite
- Title updates: "Day 1" → "Push Day"
- Toast: "Day renamed"

**Drag Exercise Card (Reorder):**
- Long-press exercise card → card brightens (opacity 1.0, slight scale)
- Drag vertically → card follows finger
- Visual feedback: card elevates slightly (shadow increases)
- Release → card snaps to new position
- Animation: smooth snap (150ms)
- Order updates in SQLite
- Toast: "Exercise reordered"

**Up/Down Arrow Buttons (Reorder Alternative):**
- Tap up arrow: move exercise up 1 position (immediate)
- Tap down arrow: move exercise down 1 position (immediate)
- Animation: cards swap smoothly (150ms)
- Top exercise: up arrow disabled (grayed)
- Bottom exercise: down arrow disabled (grayed)

**Tap "+ Add Exercise" Button:**
- Full-screen modal appears (fade-in 300ms)
- SelectExerciseModal opens
- User selects exercises, taps "Next"
- Modal closes
- New exercises added to bottom of list
- Toast: "Exercise added"

**Swipe Right on Exercise Card (Optional):**
- Reveals "Edit" button (optional, Phase 1 may skip)
- Tap Edit: can change set scheme (e.g., sets × reps)

**Swipe Left on Exercise Card (Optional):**
- Reveals "Delete" button
- Tap Delete: confirmation modal "Remove this exercise?"
- Confirm: exercise removed from list
- Toast: "Exercise removed"

**Back Arrow:**
- Navigate back to WorkoutDaysScreen
- No data loss (data auto-saved on each change)

**Empty State:**
- If day has no exercises: large "+" button with text "Add your first exercise"
- Tap button: same as "+ Add Exercise" floating button

---

### **ExerciseDetailsScreen**

**Visual State:**
- Back arrow (top-left): navigate back to WorkoutDayScreen
- Exercise name (title, center)
- Exercise image/video (full-width, aspect ratio maintained)
  - Play button overlay (if video)
- "Change rest time" button (left, clock icon)
- "Watch tutorial" button (right, video icon)
- Gray tip text: "Quick Tip: Swipe set to the right to repeat it and to the left to delete it!"
- Set history (organized by date):
  - "Today" section header (gray)
  - Set entries: timestamp + reps + weight
  - Swipe left: delete icon appears
  - Swipe right: duplicate icon appears
- Floating black "+ Add Set" button (bottom-right)

**Behavior:**

**Screen Load:**
- Exercise image loads (skeleton loader while loading)
- Set history populates from SQLite
- Rest timer state persists (if already active from previous set)

**Tap Exercise Image/Video:**
- If image: full-screen image viewer opens (tap image to dismiss)
- If video: video player modal opens (play/pause, timeline, fullscreen)

**Tap "Watch Tutorial" Button:**
- Opens mock tutorial video
- Video player: play/pause, timeline, 60 seconds total mock video
- Close: tap back arrow or X button

**Tap "Change rest time" Button:**
- RestTimeModal appears (sliding up)
- Preset options: 30, 45, 60, 90, 120, 180 seconds
- OR custom input
- User selects: e.g., "120"
- Modal closes
- Global rest time preference updated (persists for future sessions)

**Tap "+ Add Set" Button:**
- AddSetModalSheet slides up from bottom (300ms)
- Reps field auto-focused (black border)
- Keyboard appears
- User enters reps + weight
- (See AddSetModalSheet behavior below)

**Set History - Swipe Left:**
- Set card slides left
- Delete icon appears (red, trash can)
- Tap delete: confirmation "Remove this set?"
- Confirm: set removed from history
- Toast: "Set removed"
- Swipe back to reset card

**Set History - Swipe Right:**
- Set card slides right
- Duplicate icon appears (blue, copy icon)
- Tap duplicate: new AddSetModalSheet opens
- Reps/Weight pre-filled from original set
- User can edit and record
- Original set remains in history

**Set History - Tap to Expand (Optional):**
- Tap set entry: shows expanded details
  - Reps, Weight, RIR (if set), Tempo (if set), Notes (if set)
- Tap elsewhere: collapse

**Rest Timer Pill (if running):**
- Appears floating at bottom
- Visual: loading circle (left) + countdown (center) + "Next Set" text (right)
- Countdown updates every second
- When 0:00: haptic feedback + optional sound alert
- X button to close pill

**Back Arrow:**
- Navigate back to WorkoutDayScreen
- Rest timer state persists (if active, continues in background)

---

### **AddSetModalSheet**

**Visual State:**
- Drag handle (top center)
- X button (top-right)
- "Repetitions & Weight" title
- Reps field: "4 rep" with -/+ buttons
- Weight field: "10 kg" with -/+ buttons
- "Optional" section (collapsible):
  - Reps in Reserve: 4 bubble buttons (0, 1, 2, 3+)
  - Tempo Variation: 3 bubble buttons (Normal, Slow Eccentric, Paused)
- "Add Notes" button (left side)
- "Record Set" button (large, center, dark blue/black)
- Number pad (below, for quick digit entry)

**Behavior:**

**Modal Slide-In:**
- Slides up from bottom (300ms, ease-out)
- Background dims slightly
- Reps field auto-focuses (black border, keyboard appears)

**Reps Field:**
- Initial value: empty OR last set reps (user preference)
- -/+ buttons: decrement/increment by 1
- Keyboard entry: only numeric input (0-9)
- Tap field: black border, cursor visible, keyboard appears
- Max value: 999 (theoretical, no hard limit in Phase 1)
- Min value: 0 (allowed, no validation)

**Weight Field:**
- Initial value: empty OR last set weight (user preference)
- -/+ buttons: decrement/increment by 2.5 (or by 1 lb, depending on unit)
- Tap field: black border, cursor visible, numeric keyboard
- Unit: "kg" or "lbs" (based on user setting, displayed next to field)
- Decimal allowed (e.g., "185.5 kg")

**Reps in Reserve (Optional Expansion):**
- Heading: "How many reps left in the tank?"
- 4 bubble buttons: 0, 1, 2, 3+
- Tap bubble: fills with dark color (selected state)
- Only 1 can be selected at a time
- If no selection: RIR is undefined (optional field)

**Tempo Variation (Optional Expansion):**
- Heading: "Tempo Variation"
- 3 bubble buttons: Normal, Slow Eccentric, Paused
- Tap bubble: fills with dark color (selected state)
- Only 1 can be selected at a time
- If no selection: Tempo is undefined (optional field)

**Add Notes Button:**
- Tap: text input appears (or expands from button)
- Placeholder: "Add notes for this set"
- User types: "Felt strong", "Paused 2s at bottom", etc.
- Text stored with set metadata

**Record Set Button:**
- Disabled (grayed) if Reps OR Weight is empty
- Enabled (dark blue/black) if both Reps and Weight are filled
- Tap (when enabled):
  - Loading animation briefly shows (spinner or pulsing)
  - Modal slides down (fade-out 200ms)
  - Set added to local SQLite
  - Toast: "Set recorded" (optional)
  - RestTimerPill auto-starts

**Number Pad:**
- Visible below form
- Digits 0-9, clear button
- Tap digit: enters into active field (Reps or Weight)
- Tap Clear: clears active field

**Modal Close (X Button or Tap Outside):**
- Modal slides down (fade-out 200ms)
- Form data discarded (no save)
- Toast: none

**Keyboard Behavior:**
- Return key: acts like "Record Set" tap (if both fields filled)
- Backspace: standard delete behavior
- Tab key: moves focus to next field (Reps → Weight)

**Edge Cases:**
- User enters "0" for reps → allowed, set recorded
- User enters "0" for weight → allowed, set recorded
- User enters non-numeric in Weight field → rejected or auto-corrected
- User enters very large number (999999) → accepted (Phase 1 no validation)
- User taps Record while form is processing → button disabled until complete

---

### **RestTimerPill** (Floating UI)

**Visual State:**
- Small pill-shaped container (bottom center/right)
- Left side: circular loading indicator (fills in reverse as timer counts down)
- Center: countdown display "3:00" (white text)
- Right side: "Next Set" text (small, gray)
- Three dots menu (top-right of pill): options menu
- X button (top-right or corner): close pill

**Behavior:**

**Timer Start:**
- Appears automatically after "Record Set" is tapped
- Default duration: 180 seconds (3:00) OR user's selected rest time
- Timer begins countdown immediately

**Countdown Display:**
- Updates every second: 3:00 → 2:59 → 2:58 → ... → 0:01 → 0:00
- Text color: white (readable against dark background)
- Format: M:SS (1:30, 0:45, etc.)

**Loading Circle:**
- Circular progress indicator (left side)
- Fills in reverse: starts full, empties as time passes
- Color: light gray or white
- Rotation: smooth continuous, completes 1 full rotation per timer duration

**When Timer Reaches 0:00:**
- Visual: circle fully depletes, circle fills back to full (reset animation)
- Haptic: strong haptic feedback (notification pattern)
- Sound: optional bell/chime sound (muted by default in Phase 1)
- Text: "Rest complete!" (optional, brief message)
- "Next Set" button highlighted or changes color (optional visual cue)

**Tap "Next Set" Text:**
- Navigates back to "+ Add Set" form (or focuses on form)
- Timer pill remains visible (can continue timer in background)
- User can record next set immediately

**Three Dots Menu (Options):**
- Tap: menu pops up
- Options:
  - Skip: closes timer, clears pill
  - Extend: adds 30 seconds to remaining time (shows confirmation: "Extend rest?")
  - Adjust: opens time picker modal, allows changing total duration
  - Cancel: closes menu, pill remains

**X Button (Close):**
- Closes pill immediately
- Timer stops (no background continuation)
- User can tap "+ Add Set" to continue workout

**Drag Pill:**
- Pill may be draggable (iOS standard) to reposition if desired
- OR fixed position (bottom-right corner)

**Persist State:**
- If user navigates away (back to WorkoutDayScreen): timer may continue in background
- If user returns to ExerciseDetailsScreen: timer resumes where it left off
- OR timer pauses when screen loses focus (implementation choice)

**Background Behavior:**
- User can use other parts of app while timer runs
- Pill floats on top of all other UI
- Taps outside pill go through to underlying UI (careful interaction design)

---

### **Rename Day Modal** (Inline or Popup)

**Visual State:**
- Small white modal (center of screen)
- Title: "Rename day"
- Text input: current day name pre-filled
- Cancel button (left, gray)
- Save button (right, dark blue/black)

**Behavior:**

**Input Field:**
- Auto-focused on open (black border, cursor visible, keyboard appears)
- Current text: "Day 1" → user can edit
- Max length: 20 characters (optional validation)

**Tap Save:**
- Input validated (must not be empty)
- Modal closes (fade-out 200ms)
- Day name updates in SQLite
- WorkoutDayScreen title updates: "Day 1" → new name
- Toast: "Day renamed"

**Tap Cancel:**
- Modal closes (fade-out 200ms)
- No changes saved
- Return to previous state

**Keyboard Behavior:**
- Return key: saves (same as Save button)
- Escape key: cancels (same as Cancel button)

---

## MAIN STACK - AI COACH TAB

### **AiCoachScreen**

**Visual State:**
- Hamburger menu icon (top-left): 3 horizontal lines
- "AI Coach" title (center)
- "New Chat" button (top-right)
- Chat message area (center, scrollable)
  - User messages: right-aligned, dark bubble, white text
  - AI messages: left-aligned, light bubble, dark text
  - Timestamps: small gray text, below message
  - Optional: user avatar (small circle) on user messages
  - Optional: AI avatar on AI messages
- Empty state (if no messages): "What can I help with?" heading + optional quick action buttons
- Input area (bottom):
  - "+" icon (left): file upload
  - Text input: "Ask anything" placeholder
  - Send icon (right, black, appears on typing): tappable

**Behavior:**

**Screen Load:**
- Chat messages load from local SQLite (for current chat)
- If new chat: empty message list, empty state displayed
- Scroll position: auto-scroll to bottom (latest message)

**Tap Hamburger Menu (top-left):**
- Sidebar slides in from left (300ms)
- ChatHistorySidebar appears
- Overlay dims background
- List of past chats shown (or empty if no history)

**Tap "New Chat" Button (top-right):**
- Current chat closes
- Message list clears
- New chat ID generated
- Empty state displayed: "What can I help with?"
- Focus: input field is ready for typing

**Type in Input Field:**
- Text appears as typed
- Send icon appears (or becomes enabled)
- Optional: input field height may expand if text wraps

**Tap Send Icon:**
- Input text is captured
- Message added to list (right-aligned, dark bubble)
- Input field clears
- Keyboard may dismiss (depending on implementation)
- Scroll auto-adjusts to show new message
- Loading indicator appears briefly
- AI response message appears (left-aligned, light bubble) after ~500ms delay (mock)
- Toast: none (message appears in chat naturally)

**Scroll Behavior:**
- Messages appear in chronological order (oldest top, newest bottom)
- Auto-scroll to bottom when new message arrives
- User can scroll up to see older messages (doesn't auto-scroll to bottom until new message)

**Tap "+" Button (file upload):**
- FileUploadModal slides up from bottom (300ms)
- Three tabs: Camera, Photo Library, Files
- User selects file
- Modal closes
- File preview appears in chat (above input field)
- User can delete preview (tap X on preview)
- User can add text + send with file: "What do you think of this?" [image] [send]

**Tap Past Chat (from sidebar):**
- Sidebar closes (slide-left, 300ms)
- Current chat closes
- Past chat messages load from SQLite
- Message list populated
- Auto-scroll to bottom (latest message in that chat)

**Long-Press Message (Optional):**
- Context menu appears: Copy, Delete, etc.
- Copy: message text copied to clipboard
- Delete: confirmation "Delete this message?", then remove from SQLite

**Empty State Behavior:**
- Shows when chat has no messages
- Optional quick action buttons: "Should I deload?", "How am I doing?", etc.
- Tap button: pre-fills input field with that question
- User can edit or send as-is

---

### **ChatHistorySidebar**

**Visual State:**
- Slide-out overlay from left (300ms, ease-out)
- White panel (full height, ~70% width of screen)
- Top bar: back arrow (or X button) + "Chat History" (or nothing)
- Chat list (scrollable):
  - Each chat: title (or first message text, truncated) + timestamp
  - Optional: last message preview (gray, small)
- "+ New Chat" button (bottom of sidebar)
- Tap outside or swipe left: closes sidebar

**Behavior:**

**Sidebar Open:**
- Overlay fade-in (background dims to semi-transparent black, 0.4)
- Slide-in animation (300ms, ease-out)
- List of past chats populated from SQLite (or empty if first chat)

**Tap Chat in List:**
- Sidebar closes (slide-left, 300ms, ease-in)
- Previous chat data unloads
- Selected chat messages load
- AiCoachScreen displays new chat

**Tap "+ New Chat" Button:**
- Current chat unloads
- New chat ID generated
- Sidebar closes
- Empty state displayed
- AiCoachScreen ready for new message

**Tap Back/X Button (close sidebar):**
- Sidebar slides left (300ms, ease-in)
- Overlay fades out
- Background reveals AiCoachScreen
- Current chat remains visible

**Swipe Left on Sidebar:**
- Sidebar slides left
- Same behavior as back button

**Swipe Left on Chat Item (Optional):**
- Chat item slides left
- Delete button appears (red)
- Tap delete: confirmation "Delete this chat?", then remove from SQLite and list
- Chat list updates

**Long-Press Chat Item (Optional):**
- Context menu: Rename, Delete, etc.
- Rename: inline input for chat title
- Delete: confirmation, then remove

---

### **FileUploadModal**

**Visual State:**
- Bottom sheet modal (half-screen, slide-up 300ms)
- Drag handle (top center)
- X button (top-right)
- "Upload" title (or "Choose File")
- Tabs: "Camera" | "Photo Library" | "Files"
- Tab content area (changes based on selected tab)
- "Cancel" button (left, gray)
- "Select" button (right, gray by default)

**Behavior:**

**Modal Open:**
- Slides up from bottom (300ms, ease-out)
- First tab ("Camera") is active by default
- Content shows camera icon with text "Take a photo"

**Tap "Camera" Tab:**
- Content switches to camera capture UI
- Button: "Take Photo" (or camera icon)
- Tap button: opens native camera app
- After photo taken: returns to modal with photo preview
- Photo ready to send

**Tap "Photo Library" Tab:**
- Content switches to photo picker
- Shows recent photos grid (or native photo picker UI)
- User taps photo: preview appears
- Photo ready to send

**Tap "Files" Tab:**
- Content switches to file browser
- Shows recent files or file list
- User taps file: preview appears (if supported)
- File ready to send

**Tap "Select" Button:**
- Only enabled if file is selected (otherwise grayed)
- Triggered: uploads file to chat (or adds to input)
- Modal closes (slide-down 200ms)
- File preview appears in AiCoachScreen input area
- File appears in chat after send

**Tap X Button or "Cancel":**
- Modal closes (slide-down 200ms)
- No file uploaded
- AiCoachScreen returns to normal state

---

## MAIN STACK - FOOD LOG TAB

### **FoodLoggerScreen**

**Visual State:**
- Profile icon (top-left, gray): tappable
- "Today" dropdown (center): shows current date, tappable
- Notification bell (top-right): tappable
- Circular progress ring (top, under header):
  - Center text: "Remaining" calories (large)
  - Left side: "Goal" (2,000 cal example)
  - Right side: "Eaten" (1,200 cal example)
  - Circle: fills as calories consumed (blue/green when on track, orange if over)
- Macro progress bars (under ring):
  - Protein (blue): filled %, number (e.g., 45g / 150g)
  - Carbs (yellow): filled %, number
  - Fat (green): filled %, number
  - Fiber (optional, red): filled %, number
- Meals list (scrollable):
  - "Today" section header (gray)
  - Meal entries in reverse chronological order (newest first)
    - Each meal: name + timestamp + macros + calories
    - Optional: individual food items listed under meal
  - Edit button (pencil icon, right side of meal)
- Floating blue "+ Add Food" button (bottom-right)

**Behavior:**

**Screen Load:**
- Selected date: Today (default)
- Meals load from SQLite for today
- Daily totals calculated and displayed
- Progress ring updates based on totals
- Macro bars fill based on totals

**Tap Date Dropdown ("Today"):**
- DatePickerModal slides up (300ms)
- Calendar view appears
- User selects different date
- Modal closes
- FoodLoggerScreen updates:
  - Date changes to selected date
  - Meals list updates (may be empty for past dates)
  - Progress ring/bars update (may show 0 if no meals logged)

**Tap Meal Entry:**
- Expands to show individual food items (if collapsed)
- OR navigates to EditMealScreen (optional)

**Tap Edit Button (meal):**
- EditMealScreen opens (optional, Phase 1 may not implement)
- User can edit foods in meal or remove meal

**Tap "+ Add Food" Button:**
- Navigates to AddFoodScreen
- User searches for food and adds
- Returns to FoodLoggerScreen
- New food(s) added to meals list
- Progress ring/bars update

**Progress Ring Behavior:**
- Circumference represents daily goal calories
- Blue fill: % of goal eaten
- Center text: remaining calories (Goal - Eaten)
- If Eaten > Goal:
  - Ring fills beyond 100% (extends past circle)
  - Text color changes to orange/red
  - Center text shows "Over by X calories"

**Macro Bars Behavior:**
- Each bar represents daily target (set in onboarding or default)
- Blue fill: % of target (proportional)
- Text: "X consumed / Y target"
- If consumed > target: bar color may change to orange
- Protein bar: emphasized (slightly larger, more prominent)

**Swipe Left on Meal Entry (Optional):**
- Meal card slides left
- Delete button appears (red, trash icon)
- Tap delete: confirmation "Delete this meal?", then remove from SQLite
- Meals list updates, progress ring/bars recalculate

**Long-Press Meal Entry (Optional):**
- Context menu: Edit, Delete, Duplicate
- Edit: EditMealScreen
- Delete: confirmation
- Duplicate: creates new meal with same foods (next meal, or manually place time)

**Meal Ordering:**
- Meals sorted by timestamp (newest first, reverse chronological)
- Time format: "12:45 PM" or "14:45" (based on system locale)

**Empty State:**
- If no meals logged for day: "No meals logged yet. Start adding food!"
- "+ Add Food" button still visible (primary action)

---

### **AddFoodScreen**

**Visual State:**
- Back arrow (top-left): navigate back
- "Add Food" title (center)
- Search bar: "Search or Create your own" placeholder, scale icon (right)
- Tabs: "All" (active) | "My Foods"
- List content (scrollable):
  - History section (if search empty, or tab = "All"):
    - "Recently logged" header
    - Food items (green checkmark, to indicate recent)
  - All section (if tab = "All" or search active):
    - Food name + calories + macros
    - "+ Add" button (right, tappable)
  - My Foods section (if tab = "My Foods"):
    - "Create a Food" form (top)
    - Saved custom foods list

**Behavior:**

**Screen Load:**
- All tab is active
- History foods populated (recently logged foods appear first)
- Food database loaded (or lazy-loaded on scroll)

**Tap "All" Tab:**
- Content switches to full food database
- History section still visible at top
- All database foods listed below
- Search bar clears if previous search active

**Tap "My Foods" Tab:**
- Content switches to custom foods
- "Create a Food" form visible (top):
  - Fields: Food name, Calories, Protein (g), Carbs (g), Fat (g)
  - "Save" button (gray by default)
- Below form: list of user's custom foods
- Tap food: adds to FoodLoggerScreen

**Type in Search Bar:**
- Real-time filtering of food list
- If "All" tab: filters database foods matching query
- If "My Foods" tab: filters custom foods matching query
- Results update as you type
- If no matches: "No foods found. Create custom?"

**Tap "+ Add" Button (food):**
- Food added to FoodLoggerScreen meals
- Toast appears: "Food is added" (green checkmark)
- User stays on AddFoodScreen (can add more foods)
- Selected food may have checkmark overlay (optional visual feedback)

**Create Custom Food (My Foods Tab):**
- User taps in form fields and fills in:
  - Food name: "Protein Shake"
  - Calories: 250
  - Macros: Protein 30g, Carbs 10g, Fat 5g
- "Save" button (enabled if all fields filled):
  - Tap: custom food saved to SQLite
  - Custom food appears in "My Foods" list
  - Toast: "Custom food saved"
  - Form clears for next entry

**Tap Custom Food in List (My Foods):**
- Same as "+ Add" behavior: adds to meals
- Toast: "Food is added"

**Back Arrow:**
- Navigate back to FoodLoggerScreen
- If food was added: list updates with new entry
- If no food added: screen state unchanged

**Keyboard Behavior:**
- Return key in search: focuses first result (optional)
- Numeric keyboard in custom food form fields

---

### **DatePickerModal**

**Visual State:**
- Bottom sheet modal (slide-up 300ms)
- Drag handle (top center)
- X button (top-right, or back arrow)
- Month/Year display (center top): "January 2025"
- Left arrow (left of month/year): previous month
- Right arrow (right of month/year): next month
- Calendar grid (7 columns: SUN-SAT):
  - Empty cells for days of previous month
  - Day numbers 1-31 (or 28/29/30 depending on month)
  - Today: highlighted blue circle (or darker color)
  - Selected date: dark circle with white number
  - Other dates: white background, dark text
- Bottom section (optional): quick action buttons (Today, This Week, This Month)

**Behavior:**

**Modal Open:**
- Slides up from bottom (300ms)
- Current month displayed
- Today's date highlighted
- Previously selected date (if any) shown with selection state

**Tap Left Arrow:**
- Month changes to previous month
- Calendar updates
- Month/Year display updates: "January 2025" → "December 2024"
- Today highlight may disappear (if different month)

**Tap Right Arrow:**
- Month changes to next month
- Calendar updates
- Month/Year display updates

**Tap Date Number:**
- Date selected (dark circle background)
- Modal closes (slide-down 200ms)
- FoodLoggerScreen updates:
  - "Today" dropdown changes to selected date (e.g., "Jan 15")
  - Meals list updates to show foods for that date
  - Progress ring/bars update

**Tap "Today" Quick Button (optional):**
- Selects today's date
- Same behavior as tapping today's number

**Tap X Button:**
- Modal closes (slide-down 200ms)
- No date change
- FoodLoggerScreen remains on current date

**Swipe Down:**
- Modal closes (gesture, same as X button)

---

## SHARED COMPONENTS - PROFILE SIDEBAR

### **ProfileSidebar**

**Visual State:**
- Full-height overlay from left (~60% screen width, or full width on small devices)
- Top bar: profile icon + user name + settings icon (right)
- Horizontal line (divider)
- Menu list (scrollable):
  - Profile
  - Uploads
  - Measurements
  - Integrations
  - Refer a Friend
  - Help/Support
  - Feedback
  - Logout

**Behavior:**

**Sidebar Open:**
- Slides in from left (300ms, ease-out)
- Background dims (semi-transparent black, 0.4)
- First menu item is visible (no scroll needed for typical screen)

**Tap Menu Item:**
- Sidebar closes (slide-left, 300ms, ease-in)
- Selected screen/modal opens
- Background overlay fades out

**Tap User Name (top):**
- Navigates to ProfileScreen
- Same as tapping "Profile" menu item

**Tap Settings Icon (top-right):**
- (Optional, Phase 1 may not implement)
- Opens AppSettings screen

**Swipe Left to Close:**
- Sidebar slides left (300ms)
- Background dims fade out
- Current screen revealed

**Tap Outside Sidebar:**
- Sidebar closes (slide-left, 300ms)
- Background overlay fades out

---

### **ProfileScreen**

**Visual State:**
- Back arrow (top-left)
- "Profile" title (center)
- Profile picture (large circle, center)
  - Tap to change (overlay: "Change Photo" button)
- Form fields (scrollable list):
  - Name: "Jimmy Chen" (editable)
  - Email: "jimmy@gmail.com" (read-only in Phase 1)
  - Height: "5'10"" (editable)
  - Weight: "185 lbs" (editable)
  - Birth Date: "01/15/1990" (editable, date picker)
  - Gender: "Male" (editable, dropdown)

**Behavior:**

**Screen Load:**
- User data loads from SQLite/auth
- Form fields populate with current values
- No loading spinner (data available immediately)

**Tap Profile Picture:**
- "Change Photo" overlay appears
- Options: Take Photo (camera), Choose from Library (photo library)
- User selects option
- Native picker opens
- Photo selected: uploaded to local storage (or Supabase Storage in Phase 2)
- Profile screen updates with new photo

**Edit Form Fields:**
- Tap field: focus (black border, keyboard/picker appears)
- Edit text/value
- Tap outside or Done key: focus lost
- Changes auto-saved to SQLite (no explicit save button)
- Toast: "Profile updated" (optional)

**Height Field:**
- Numeric input with unit selector (ft/in, cm, or inches)
- Format: "5'10"" or "180 cm"

**Weight Field:**
- Numeric input with unit selector (lbs, kg)
- Format: "185 lbs" or "84 kg"
- Decimal allowed: "184.5 lbs"

**Birth Date Field:**
- Tap: date picker modal appears
- Select date
- Field updates with new date

**Gender Dropdown:**
- Tap: dropdown menu appears (Male, Female, Other, Prefer not to say)
- Select: field updates

**Back Arrow:**
- Navigate back to ProfileSidebar
- Changes auto-saved (no confirmation needed)

---

### **UploadsScreen**

**Visual State:**
- Back arrow (top-left)
- "Uploads" title
- "Upload Report" button (prominent, top)
- Empty state (if no uploads): "No uploads yet. Add your first report."
- OR Upload list (scrollable):
  - Each upload: thumbnail (left, document/image icon), name, date (right), delete button (right)
  - Tap upload: preview modal opens

**Behavior:**

**Tap "Upload Report" Button:**
- Native file picker opens (camera, photo library, files)
- User selects file/takes photo
- Returns to UploadsScreen
- New upload added to list (top or bottom, based on design)
- Toast: "Report uploaded"

**Tap Upload Card:**
- Preview modal opens (fade-in 300ms)
- If image: full-screen image viewer
- If PDF: PDF viewer (may show first page, swipe for more pages)
- Back/X to close preview

**Tap Delete Button (upload):**
- Confirmation modal: "Delete this report?"
- Confirm: file removed from SQLite and local storage
- Upload list updates
- Toast: "Report deleted"

**Long-Press Upload (Optional):**
- Context menu: View, Delete, Share
- View: same as tap
- Delete: confirmation
- Share: iOS share sheet (share file)

---

### **MeasurementsScreen**

**Visual State:**
- Back arrow (top-left)
- "Measurements" title
- "Add Measurements" button (prominent, top)
- Empty state (if no measurements): "No measurements yet. Start tracking weekly."
- OR Timeline view (scrollable, newest first):
  - Each entry: "Week of Jan 27" header + measurement values
  - Tap to expand: shows all measurement details
  - Delete button (swipe or long-press)

**Behavior:**

**Tap "Add Measurements" Button:**
- AddMeasurementsForm modal opens (slide-up 300ms)
- Form has 13 fields: Neck, Shoulders, Chest, etc.
- Optional: pre-fill with last week's values
- User fills in measurements (tape measure numbers)
- User taps "Save"
- Modal closes
- New entry added to timeline (top of list)
- Toast: "Measurements saved"

**Tap Measurement Entry (to expand):**
- Entry expands inline (no modal)
- Shows all field values: Neck 16.1", Shoulders 48.2", etc.
- Tap again to collapse

**Tap Edit (swipe or long-press):**
- AddMeasurementsForm modal opens
- Form pre-filled with selected entry's values
- User edits values
- User taps "Save"
- Entry updates in timeline
- Toast: "Measurements updated"

**Tap Delete (swipe or long-press):**
- Confirmation: "Delete this entry?"
- Confirm: entry removed from SQLite
- Timeline updates
- Toast: "Entry deleted"

---

### **IntegrationsScreen**

**Visual State:**
- Back arrow (top-left)
- "Integrations" title
- Grid/list of integration cards:
  - Each card: icon + name + status button
  - Status: "Connect" (gray), "Connected ✓" (green), "Syncing..." (spinner)
  - Last synced timestamp (if connected)
  - "Sync Now" button (if connected, optional)
  - "Disconnect" button (if connected, optional)

**Behavior:**

**Tap "Connect" Button:**
- Triggers native iOS permission dialog (HealthKit, etc.)
- Dialog text: "HealthKit app would like to access your health data"
- User taps "Allow" or "Don't Allow"
- If Allow: integration marked as "Connected ✓", timestamp recorded
- If Don't Allow: status remains "Connect"
- Toast: "Connected" or "Permission denied"

**Tap "Sync Now" Button:**
- Status changes to "Syncing..." with spinner
- Brief delay (~1-2 seconds, mock)
- Status returns to "Connected ✓"
- Last synced timestamp updates: "just now"
- Toast: "Synced successfully"

**Tap "Disconnect" Button:**
- Confirmation modal: "Disconnect from [Integration]?"
- Confirm: integration marked as "Connect" (gray button)
- Connected status, timestamp, and Sync/Disconnect buttons disappear
- Toast: "Disconnected"

---

### **ReferAFriendScreen**

**Visual State:**
- Back arrow (top-left)
- "Refer a Friend" title
- Heading: "Share the gains!"
- Referral link display (copiable, readonly text field):
  - Text: "chrug.app/ref/abc123xyz"
  - "Copy" button (or copy icon)
- "Share" button (prominent, blue or iOS standard)
- Optional: referral history (optional in Phase 1)
  - List of referred friends
  - Status: pending, joined, etc.

**Behavior:**

**Tap "Copy" Button:**
- Referral link copied to clipboard
- Toast: "Link copied to clipboard"
- User can paste in messages, emails, etc.

**Tap "Share" Button:**
- iOS native share sheet slides up
- Pre-filled share content: "Check out Chrug! [link]"
- Share options: Messages, Mail, AirDrop, More
- User selects option (or Cancel to dismiss)

---

### **HelpScreen**

**Visual State:**
- Back arrow (top-left)
- "Help & Support" title
- Illustration (person at laptop with chat bubble)
- Card list (scrollable):
  - "FAQs" card with arrow
  - "Contact Form" card with arrow
  - Optional: "Email Support" card with arrow
  - Optional: "Call Support" card with arrow

**Behavior:**

**Tap "FAQs" Card:**
- Navigate to FaqsScreen
- Slide-right transition (200ms)

**Tap "Contact Form" Card:**
- Navigate to ContactFormScreen
- Slide-right transition (200ms)

**Back Arrow:**
- Navigate back to ProfileSidebar

---

### **FaqsScreen**

**Visual State:**
- Back arrow (top-left)
- "FAQs" title
- Accordion list (scrollable):
  - Each item: question text + chevron icon (right)
  - Expanded items: show answer text below question
  - Collapsed items: hidden answer

**Behavior:**

**Screen Load:**
- First FAQ is expanded by default (shows answer)
- Other FAQs are collapsed

**Tap FAQ Question:**
- If collapsed: expand (slide-down animation 200ms, answer appears)
- If expanded: collapse (slide-up animation 200ms, answer hides)
- Chevron icon rotates 180° (pointing down when expanded, up when collapsed)
- Only 1 FAQ can be expanded at a time (optional: allow multiple)

**Swipe Down (Scroll):**
- Standard list scrolling behavior
- Expanded FAQ may collapse as you scroll (smooth scrolling continues)

---

### **ContactFormScreen**

**Visual State:**
- Back arrow (top-left)
- "Contact Form" title
- Form fields (scrollable):
  - "Select Subject" dropdown (required)
  - "How can we help you?" textarea (required, ≥10 characters)
  - "Add Screenshot" file upload (optional)
  - Checkbox: "I agree to be contacted regarding my query" (required)
  - "Submit" button (gray by default, dark when all required fields filled)

**Behavior:**

**Tap "Select Subject" Dropdown:**
- Dropdown modal/picker appears (slide-up 300ms)
- Options:
  - Account & Login
  - Programs & Workouts
  - Payments & Subscription
  - Technical Issue
  - General Question
- User taps option: modal closes, field shows selected option

**Type in Textarea:**
- Text appears as typed
- Character counter shows (optional): "X / 1000"
- Submit button enables when ≥10 characters

**Tap "Add Screenshot":**
- File picker opens (camera, photo library, files)
- User selects image
- Returns to form with image preview
- User can tap preview to delete/replace

**Checkbox:**
- Tap: checkbox toggles checked/unchecked
- Required for form submission

**Tap "Submit" Button (when enabled):**
- All required fields must be filled:
  - Subject selected
  - Message ≥10 characters
  - Checkbox checked
- Button disables (loading spinner)
- Form submits (mock, stored locally in Phase 1)
- Toast: "Thank you for contacting us. We'll respond soon."
- Screen clears or navigates back

**Back Arrow:**
- Navigate back to HelpScreen
- Unsaved form data: discarded (no confirmation)

---

### **FeedbackScreen**

**Visual State:**
- Back arrow (top-left)
- "Feedback" title
- Illustration
- Heading: "Tell us about your experience"
- Textarea: placeholder "What's on your mind?" (required, ≥10 characters)
- "Add Screenshot" file upload (optional)
- "Submit" button (gray by default)

**Behavior:**

**Type in Textarea:**
- Text appears as typed
- Character counter: "X / 1000" (optional)
- Submit button enables when ≥10 characters

**Tap "Add Screenshot":**
- File picker opens
- User selects image
- Preview appears
- Can delete/replace

**Tap "Submit":**
- Text ≥10 characters required
- Button disables (loading spinner)
- Feedback submitted (mock, stored locally)
- Toast: "Thank you for your feedback. We read every message."
- Form clears or navigates back

**Back Arrow:**
- Navigate back to ProfileSidebar
- Unsaved feedback: discarded (no confirmation)

---

### **NotificationsScreen**

**Visual State:**
- Back arrow (top-left)
- "Notifications" title
- List (scrollable):
  - Each notification: unread (light blue background + black dot left) or read (normal background)
  - Notification text (bold title + body text)
  - Timestamp (gray, right): "2 min ago", "1 hour ago", "Today 3:45 PM"
  - Swipe left: delete button appears

**Behavior:**

**Screen Load:**
- Notifications load from SQLite
- Unread notifications appear first (sorted by date, newest first)
- Notification badge on bell icon clears

**Tap Notification:**
- Mark as read (background returns to normal, blue fades)
- Swipe to the intended screen (e.g., if workout reminder: navigate to ExerciseDetailsScreen)
- OR modal shows full notification details

**Swipe Left on Notification:**
- Notification slides left
- Delete button appears (red)
- Tap delete: confirmation, then remove from list
- Toast: "Notification deleted"

**Long-Press Notification (Optional):**
- Context menu: Mark as Read/Unread, Delete, etc.

**Empty State:**
- If no notifications: "No notifications yet. We'll keep you updated."

---

## Animation Timings & Curves

### Standard Animation Durations
- **Navigation transitions:** 200-300ms (push/pop, fade)
- **Modal open/close:** 300ms (fade + slide)
- **Bottom sheet:** 300ms (slide-up), 200ms (slide-down)
- **Button press feedback:** 100ms (scale)
- **Collapse/expand:** 150-200ms (slide)
- **Card reorder:** 150ms (smooth snap)
- **Toast appears:** 200ms (fade-in)
- **Toast disappears:** 200ms (fade-out after 2-3 seconds)

### Easing Curves
- **Modal appearance:** ease-out (quick start, slow end, feels natural)
- **Modal close:** ease-in (slow start, quick end, feels like motion away)
- **Scroll/list animations:** ease-in-out (smooth, predictable)
- **Button press:** ease-out (responsive feedback)
- **Navigation transitions:** ease-in-out or platform default

---

## Haptic Feedback Patterns

### Light Impact (UIImpactFeedbackStyle.light)
- Button taps (input, submit)
- List item taps
- Form field focus

### Medium Impact
- Modal opens/closes
- Bottom sheet appears/disappears
- Important state changes

### Heavy Impact
- Form submission (on success)
- Confirmation actions

### Selection (UISelectionFeedbackStyle)
- Picker selections
- Toggle switches
- Dropdown selections

### Notification (UINotificationFeedbackStyle)
- Success (✓ completion)
- Warning (⚠ caution)
- Error (✗ failure)

---

## Toast Notifications

### Standard Behavior
- Duration: 2-3 seconds (shorter for errors, longer for info)
- Position: top (below status bar) or bottom (above safe area)
- Animation: fade-in 200ms, fade-out 200ms
- Multiple toasts: queue (one at a time, or max 2 visible)
- Background: white or semi-transparent (depends on content)
- Text: dark color (#333333)
- Max width: 90% of screen

### Toast Types
- **Success:** green background, checkmark icon, e.g., "Set recorded"
- **Error:** red background, error icon, e.g., "Code is invalid"
- **Info:** blue background, info icon, e.g., "Food is added"
- **Warning:** orange background, warning icon, e.g., "No network"

---

## Error & Edge Case Handling

### Form Validation Errors
- Error message appears below field (red text)
- Field border turns red
- Submit button disabled
- User must fix before proceeding

### Network Errors
- Toast: "Network error. Try again."
- Retry button appears (or auto-retry in background)
- UI remains interactive (user can continue offline)

### Timeout Errors
- Toast: "Request timed out. Try again."
- User can retry

### Invalid Input
- Toast: "Invalid input. Please check and try again."
- Field highlighted
- User can correct

### Empty State Handling
- Large, friendly icon or illustration
- Heading: "No [items] yet"
- Subheading: call-to-action (e.g., "Start by adding a food")
- Primary button visible (e.g., "+ Add Food")


# USER_FLOWS.md — Chrug MVP Phase 1

## Flow Inventory

| Flow ID | Flow Name | Primary User Type | Priority |
|---------|-----------|-------------------|----------|
| UF1 | First App Open → Signup → Workout | First-Time + Experienced | P0 |
| UF2 | Create Custom Program → Workout | Experienced + Goal-Oriented | P0 |
| UF3 | Pick Pre-Made Program → Workout | First-Time + Experienced | P0 |
| UF4 | Log Workout Set (Complete) | All | P0 |
| UF5 | Add Exercise Mid-Workout | All | P0 |
| UF6 | Log Nutrition (Complete) | All | P0 |
| UF7 | View AI Coach & Chat | All | P0 |
| UF8 | Access Profile & Settings | All | P0 |
| UF9 | Connect Integration | Goal-Oriented | P0 |
| UF10 | Share Program | All | P0 |
| UF11 | Change Program | All | P0 |
| UF12 | Add & Track Measurements | Goal-Oriented | P0 |
| UF13 | Upload Reports | Goal-Oriented | P0 |
| UF14 | View Help & Submit Feedback | All | P0 |

---

## Detailed Flows

---

## UF1: First App Open → Signup → Workout

**Flow ID:** UF1  
**Goal:** New user sees the app, understands value, creates account, starts first workout  
**Trigger:** User launches app for first time  
**Primary User Type:** First-Time Gym-Goer + Experienced Lifter  

### Preconditions
- App is installed
- No auth token exists (first launch)
- Network may be available or unavailable

### Sequence

1. **Splash Screen**
   - Black background, white dumbbell icon centers
   - Auto-displays for 2-3 seconds
   - No user action required

2. **First-Time User Screen**
   - After splash fades
   - Shows: "Create New Program" card + "How to get started?" + "Watch Video" button
   - User sees profile icon (gray), notification bell
   - Bottom bar visible (Workout, AI Coach, Food Log icons)
   - User can tap "Watch Video" OR "Create New Program" OR profile icon "Login or Signup!"

3. **Path A: User taps "Create New Program"**
   - → UF2 (Create Custom Program)

4. **Path B: User taps "Login or Signup!"**
   - Navigates to Signup screen
   - Greek myth art background, dumbbell icon
   - "Continue with Apple" button + "or" divider + Email input
   - User enters email: "jimmy@gmail.com"
   - Black "Continue" arrow button appears (right side of input)
   - User taps arrow

5. **Email Verification**
   - Navigates to Account Verification screen
   - "Verify email" heading
   - Text: "Enter the 6 digits code we just sent you to jimmy@gmail.com"
   - 6 empty input fields
   - "Didn't receive the code? Resend or Edit email" link
   - User enters code (taps each field): 559536
   - Auto-submits when 6th digit entered
   - Loading spinner appears briefly

6. **Post-Verification**
   - Redirects to Workout Days page
   - User is now authenticated
   - No "Login or Signup!" heading (user is logged in)
   - "Create New Program" card visible
   - → User can now UF2 or UF3

### Screen IDs Used
- Splash Screen
- First-Time User Screen
- Signup Screen
- Account Verification Screen
- Workout Days Page

### Backend/API Dependencies
- None (Phase 1 is frontend-only, auth is mocked)

### Success Outcome
- User is authenticated (locally, no backend)
- User lands on Workout Days page ready to create/select program
- No data loss (all local)

### Empty Path
- User closes app during signup
- On next launch: shows First-Time User Screen again
- Any partially entered data is lost (Phase 1 doesn't persist signup state)

### Error Path
- User enters wrong email verification code
- Toast error: "Invalid code. Try again."
- User can tap "Resend" to request new code
- Resend button disabled for 30 seconds (timer shows countdown)
- After 3 failed attempts: "Edit email" link enabled to change email

### Retry Path
- User taps "Edit email" → returns to email input
- User enters different email: "different@gmail.com"
- Verification code sent to new email
- User enters 6-digit code
- Auto-submit triggers

### Abandoned Flow Behavior
- User taps back arrow on Account Verification → returns to Signup screen
- User taps "Cancel" on Signup → back to First-Time User Screen
- On next app launch: First-Time User Screen shown again (no session persisted)

---

## UF2: Create Custom Program → Workout

**Flow ID:** UF2  
**Goal:** User creates a custom program from scratch, selects exercises, starts first workout  
**Trigger:** User taps "Create New Program" button  
**Primary User Type:** Experienced Lifter + Goal-Oriented  

### Preconditions
- User is authenticated OR on First-Time User Screen (anonymous mode)
- User is on Workout Days page or First-Time User Screen

### Sequence

1. **Initiate Program Creation**
   - User taps "Create New Program" button
   - Bottom sheet modal slides up from bottom
   - Title: "Enter Program Name"
   - Input field with placeholder: "ie. Push/Pull/Leg or Full Body Program"
   - 2 rows of scrollable suggestion bubbles (pre-made program names):
     - Row 1: Focus, Push/Pull/Leg, Full Body Focus, 8 week build
     - Row 2: Leg, 4 week workout, Fat Burn Basics, Fat Burn...
   - "Create" button at bottom (gray, disabled)

2. **User Enters Program Name**
   - User types: "Push/Pull/Leg"
   - Text appears in input field
   - Suggestion bubbles still visible (can tap to auto-fill)
   - "Create" button turns black (enabled)
   - OR User taps a suggestion bubble → auto-fills input with that name

3. **Create Program**
   - User taps "Create" button (now black/enabled)
   - Modal closes
   - Navigates to Select Exercise screen
   - Header shows: back arrow + "Push/Pull/Leg" (program name) + "Next" button (disabled initially)

4. **Select Exercises (Day 1 by default)**
   - Select Exercise screen displays
   - Title: "Select Exercise"
   - Search bar: "Search or Create your own"
   - Filter icon (right of search)
   - Filter bubbles: Chest, Back, Leg, Tricep (scrollable)
   - History section: previously used exercises (empty for first-time user)
   - All section: full exercise database
   - User can:
     - Type in search bar → filters exercises in real-time
     - Tap a filter bubble → shows exercises for that muscle group
     - Tap three dots on exercise → previews Exercise Details (name, type, description)
     - Tap circle checkbox → selects exercise

5. **User Selects Exercises for Day 1**
   - User taps "Chest" filter bubble
   - List updates to show chest exercises
   - User taps checkbox next to "Bench Press" → circle fills (selected)
   - User taps three dots next to "Bench Press" → preview slides open:
     - Exercise name: "Bench Press"
     - Badges: Compound, Free-weight
     - Description (full text)
     - Back arrow closes preview
   - User returns to list, continues selecting:
     - Incline Dumbbell Press (selected)
     - Cable Flyes (selected)
   - "Next" button (top-right) turns black (enabled once ≥1 exercise selected)

6. **User Taps "Next"**
   - Navigates to Workout Day page
   - Title: "Day 1" with "rename day?" link (right)
   - "Start your workout!" heading + "Click on an exercise to start instantly"
   - Up/Down arrows (right side) for reordering exercises chronologically
   - Exercise cards listed in order:
     - Bench Press | (no last set info yet)
     - Incline Dumbbell Press | (no last set info yet)
     - Cable Flyes | (no last set info yet)
   - "+ Add Exercise" floating button (bottom-right)

7. **Start Workout**
   - User taps "Bench Press" card
   - Navigates to Exercise Details screen
   - Exercise name: "Bench Press" (title)
   - "Change rest time" button + "Watch tutorial" button
   - Gray tip text
   - "+ Add Set" floating button (bottom-right)
   - → UF4 (Log Workout Set begins)

### Screen IDs Used
- Create Program Modal (bottom sheet)
- Select Exercise Screen
- Exercise Details (preview)
- Workout Day Page
- Exercise Details (during workout)

### Backend/API Dependencies
- None (Phase 1 frontend-only)

### Success Outcome
- Custom program "Push/Pull/Leg" created
- Day 1 with 3 exercises selected
- User ready to log first set

### Edge Cases
- User selects exercises but taps back arrow → modal closes, program NOT saved
- User types program name, sees suggestions, taps one → auto-fills (no need to type rest)
- User searches "bench" → shows all exercises containing "bench" (Bench Press, Dumbbell Bench, etc.)
- User taps circle for compound exercise → only shows single muscle group selection (not compound-specific flow yet)

### Empty Path
- User creates program but selects 0 exercises
- "Next" button remains disabled
- User must select ≥1 exercise to proceed

### Error Path
- User types program name with special characters: "!!!Push!!!" → accepted (no validation in Phase 1)
- User creates duplicate program name: "Push/Pull/Leg #2" created (no duplicate check)

---

## UF3: Pick Pre-Made Program → Workout

**Flow ID:** UF3  
**Goal:** User browses and selects a pre-built program template, starts workout  
**Trigger:** User taps "Pick a Program" from Workout Days or First-Time User Screen  
**Primary User Type:** First-Time Gym-Goer  

### Preconditions
- User is authenticated OR on First-Time User Screen
- User is on Workout Days or First-Time User Screen

### Sequence

1. **Navigate to Pick a Program**
   - User taps "Pick a Program" button or link
   - Navigates to Pick a Program screen
   - Back arrow (top-left)
   - Title: "Pick a Program"
   - Motivational text: "Differences between programs don't matter nearly as much as being consistent..."
   - Search bar: "Search programs"

2. **Browse Programs**
   - Full-width rectangle cards displayed:
     - "Push/Pull/Legs" | 3 days/week | [Preview] [Select] buttons
     - "Upper/Lower" | 4 days/week | [Preview] [Select] buttons
     - "Full Body" | 3 days/week | [Preview] [Select] buttons
     - "Bro Split" | 5 days/week | [Preview] [Select] buttons
     - (more, scrollable)
   - User can scroll through programs
   - User can search by typing program name

3. **Path A: User taps "Preview"**
   - Navigates to Program Details screen
   - Program name: "Push/Pull/Legs" (title)
   - Days listed:
     - Day 1 (Push): Bench Press, Incline Dumbbell Press, Tricep Dips (5 exercises total)
     - Day 2 (Pull): Barbell Rows, Lat Pulldowns, Barbell Curls (5 exercises total)
     - Day 3 (Legs): Squats, Leg Press, Leg Curls (5 exercises total)
   - Back arrow → returns to Pick a Program
   - Back again → returns to Workout Days

4. **Path B: User taps "Select"**
   - Program "Push/Pull/Legs" is selected
   - Modal closes (or screen auto-navigates)
   - Redirects to Workout Days page
   - Program name displays: "Push/Pull/Legs"
   - All days now listed: Day 1 (Push), Day 2 (Pull), Day 3 (Legs)
   - User can now tap a day to start workout → → UF4

5. **Search Programs**
   - User types "upper" in search bar
   - Program list filters in real-time
   - Shows only programs matching "upper" (e.g., "Upper/Lower")
   - Continues as normal

### Screen IDs Used
- Pick a Program Screen
- Program Details Screen (preview)
- Workout Days Page

### Backend/API Dependencies
- None (Phase 1 frontend-only, programs hardcoded)

### Success Outcome
- Pre-made program selected
- User lands on Workout Days with days pre-populated
- User ready to start first workout

### Empty Path
- User taps back arrow from Pick a Program → returns to Workout Days
- No program selected, user still sees "Create New Program" card

### Error Path
- Search finds no matching programs: "No programs found"
- User clears search, list resets to all programs

---

## UF4: Log Workout Set (Complete Journey)

**Flow ID:** UF4  
**Goal:** User logs a complete set with reps, weight, optional metadata; sees timer; ready for next set  
**Trigger:** User taps "+ Add Set" button on Exercise Details screen  
**Primary User Type:** All  

### Preconditions
- User is on Exercise Details screen
- User has selected an exercise
- User has a program/day/exercise selected

### Sequence

1. **Initiate Set Logging**
   - User taps "+ Add Set" floating button
   - Half-page modal slides up from bottom
   - Title: "Repetitions & Weight"
   - X icon (top-right)
   - Reps field: "4 rep" with - and + buttons (auto-focused, black border)
   - Weight field: "10 kg" with - and + buttons
   - "Optional" sections (collapsed initially):
     - Reps in Reserve: 0, 1, 2, 3+ bubbles
     - Tempo Variation: Paused, Slow Eccentric, Normal bubbles
   - "Add Notes" button (left side, with icon)
   - "Record Set" button (large, dark center)
   - Number pad below (for quick entry)

2. **User Enters Reps**
   - Reps field is auto-focused (black border)
   - User taps number pad or keyboard: 8
   - Reps field updates: "8 rep"
   - Black border remains

3. **User Enters Weight**
   - User taps Weight field
   - Black border moves to Weight field
   - User taps number pad or keyboard: 1, 8, 5
   - Weight field updates: "185 kg" (or "lbs" based on user setting)
   - (Phase 1: weight unit is hardcoded, no conversion)

4. **Optional: RIR (Reps in Reserve)**
   - User taps "Reps in Reserve" section → expands
   - User taps "2" bubble
   - Bubble highlights (selected)
   - Indicates user was 2 reps away from failure

5. **Optional: Tempo Variation**
   - User taps "Tempo Variation" section → expands
   - User taps "Slow Eccentric" bubble
   - Bubble highlights (selected)
   - Indicates user did slow eccentric tempo on this set

6. **Optional: Add Notes**
   - User taps "Add Notes" button
   - Text input appears (or expands from button)
   - User types: "Felt strong, paused at bottom"
   - Note is attached to this set

7. **Record Set**
   - All required fields filled: Reps=8, Weight=185
   - "Record Set" button is dark/enabled
   - User taps "Record Set"
   - Modal closes
   - Set is added to Exercise Details screen
   - Toast appears: "Set recorded" (optional animation)

8. **Rest Timer Activates**
   - Floating pill appears at bottom
   - Left side: Loading circle (starts filling in reverse, decreasing)
   - Center: Countdown "3:00" → "2:59" → ... → "0:00"
   - Right side: "Next Set"
   - Three dots menu (options: skip, extend, adjust)
   - X button to dismiss
   - Auto-starts immediately

9. **Timer Countdown**
   - User can rest during this time
   - Timer counts down visually
   - When 0:00 reached: haptic feedback + sound alert (optional in Phase 1 mock)
   - "Record Set" modal remains available (user can tap "+ Add Set" again)

10. **User Taps X to Dismiss Timer**
    - Timer pill closes
    - User is ready to log next set

11. **User Taps "+ Add Set" Again**
    - Modal opens again
    - Reps field: pre-filled with last set reps (8 rep) — OR empty, user's choice
    - Weight field: pre-filled with last set weight (185 kg) — OR empty
    - (Phase 1: decides on default behavior)
    - User can repeat steps 2-7 for next set

### Screen IDs Used
- Exercise Details Screen
- Add Set Modal
- Rest Timer Pill

### Backend/API Dependencies
- None (Phase 1 frontend-only)

### Success Outcome
- Set logged with reps, weight, optional metadata
- Rest timer auto-activated
- User ready for next set immediately (no friction)

### Edge Cases
- User enters 0 reps → allowed (Phase 1 no validation)
- User enters negative weight → allowed (Phase 1 no validation)
- User enters both reps AND weight, then taps RIR bubble → set still valid, RIR is optional
- User dismisses modal with X → set NOT saved, modal closes

### Empty Path
- User opens modal but doesn't fill Reps field
- "Record Set" button remains disabled (gray)
- User must enter Reps and Weight minimum

### Error Path
- Timer is running, user taps "+ Add Set" to log next set before timer ends
- Modal opens, user fills reps/weight while timer continues in background
- User taps "Record Set" → set recorded, timer continues (no interrupt)

### Retry Path
- User records set, sees weight was wrong on timer pill
- User taps X to dismiss timer
- User taps "+ Add Set" again → new blank form (reps/weight fields empty)
- User re-enters correct weight
- User records second (corrected) set
- Both sets are logged (Phase 1 doesn't have delete/undo)

### Offline Behavior
- User logs sets without network
- Data stored locally in drift SQLite
- No sync attempted (Phase 1 no backend)
- On app restart: all logged sets still present

---

## UF5: Add Exercise Mid-Workout

**Flow ID:** UF5  
**Goal:** User realizes they forgot an exercise, adds it mid-workout without losing progress  
**Trigger:** User taps "+ Add Exercise" floating button on Workout Day page  
**Primary User Type:** All  

### Preconditions
- User is on Workout Day page
- User has already logged sets for current day
- User wants to add an unplanned exercise

### Sequence

1. **Initiate Add Exercise**
   - User taps "+ Add Exercise" floating button (bottom-right)
   - Navigates to Select Exercise screen
   - Back arrow, program name, "Next" button visible
   - Search bar, filter bubbles, exercise list displayed

2. **Select New Exercise**
   - User searches "cable flyes"
   - Exercise list filters to show matching exercises
   - User taps circle checkbox next to "Machine Cable Flyes"
   - Bubble fills (selected)
   - "Next" button becomes enabled

3. **Confirm Addition**
   - User taps "Next"
   - Modal/screen closes
   - Back to Workout Day page
   - New exercise "Machine Cable Flyes" added to bottom of exercise list
   - No previously logged sets for this exercise (new addition)

4. **Continue Workout**
   - User taps "Machine Cable Flyes" to start logging sets
   - → UF4 (Log Workout Set) begins for this new exercise

### Screen IDs Used
- Workout Day Page
- Select Exercise Screen

### Backend/API Dependencies
- None (Phase 1 frontend-only)

### Success Outcome
- New exercise added to current day
- User can log sets for this exercise
- Existing sets for other exercises unaffected

### Edge Cases
- User adds same exercise twice (e.g., Bench Press listed twice)
- Both instances appear as separate cards (Phase 1 allows duplicates)
- User adds exercise but taps back arrow before hitting "Next"
- Exercise NOT added, returns to Workout Day with original exercises

---

## UF6: Log Nutrition (Complete Journey)

**Flow ID:** UF6  
**Goal:** User searches for food, logs it with macros, sees daily totals update  
**Trigger:** User taps "+ Add Food" button on Food Logger screen  
**Primary User Type:** All  

### Preconditions
- User is on Food Logger screen
- User has a program/workout started (or can log food independently)

### Sequence

1. **Initiate Food Logging**
   - User taps "+ Add Food" floating button (blue, bottom-right)
   - Navigates to Add Food screen
   - Back arrow, "Add Food" title, search bar with scale icon
   - Tabs: "All" (active), "My Foods"
   - History section: recently logged foods (empty for first-time user)
   - All section: full food database

2. **Search for Food**
   - User taps search bar, types: "chicken breast"
   - Food list filters in real-time
   - Shows: "Chicken Breast (Cooked)" | 165 cal, 31g protein per 100g
   - Other matches: "Chicken Breast (Raw)", "Rotisserie Chicken", etc.

3. **Select Food**
   - User taps "Add +" next to "Chicken Breast (Cooked)"
   - (Optional: Modal slides up to confirm quantity/portion)
   - Toast appears: "Food is added"
   - User stays on Add Food screen (can add more foods)

4. **Continue Adding Foods (Optional)**
   - User taps search bar again, types: "eggs"
   - Shows: "Boiled Egg" | 78 cal, 6.3g protein per egg
   - User taps "+ Add" button
   - Toast: "Food is added"
   - User can repeat for multiple foods in one session

5. **Create Custom Food (My Foods Tab)**
   - User taps "My Foods" tab
   - "Create a Food" section visible (top)
   - Form with fields: Food name, Calories, Macros (Protein, Carbs, Fat)
   - User enters:
     - Name: "My Protein Shake"
     - Calories: 250
     - Protein: 30g
     - Carbs: 10g
     - Fat: 5g
   - User taps "Save"
   - Custom food added to "My Foods" list
   - User can tap "+ Add" to log this custom food anytime

6. **Return to Food Logger**
   - User taps back arrow from Add Food screen
   - Navigates back to Food Logger
   - Daily summary updates:
     - Goal: 1,670 cal
     - Eaten: 1,093 cal (increased from logged foods)
     - Remaining: 577 cal
     - Macro bars update (Protein filled more, Carbs less)
   - Meals list shows new entries:
     - Latest timestamp: Chicken Breast | 165 cal
     - Earlier: Boiled Egg | 78 cal
     - All organized by meal/time

7. **View Daily Totals**
   - User can scroll through all logged foods
   - Date picker dropdown shows "Today" (can change to past/future days)
   - Macro summary visible at top

### Screen IDs Used
- Food Logger Screen
- Add Food Screen
- Food Search Modal (optional, phase 1 inline)

### Backend/API Dependencies
- None (Phase 1 frontend-only, food database hardcoded)

### Success Outcome
- Foods logged with calories and macros
- Daily totals updated in real-time
- Macro progress bars updated
- User sees remaining calories

### Empty Path
- User taps back arrow from Add Food without adding anything
- Returns to Food Logger, no changes

### Edge Cases
- User searches "xyz" → no results found
- "No foods found" message displayed
- User can "Create xyz" (custom food) or try different search
- User adds food multiple times (e.g., Chicken Breast logged twice in same meal)
- Both instances appear in Food Logger (no dedup)

### Offline Behavior
- User logs foods without network
- Data stored locally in drift SQLite
- Macro calculations happen locally
- On app restart: all logged foods still present

---

## UF7: View AI Coach & Chat

**Flow ID:** UF7  
**Goal:** User opens AI Coach, sees chat interface, can ask questions  
**Trigger:** User taps AI Coach icon (middle) in bottom bar  
**Primary User Type:** All  

### Preconditions
- App is loaded
- User is authenticated OR anonymous (Phase 1 both work)

### Sequence

1. **Open AI Coach**
   - User taps "AI Coach" icon in bottom bar
   - Navigates to AI Coach screen
   - Top bar: Hamburger icon (left), "AI Coach" title, "New Chat" button (right)
   - Hamburger menu (when tapped):
     - Sidebar slides in from left
     - Past chats list (empty for first-time user)
     - "+ New Chat" button
   - Main area: chat messages (empty on first open)
   - Empty state: "What can I help with?" (optional quick action buttons)
   - Bottom input: "+" icon (left) | text field "Ask anything" | black send icon (right)

2. **Type Message**
   - User taps text field: "Ask anything"
   - Keyboard appears
   - User types: "Should I deload?"
   - Text appears in input field
   - Black send icon (right) becomes visible/highlighted

3. **Send Message**
   - User taps black send icon
   - Message "Should I deload?" appears in chat (right-aligned, user message bubble)
   - Input field clears
   - AI response appears after delay (mock response in Phase 1):
     - Left-aligned, AI message bubble
     - Text: "Based on your training history, your volume has been high. Consider a deload week if you're feeling fatigued."
   - Timestamp visible for each message

4. **Continue Conversation**
   - User can type another message: "What should I do this week?"
   - Send again
   - AI response appears
   - Chat history builds in real-time

5. **Upload File (Optional)**
   - User taps "+" icon (left of input)
   - File picker appears (camera, photo library, files)
   - User selects image (e.g., progress photo)
   - File uploaded to chat (shows preview)
   - Can add text with file: "What do you think of this?"
   - Send message

6. **Create New Chat**
   - User taps "New Chat" button (top-right)
   - Current chat closes
   - New blank chat opens
   - Empty state: "What can I help with?"
   - User can start fresh conversation

7. **View Past Chats**
   - User taps hamburger icon (top-left)
   - Sidebar slides in
   - List of past chats: "Should I deload?" | timestamp
   - User can tap a past chat to view/resume
   - "+ New Chat" button at bottom of sidebar

### Screen IDs Used
- AI Coach Screen
- Chat Sidebar (hamburger menu)
- File Upload Modal (optional)

### Backend/API Dependencies
- None (Phase 1 frontend-only, responses hardcoded/mocked)

### Success Outcome
- User can chat with AI Coach
- Messages appear in real-time
- File uploads work (mock)
- Chat history persists (locally in Phase 1)

### Edge Cases
- User sends empty message (just whitespace)
- Send button disabled (Phase 1 doesn't send empty messages)
- User uploads large file (> 5MB)
- Toast: "File too large"
- User types very long message (100+ characters)
- Input field scrolls horizontally, message still sendable

### Empty Path
- User opens AI Coach, sees empty chat, closes without sending
- Chat remains empty, no history created

### Offline Behavior
- User can type messages and see them locally
- AI responses are hardcoded (not dependent on network)
- Entire flow works offline in Phase 1

---

## UF8: Access Profile & Settings

**Flow ID:** UF8  
**Goal:** User opens sidebar, navigates to profile, edits personal info  
**Trigger:** User taps profile icon (top-left) on any main screen  
**Primary User Type:** All  

### Preconditions
- User is authenticated
- User is on any main screen (Workout Days, Food Logger, etc.)

### Sequence

1. **Open Profile Sidebar**
   - User taps profile icon (top-left)
   - Sidebar slides in from left (or overlay appears)
   - Top bar: Profile icon + user name + settings icon (right)
   - Horizontal line separator
   - Menu options:
     - Profile
     - Uploads
     - Measurements
     - Integrations
     - Refer a Friend
     - Help/Support
     - Feedback
     - Logout

2. **Navigate to Profile**
   - User taps "Profile" menu item
   - Sidebar closes
   - Navigates to Profile screen
   - Back arrow (top-left)
   - Editable fields:
     - Profile picture (tap to change)
     - Name: "Jimmy Chen"
     - Email: "jimmy@gmail.com"
     - Height: "5'10"
     - Weight: "185 lbs"
     - Birth Date: "01/15/1990"
     - Gender: "Male"

3. **Edit Profile**
   - User taps "Name" field
   - Keyboard appears
   - Current text: "Jimmy Chen"
   - User clears and types: "James Chen"
   - Taps elsewhere to dismiss keyboard
   - Field updates (no explicit save button, auto-saves locally)

4. **Update Weight**
   - User taps "Weight" field
   - Keyboard appears (numeric)
   - Current: "185"
   - User types: "188"
   - Weight field updates
   - If weight tracking: this value is logged with timestamp

5. **Return to Sidebar**
   - User taps back arrow
   - Navigates back to previous screen
   - Sidebar remains closed

6. **Access Other Menu Items**
   - User taps profile icon again → sidebar opens
   - Taps "Uploads" → Uploads screen
   - Taps "Measurements" → Measurements screen
   - Taps "Integrations" → Integrations screen
   - Taps "Refer a Friend" → Refer a Friend screen
   - Taps "Help/Support" → Help & Support screen
   - Taps "Feedback" → Feedback screen
   - Taps "Logout" → Clears auth token, returns to First-Time User Screen

### Screen IDs Used
- Profile Sidebar
- Profile Screen
- Uploads Screen
- Measurements Screen
- Integrations Screen
- Refer a Friend Screen
- Help & Support Screen
- Feedback Screen

### Backend/API Dependencies
- None (Phase 1 frontend-only)

### Success Outcome
- User can view and edit profile
- Changes persist locally
- User can navigate to all sidebar menu items
- User can logout

### Edge Cases
- User edits name to empty string → allowed (Phase 1 no validation)
- User taps profile icon while sidebar is open → sidebar closes
- User navigates away from Profile without saving → changes auto-saved locally

---

## UF9: Connect Integration

**Flow ID:** UF9  
**Goal:** User connects wearable (e.g., Apple Health) to app  
**Trigger:** User navigates to Integrations screen from sidebar  
**Primary User Type:** Goal-Oriented  

### Preconditions
- User is authenticated
- User is on Integrations screen
- Device has Apple Health (iOS) or Health Connect (Android) available

### Sequence

1. **View Integrations**
   - User is on Integrations screen
   - Back arrow + "Integrations" title
   - Grid/list of integration cards:
     - Apple Health | icon | "Connect" button (gray)
     - Whoop | icon | "Connect" button (gray)
     - Withings | icon | "Connect" button (gray)
     - Oura | icon | "Connect" button (gray)

2. **Connect Apple Health**
   - User taps "Connect" button on Apple Health card
   - iOS permission dialog appears:
     - "HealthKit App would like to access your health data"
     - "Allow" / "Don't Allow" buttons
   - User taps "Allow"
   - Back to Integrations screen
   - Apple Health card now shows:
     - "Connected ✓"
     - Last synced: "2 minutes ago"
     - "Sync Now" button
     - "Disconnect" button

3. **Optional: Sync Now**
   - User taps "Sync Now"
   - Loading indicator briefly shows
   - "Last synced" updates to "just now"
   - (Phase 1 mock, no actual data transferred)

4. **Optional: Disconnect**
   - User taps "Disconnect" button
   - Confirmation dialog: "Are you sure?"
   - User taps "Yes"
   - Apple Health card reverts to "Connect" button (gray)
   - Connected status removed

5. **Connect Multiple Integrations**
   - User can repeat steps 2-4 for other integrations
   - Each has separate permission flow
   - Multiple integrations can be "Connected ✓" simultaneously

### Screen IDs Used
- Integrations Screen
- iOS Permission Dialogs (native)

### Backend/API Dependencies
- None (Phase 1 frontend-only, permissions are mocked)

### Success Outcome
- Integration marked as "Connected"
- User can see last sync time
- User can manually sync
- User can disconnect

### Edge Cases
- User taps "Allow" multiple times
- Only one permission dialog appears (OS handles this)
- User taps "Don't Allow"
- Integration remains "Connect" button (gray)
- User can try again later

### Offline Behavior
- User can see integration status offline
- "Sync Now" button may be disabled (Phase 1)
- On next network: sync can happen

---

## UF10: Share Program

**Flow ID:** UF10  
**Goal:** User shares their program with a friend  
**Trigger:** User taps share icon (paper plane) on Workout Days page  
**Primary User Type:** All  

### Preconditions
- User is on Workout Days page
- User has a program loaded
- iOS share sheet is available

### Sequence

1. **Initiate Share**
   - User taps share icon (top-right, paper plane)
   - iOS share sheet slides up from bottom
   - Share options: Messages, Email, AirDrop, Copy Link, etc.
   - Text: "Check out my program: Push/Pull/Legs"
   - Link: chrug.app/program/abc123 (deep link)

2. **Share via Messages**
   - User taps "Messages"
   - Messages app opens (or compose view)
   - Program name + deep link pre-filled
   - User selects contact or types recipient
   - User sends message

3. **Share via Email**
   - User taps "Email"
   - Mail app opens (or compose view)
   - Subject: "Check out my Push/Pull/Legs program"
   - Body: Program name + deep link
   - User enters recipient email
   - User sends email

4. **Share via Copy Link**
   - User taps "Copy Link"
   - Deep link copied to clipboard
   - Toast: "Link copied"
   - User can paste in any app (WhatsApp, Discord, etc.)

5. **Friend Receives Share**
   - Friend taps link from message/email/clipboard
   - If friend has app installed: Deep link opens app, navigates to program preview
   - If friend doesn't have app: Link opens App Store / Google Play store page
   - Friend can install app, then import program

### Screen IDs Used
- Workout Days Page
- iOS Share Sheet (native)

### Backend/API Dependencies
- None (Phase 1 frontend-only, deep links are local routing)

### Success Outcome
- Program shared via iOS share sheet
- Friend can receive link
- (Phase 2: friend can import program)

### Edge Cases
- User taps share while offline
- Share sheet still opens (iOS handles this)
- User cancels share sheet → back to Workout Days

---

## UF11: Change Program

**Flow ID:** UF11  
**Goal:** User switches from one program to another  
**Trigger:** User taps "Change Program" link on Workout Days page  
**Primary User Type:** All  

### Preconditions
- User is on Workout Days page
- User has a program currently loaded
- User has previously created/selected other programs

### Sequence

1. **Open Change Program**
   - User taps "Change Program >" link (top-right of program name)
   - Navigates to Change Program screen
   - Back arrow (top-left)
   - "Create New Program" card (prominent, top)
   - "Your Programs" section:
     - Push/Pull/Legs (current program, highlighted?)
     - Iron Forge
     - Titan Training
     - Muscle Mechanics

2. **Select Different Program**
   - User taps "Titan Training" card
   - Program is selected
   - Screen closes/auto-navigates
   - Back to Workout Days page
   - Program name updates: "Titan Training"
   - Days list updates to show Titan Training's days:
     - Monday (Chest & Triceps)
     - Tuesday (Back & Biceps)
     - Wednesday (Legs)
     - Thursday (Shoulders)
     - Friday (Full Body)

3. **Create New Program from Here (Optional)**
   - Instead of selecting existing, user taps "Create New Program" card
   - → UF2 (Create Custom Program) begins

4. **Return to Workout Days**
   - User continues workout with new program
   - All previously logged sets for old program remain in history
   - New program's days are now visible and active

### Screen IDs Used
- Workout Days Page
- Change Program Screen

### Backend/API Dependencies
- None (Phase 1 frontend-only)

### Success Outcome
- Program switched successfully
- New program's days now displayed
- Old program data preserved (in history)

### Edge Cases
- User taps "Change Program" with only 1 program created
- Screen still shows "Your Programs" with single program listed
- User can only select same program or create new one

---

## UF12: Add & Track Measurements

**Flow ID:** UF12  
**Goal:** User logs weekly body measurements to track progress  
**Trigger:** User taps "Measurements" from profile sidebar  
**Primary User Type:** Goal-Oriented  

### Preconditions
- User is authenticated
- User is on profile sidebar
- User taps "Measurements" menu item

### Sequence

1. **View Measurements Screen**
   - Back arrow + "Measurements" title
   - "Add Measurements" button (prominent, top)
   - Empty state (first time): "No measurements yet. Start tracking weekly."
   - OR (with data): Timeline of weekly entries
     - Week of Jan 20: Neck 16", Shoulders 48", Chest 42", etc.
     - Week of Jan 13: Neck 16", Shoulders 47", Chest 41", etc.

2. **Add New Measurements**
   - User taps "Add Measurements" button
   - Form appears (modal or inline):
     - Neck: [input field]
     - Shoulders: [input field]
     - Chest: [input field]
     - Biceps (L): [input field]
     - Biceps (R): [input field]
     - Forearms (L): [input field]
     - Forearms (R): [input field]
     - Waist: [input field]
     - Hips: [input field]
     - Thighs (L): [input field]
     - Thighs (R): [input field]
     - Calves (L): [input field]
     - Calves (R): [input field]

3. **Fill in Measurements**
   - User enters data (tape measure numbers):
     - Neck: 16
     - Shoulders: 48
     - Chest: 42.5
     - (etc.)
   - Form may pre-fill with last week's values (optional)
   - User can edit any field

4. **Save Measurements**
   - User taps "Save" button
   - Form closes
   - New entry added to timeline:
     - Week of Jan 27: Neck 16.1", Shoulders 48.2", Chest 42.8", etc.
   - Entry timestamped with current date/week

5. **View History**
   - Timeline shows multiple weeks of entries
   - User can scroll through history
   - User can tap entry to see details (edit/delete optional in Phase 1)

### Screen IDs Used
- Measurements Screen
- Add Measurements Form

### Backend/API Dependencies
- None (Phase 1 frontend-only)

### Success Outcome
- Measurements logged with timestamp
- Timeline updated
- User can track week-over-week progress

### Edge Cases
- User enters non-numeric value (e.g., "abc") → allowed (Phase 1 no validation)
- User enters 0 for all fields → allowed
- User enters extremely large number (e.g., 999") → allowed

---

## UF13: Upload Reports

**Flow ID:** UF13  
**Goal:** User uploads bloodwork PDF or health report for AI context  
**Trigger:** User taps "Uploads" from profile sidebar  
**Primary User Type:** Goal-Oriented  

### Preconditions
- User is authenticated
- User is on profile sidebar
- User taps "Uploads" menu item

### Sequence

1. **View Uploads Screen**
   - Back arrow + "Uploads" title
   - "Upload Report" button (prominent, top)
   - Empty state (first time): "No uploads yet. Add your first report."
   - OR (with data): List of uploaded files
     - Bloodwork - Jan 2025.pdf | Jan 15 | [delete]
     - Progress Photo.jpg | Jan 10 | [delete]

2. **Upload New Report**
   - User taps "Upload Report" button
   - File picker appears:
     - Camera tab: Take photo of report
     - Photo Library tab: Select existing image
     - Files tab: Browse device storage
   - User selects from Photo Library
   - Selects image: "Bloodwork_Report.jpg"
   - Returns to Uploads screen

3. **Report Added**
   - New entry appears in list:
     - Bloodwork Report | Jan 30 | [delete]
   - File stored locally (Phase 1, no Claude Vision parsing)
   - User can add more reports

4. **Delete Report (Optional)**
   - User taps [delete] button on a report
   - Confirmation: "Delete this report?"
   - User taps "Yes"
   - Report removed from list

5. **View Report (Optional)**
   - User taps report card (if implemented)
   - Preview/gallery view of image or PDF
   - Back to Uploads screen

### Screen IDs Used
- Uploads Screen
- File Picker (native iOS/Android)
- Report Preview (optional)

### Backend/API Dependencies
- None (Phase 1 frontend-only, no Vision API parsing)

### Success Outcome
- Reports uploaded and stored locally
- Reports appear in list with timestamp
- Reports can be deleted

### Edge Cases
- User uploads very large PDF (> 10MB)
- Toast: "File too large" (Phase 1 may allow it anyway)
- User uploads non-image file (e.g., .txt)
- File still stored (Phase 1 no format validation)

---

## UF14: View Help & Submit Feedback

**Flow ID:** UF14  
**Goal:** User accesses FAQs or submits feedback/support ticket  
**Trigger:** User taps "Help/Support" or "Feedback" from profile sidebar  
**Primary User Type:** All  

### Preconditions
- User is on profile sidebar
- User taps "Help/Support" OR "Feedback"

### Sequence

### Path A: Help & Support

1. **View Help Screen**
   - Back arrow + "Help & Support" title
   - Illustration (person at laptop with chat bubbles)
   - Menu options:
     - "FAQs" card with arrow
     - "Contact Form" card with arrow

2. **View FAQs**
   - User taps "FAQs" card
   - Navigates to FAQs screen
   - Back arrow + "FAQs" title
   - Accordion list of questions:
     - "Can I edit my profile details later?" (expanded)
     - "What if I can't find an exercise in the list?" (collapsed)
     - "How do I log my workouts?" (collapsed)
     - (7 total questions)

3. **Read FAQ**
   - First question is expanded (auto-open):
     - Answer: "Yes, you can edit your profile details anytime..."
   - User taps collapsed question → expands and shows answer
   - User taps expanded question → collapses

4. **Contact Form**
   - User taps "Contact Form" from Help screen
   - Navigates to Contact Form screen
   - "Select Subject" dropdown (initially placeholder)
   - "How can we help you?" textarea
   - "Add Screenshot (Optional)" file upload
   - Checkbox: "I agree to be contacted regarding my query"
   - "Submit" button (gray, disabled)

5. **Fill Contact Form**
   - User taps "Select Subject" dropdown
   - Modal appears with options:
     - Account & Login
     - Programs & Workouts
     - Payments & Subscription
     - Technical Issue
     - General Question
   - User selects "Technical Issue"
   - Dropdown closes, "Technical Issue" appears as selected

6. **Enter Message**
   - User taps "How can we help you?" textarea
   - Keyboard appears
   - User types: "The timer doesn't work properly"
   - Message appears in textarea

7. **Upload Screenshot (Optional)**
   - User taps "Add Screenshot (Optional)"
   - File picker appears
   - User selects image from Photo Library
   - Returns to form with screenshot preview

8. **Agree to Terms**
   - User taps checkbox: "I agree to be contacted..."
   - Checkbox marks as checked

9. **Submit**
   - All required fields filled (subject + message + checkbox)
   - "Submit" button turns black (enabled)
   - User taps "Submit"
   - Toast: "Thank you for contacting us. We'll respond soon."
   - Form closes, back to Help screen

### Path B: Feedback

1. **View Feedback Screen**
   - From sidebar, user taps "Feedback"
   - Navigates to Feedback screen
   - Back arrow + "Feedback" title
   - Illustration (person at laptop)
   - "Tell us about your experience" heading
   - Textarea with placeholder text

2. **Enter Feedback**
   - User taps textarea
   - Keyboard appears
   - User types: "Love the UI, wish I could edit sets after logging"
   - Text appears (≥10 characters)

3. **Add Screenshot (Optional)**
   - User taps "Add Screenshot (Optional)"
   - File picker
   - User selects screenshot of issue

4. **Submit Feedback**
   - Text ≥10 characters → "Submit" button turns black (enabled)
   - User taps "Submit"
   - Toast: "Thank you for your feedback. We read every message."
   - Form closes

### Screen IDs Used
- Help & Support Screen
- FAQs Screen
- Contact Form Screen
- Feedback Screen
- Subject Dropdown Modal
- File Picker (native)

### Backend/API Dependencies
- None (Phase 1 frontend-only, submissions stored locally)

### Success Outcome
- User can access FAQs
- User can submit contact form
- User can submit feedback
- Confirmations appear

### Edge Cases
- User selects subject, then taps elsewhere without closing dropdown → modal stays open
- User enters feedback text, deletes it, taps Submit → Submit button becomes gray (disabled)
- User uploads screenshot, then taps "Add Screenshot" again → replaces previous image

---

## Summary of All Flows

| UF ID | Flow Name | Start Screen | End Screen | User Type | Priority |
|-------|-----------|--------------|-----------|-----------|----------|
| UF1 | First App Open → Signup | Splash | Workout Days | All | P0 |
| UF2 | Create Custom Program | Workout Days | Workout Day | Experienced | P0 |
| UF3 | Pick Pre-Made Program | Workout Days | Workout Day | First-Time | P0 |
| UF4 | Log Workout Set | Exercise Details | Exercise Details | All | P0 |
| UF5 | Add Exercise Mid-Workout | Workout Day | Workout Day | All | P0 |
| UF6 | Log Nutrition | Food Logger | Food Logger | All | P0 |
| UF7 | AI Coach & Chat | Bottom Bar | AI Coach | All | P0 |
| UF8 | Profile & Settings | Any (Sidebar) | Profile | All | P0 |
| UF9 | Connect Integration | Integrations | Integrations | Goal-Oriented | P0 |
| UF10 | Share Program | Workout Days | iOS Share | All | P0 |
| UF11 | Change Program | Workout Days | Workout Days | All | P0 |
| UF12 | Measurements Tracking | Measurements | Measurements | Goal-Oriented | P0 |
| UF13 | Upload Reports | Uploads | Uploads | Goal-Oriented | P0 |
| UF14 | Help & Feedback | Help/Feedback | Help/Feedback | All | P0 |

---

## Design Principles Embedded in Flows

1. **Delayed Friction:** UF1 allows signup to be optional; user trains first (anonymous mode)
2. **Offline-First:** All flows work without network (Phase 1 frontend-only)
3. **Fast Logging:** UF4 emphasizes speed (< 2 seconds for set logging)
4. **No Silent Edits:** All AI-initiated actions follow Propose → Confirm → Apply (deferred to Phase 2)
5. **Data Persistence:** All flows assume local SQLite storage, no backend sync
6. **Reversibility:** Most flows can be undone or reversed (no permanent deletions in Phase 1)


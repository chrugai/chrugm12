# PRODUCT_SPEC.md — Chrug MVP Phase 1 (Frontend)

## Product Overview

**Product Name:** Chrug  
**One-Sentence Definition:** A mobile fitness app that lets users log workouts, track nutrition, and receive AI-powered coaching — all offline-first with delayed authentication friction.

**Business Objective:** Launch a fully functional frontend mobile app (iOS/Android via Flutter) that demonstrates core user journeys: workout logging, program creation/management, nutrition tracking, and AI coach interaction. Phase 1 is frontend-only with mock data — no backend calls.

**User Objective:** Users want to log workouts fast (< 2 seconds per set), track their training over time, manage programs flexibly, see nutrition impact, and get intelligent coaching without friction or complexity.

---

## Target Users

### User Type 1: First-Time Gym-Goer
- **Description:** New to strength training, needs structure and guidance
- **Primary Goals:** 
  - Complete first workout without feeling lost
  - Understand program structure and exercise execution
  - See progress/motivation to continue
- **Primary Frustrations:**
  - Forced to create program before training
  - Complex program selection overwhelming
  - No guidance on form or exercise variations
- **Permissions/Roles:** User (default)

### User Type 2: Experienced Lifter (Self-Directed)
- **Description:** Knows what they're doing, wants customization and data
- **Primary Goals:**
  - Build/modify their own programs quickly
  - Track progression over time
  - Get intelligent recommendations based on data
- **Primary Frustrations:**
  - Generic templates don't match their style
  - Logging is slow/tedious
  - No insight into what's working
- **Permissions/Roles:** User (default)

### User Type 3: Goal-Oriented Athlete
- **Description:** Specific goals (bulk, cut, strength), disciplined, data-conscious
- **Primary Goals:**
  - Log nutrition alongside training
  - Get AI recommendations on program/diet changes
  - See phase-appropriate guidance (bulk vs cut)
- **Primary Frustrations:**
  - Can't correlate diet with training results
  - No AI context on their full picture
  - Manual tracking is error-prone
- **Permissions/Roles:** User (default)

---

## In-Scope Features (Phase 1)

### F1: Splash Screen
- Full black background with white dumbbell icon (centered)
- Auto-displays for 2-3 seconds on app launch
- Transitions to either Signup or Workout Days based on auth state
- **Priority:** P0

### F2: Authentication (Email + Apple)
- Email-based signup with 6-digit code verification (auto-submit)
- Apple Sign-In option
- No email verification required at MVP
- Delayed friction: user can train before signing up (anonymous mode)
- **Priority:** P0

### F3: Workout Days (Default Home)
- Displays current program name with "Change Program" link
- Lists all days in the program (user-renamed or default "Day 1/2/3")
- Dumbbell icon per day
- "Add Workout Day" floating button
- Share program button (iOS share sheet)
- **Priority:** P0

### F4: Program Management
- **Pick a Program:** Browse pre-made programs with filters, preview details, select
- **Create Your Own:** Bottom sheet modal to enter name, choose from suggestions, create
- **Change Program:** Switch between previously created/selected programs
- **Priority:** P0

### F5: Select Exercises
- Search bar (search or create custom exercises)
- Filter bubbles by muscle group (Chest, Back, Leg, Tricep, etc.)
- History section (recently used exercises)
- All section (exercise library database)
- Three-dot menu per exercise (preview details)
- Compound exercise handling: Primary Muscle + Secondary Muscles (multi-select)
- Isolation: single muscle group
- Equipment type selector (Free-weight, Machine, Body Weight)
- "Next" button appears after selecting ≥1 exercise
- **Priority:** P0

### F6: Workout Day (Exercise List)
- Back arrow → returns to Workout Days
- Day name (clickable "rename day?" with edit icon)
- "Start your workout!" title with motivational text
- Up/Down arrows to reorder exercises chronologically
- Full-width white cards per exercise:
  - Exercise name (left)
  - Last set info: "X reps - Y lbs" (right)
  - Date timestamp (right, above last set)
- Floating "+ Add Exercise" button (opens Select Exercises)
- **Priority:** P0

### F7: Exercise Details (During Workout)
- Back arrow (top-left)
- Exercise name (title)
- "Change rest time" button (clock icon, left)
- "Watch tutorial" button (video icon, right)
- Gray tip: "Quick Tip: Swipe set to the right to repeat it and to the left to delete it!"
- Floating "+ Add Set" button (bottom-right)
- Set history section (scrollable list of previous sets for this exercise)
  - Organized by date (Today, historical dates)
  - Each set shows: timestamp, reps, weight
- **Priority:** P0

### F8: Add Set Modal
- Half-page modal sliding up from bottom
- Title: "Repetitions & Weight"
- Reps field: "X rep" with -/+ buttons (auto-focused, black border when active)
- Weight field: "X kg" with -/+ buttons
- **Optional sections:**
  - Reps in Reserve (0, 1, 2, 3+ bubbles)
  - Tempo Variation (Paused, Slow Eccentric, Normal bubbles)
- "Add Notes" button (left side)
- "Record Set" button (large, dark blue/black center)
- Number pad below
- Auto-submit logic: none (user taps "Record Set")
- **Priority:** P0

### F9: Rest Timer
- Floating pill at bottom when set recorded
- Loading circle (left, fills/depletes in reverse)
- Countdown display: "0:57"
- "Next Set" text
- Three dots menu (options: skip, extend, adjust)
- X button to dismiss
- Auto-starts when set is recorded
- **Priority:** P0

### F10: Food Logger
- Top bar: Profile icon | "Today" date picker (dropdown) | Notification bell
- Daily summary:
  - Circular progress ring: Remaining calories (center)
  - Goal (left), Eaten (right)
  - Macro bars: Protein, Carbs, Fat, Fiber (color-coded)
- Meals (chronological, newest first):
  - Meal header with timestamp
  - Food items with individual calories
  - Meal totals: Macros | Calories | "Edit" button
- Floating "+ Add Food" button (blue, right side)
- Bottom bar: Workout | AI Coach | Food Log
- **Priority:** P0

### F11: Add Food
- Back arrow + "Add Food" title + Search bar + Scale icon
- Tabs: **All** | **My Foods**
- **All tab:**
  - History section: previously logged foods (green checkmark)
  - All section: full database of foods
  - Each food: name | calories/macros | "Add +" button
  - Toast on add: "Food is added" (green checkmark)
- **My Foods tab:**
  - "Create a Food" section (inline form or button)
    - Food name input
    - Calories input
    - Macros (Protein, Carbs, Fat) input
    - Save button
  - Saved foods list: previously created foods with "Add +" buttons
- **Priority:** P0

### F12: Date Picker (Food Logger)
- Modal slides up when tapping "Today" dropdown
- Month/year selector (June 2025) with left/right arrows
- Calendar grid (SUN-SAT header, dates 1-30)
- Today highlighted in blue circle
- Tap a date → updates Food Log to that day
- **Priority:** P0

### F13: AI Coach
- Chat interface (ChatGPT-style)
- Hamburger icon (top-left) → sidebar with past chats + "New Chat"
- "AI Coach" title (top-center)
- "New Chat" button (top-right)
- Main chat area:
  - Messages: user (right-aligned), coach (left-aligned)
  - Empty state: "What can I help with?" with quick action buttons (optional: "Create image", "Brainstorm", etc.)
- Bottom input:
  - "+" icon (left) → upload photos/documents
  - Text input: "Ask anything"
  - Black send icon (right, appears when typing)
- Bottom bar: Workout | AI Coach | Food Log
- **Priority:** P0

### F14: Profile Sidebar
- Top bar:
  - Profile icon (left)
  - User name
  - Settings icon (far right)
- Horizontal line
- Main menu:
  - **Profile** → Profile screen
  - **Uploads** → Upload reports (bloodwork, etc.)
  - **Measurements** → Weekly body dimensions (neck, shoulders, chest, biceps, forearms, waist, hips, thighs, calves)
  - **Integrations** → Connect HealthKit, wearables, smart scales
  - **Refer a Friend** → Share referral link via iOS share sheet
  - **Help/Support** → FAQs + Contact Form
  - **Feedback** → Feedback form with optional screenshot
  - **Logout**

### F15: Profile Screen
- Editable fields:
  - Profile picture
  - Name
  - Email
  - Height
  - Weight
  - Birth date
  - Gender
- **Priority:** P0

### F16: Uploads Screen
- "Upload Report" button (prominent, top)
- Empty state: "No uploads yet..."
- Upload list (once data exists):
  - Report name/type
  - Upload date
  - File type icon
  - Preview thumbnail (if image)
  - Delete button
- File picker on tap: Camera + Photo Library + Files
- Mock data (Phase 1): 2-3 sample uploads (bloodwork PDF, progress photo, etc.)
- **Priority:** P0

### F17: Measurements Screen
- "Add Measurements" button (prominent, top)
- Timeline view (weekly entries):
  - Week label (e.g., "Week of Jan 20")
  - All dimensions displayed
  - Edit/Delete per entry
- Form on "Add Measurements":
  - Fields: Neck, Shoulders, Chest, Biceps (L/R), Forearms (L/R), Waist, Hips, Thighs (L/R), Calves (L/R)
  - Pre-fill with previous week's values
  - Save button
- Mock data (Phase 1): 4 weeks of sample measurements
- **Priority:** P0

### F18: Integrations Screen
- Marketplace layout: integration cards in list/grid
- Each card: icon | name | brief description | status button
- Status button: "Connect" (gray) or "Connected ✓" (black)
- On "Connect": opens system permission dialogs (iOS HealthKit, etc.)
- Once connected: shows last sync timestamp + "Sync Now" button
- Disconnect button
- Mock integrations (Phase 1): Apple Health, Whoop, Withings, Oura, etc.
- **Priority:** P0

### F19: Refer a Friend
- Referral link display (highlighted box)
  - "Your referral link:"
  - Unique link (e.g., chrug.app/ref/abc123)
  - Copy button
- "Share" button → iOS share sheet
- **Priority:** P0

### F20: Help & Support
- Illustration (person at laptop with chat bubbles)
- Menu options:
  - **FAQs** (card with arrow)
  - **Contact Form** (card with arrow)
- **Priority:** P0

### F21: FAQs
- Back arrow + "FAQs" title
- Accordion cards (collapsible):
  - "Can I edit my profile details later?"
  - "What if I can't find an exercise in the list?"
  - "How do I log my workouts?"
  - "How does Pick a Program work?"
  - "How does Create New Program work?"
  - "Can I adjust rest times?"
  - "Can I edit a program after creating it?"
- Tap to expand/collapse
- **Priority:** P0

### F22: Contact Form
- Back arrow + "Contact Form" title
- "Select Subject" dropdown:
  - Account & Login
  - Programs & Workouts
  - Payments & Subscription
  - Technical Issue
  - General Question
- "How can we help you?" text area
- "Add Screen shot (Optional)" file upload
  - Dashed border, "Upload file" text
  - "PDF, JPEG or PNG less than 5MB"
- "I agree to be contacted regarding my query" checkbox
- "Submit" button:
  - Gray when form empty
  - Black when subject + message filled
  - Clickable only when black
- **Priority:** P0

### F23: Feedback
- Back arrow + "Feedback" title
- Illustration (person at laptop)
- "Tell us about your experience" heading
- Text area with placeholder text
- "Add Screen shot (Optional)" file upload (same as Contact Form)
- "Submit" button:
  - Gray when text < 10 characters
  - Black when text ≥ 10 characters
  - Clickable only when black
- **Priority:** P0

### F24: Notifications
- Back arrow + "Notifications" title
- List of notification cards:
  - Unread: light blue background + black dot (left center)
  - Read: normal background, no dot
  - Icon (left), title, description, timestamp
  - Tap → mark as read + navigate to related screen
- Empty state: "No notifications yet"
- Mock data (Phase 1): 5-6 sample notifications (mix of read/unread)
- **Priority:** P0

### F25: Watch Demo
- Back arrow (top-left)
- "Demo" title
- iPhone frame mockup containing video
- Video controls: play/pause, timeline scrubber
- Time display: "21:48 / 56:32"
- **Priority:** P0

### F26: First-Time User Screen
- (After splash, before signup)
- Profile icon (top-left, gray/placeholder)
- "Login or Signup!" heading
- "Create New Program" card
- "How to get started?" section
- "Watch Video" button
- Dumbbell illustration
- Bottom bar: Workout | AI Coach | Food Log
- Tap "Login or Signup!" → Signup flow
- Tap "Watch Video" → Demo page
- **Priority:** P0

---

## Out-of-Scope Features (Phase 1)

- **Backend API calls** (all data is mock/local)
- **Real wearable integrations** (permission dialogs only, no actual sync)
- **Payment/Subscription** (Payments & Subscription option in Contact Form is placeholder)
- **Settings screen** (defer to Phase 2)
- **Dark mode** (light theme only for Phase 1)
- **Tablet/iPad support** (iPhone portrait only)
- **Landscape orientation** (portrait only)
- **Push notifications** (notification screen is mock data only)
- **Voice coach** (chat-only, no voice input/output)
- **Population intelligence/recommendations** (defer to backend)
- **Bloodwork PDF parsing** (upload UI only, no Claude Vision)
- **Form review video analysis** (UI placeholders only)
- **Advanced meal tracking** (search/logging only, no barcode scanner)
- **Onboarding flow** (unit selection, rest timer defaults, etc. — defer to Phase 2)
- **Admin dashboard** (internal tool, not Phase 1)

---

## Core Success Criteria

### User Success Metrics
- **First set logged in < 2 seconds** (from exercise selection to Record Set button tap)
- **Program creation flow completable in < 2 minutes** (name → exercise selection → Workout Day)
- **Food logging < 10 seconds per item** (search → add → done)
- **No friction between app open and first value action** (can log workout without signup)

### Product Success Metrics
- **Emulator validation pass:** All locked screens render correctly, navigation works, no crashes
- **Offline functionality:** Core logging (workouts, food) works without network
- **Data persistence:** Offline data survives app restart
- **Performance:** App launches in < 3 seconds, screens render in < 500ms

### System Correctness Metrics
- **No console errors/warnings** in Flutter emulator
- **All navigation paths executable** without breaking
- **Mock data properly seeded** for all screens
- **Acceptance criteria binary:** Pass/fail, no subjective grading

---

## Constraints

### Technical Constraints
- **Flutter** (iOS + Android, single codebase)
- **Supabase** (auth only for Phase 1, no database calls)
- **Local SQLite (drift)** for offline-first data storage
- **No backend API calls** (all data mock/hardcoded or local)
- **Network isolation** in execution environment (no real API calls possible)

### Platform Constraints
- **iOS 14+** (iPhone target)
- **Android 11+** (Android target)
- **Portrait orientation only**
- **Light theme only**

### Business Constraints
- **No payment/subscription flow** (placeholder Contact Form option only)
- **No real data sync** (localStorage via drift, but no server sync)
- **No real wearable sync** (permission dialogs only)
- **MVP scope:** 26 features, frontend-only

### Design Constraints
- **Delayed friction:** Authentication optional, user can train anonymously
- **Fast logging:** Set logging must complete in < 2 seconds
- **Offline-first:** All core actions work without network
- **No silent AI edits:** All actions follow Propose → Confirm → Apply → Log pattern (for Phase 2 AI features)

---

## Assumptions Requiring Confirmation

**All assumptions have been confirmed through discovery. This list is empty at freeze gate.**

---

## Release Scope (Phase 1)

**Phase 1 Objective:** Deliver a fully functional, offline-first fitness app frontend with realistic mock data. User can authenticate, create/select programs, log workouts and nutrition, view AI chat interface, and manage profile — all without backend calls.

**Included:**
- All 26 in-scope features (F1-F26)
- Splash screen, authentication, all main journeys
- Mock data for all screens
- Offline-first SQLite persistence
- Navigation working end-to-end
- All screens rendering correctly in emulator
- No console errors

**Excluded:**
- All out-of-scope features
- Backend API integration
- Real data sync
- Real wearable integration
- Payment/subscription functionality
- Settings screen
- Dark mode, tablet, landscape
- Voice features
- Population intelligence

---

## Tech Stack (Phase 1)

- **Mobile:** Flutter (Dart) — iOS + Android
- **Local Storage:** SQLite via drift ORM
- **Auth:** Supabase Auth (email + Apple) — no database calls
- **CI/CD:** GitHub Actions
- **Source Control:** GitHub
- **Emulator/Simulator:** iOS Simulator, Android Emulator
- **Testing:** Flutter unit tests + integration tests (no backend tests needed)
- **No AI/LLM calls:** All chat is mock data

---

## Design System

**Colors (from provided screenshots):**
- Background: Light purple/lavender (#F3F2F7 approximate)
- Text primary: Dark gray/black
- Text secondary: Medium gray
- Input fields: White (#FFFFFF)
- Buttons primary: Dark navy/black (#1A1A2E approximate)
- Buttons secondary: Light blue/lavender
- Accent (selected): Blue
- Success: Green (checkmarks)
- Alerts/Error: Red

**Typography:**
- Headings: Bold, large (titles)
- Body: Regular, medium (description text)
- Labels: Regular, small (field labels, hints)
- (Exact font sizes/families to be extracted from design system export)

**Spacing:**
- Button height: ~48-56px
- Input height: ~48-56px
- Card padding: ~16-20px
- Screen padding: ~16-24px horizontal
- (Exact values to be confirmed from design export)

**Components:**
- Full-width cards (exercise, food, program, etc.)
- Buttons: solid, rounded pill-shaped
- Inputs: white backgrounds, subtle borders
- Modals: slide up from bottom (50% height or half-page)
- Bottom bar: persistent navigation (3 icons)
- Floating action buttons: dark blue/black, bottom-right

---

## Success Criteria (Comprehensive)

### Functional Success
- [ ] All 26 features implemented as specified
- [ ] Navigation paths all executable
- [ ] Mock data properly seeded and displayed
- [ ] No missing screens or broken flows
- [ ] All user interactions respond correctly

### Quality Success
- [ ] Zero console errors/warnings in emulator
- [ ] App launches in < 3 seconds
- [ ] Screens render in < 500ms
- [ ] No jank/stuttering animations
- [ ] Offline data persists across app restart

### UX Success
- [ ] Set logging completes in < 2 seconds
- [ ] Program creation in < 2 minutes
- [ ] Food logging < 10 seconds per item
- [ ] All text legible and properly spaced
- [ ] Buttons/inputs easily tappable (48px minimum)

### Emulator Validation Success
- [ ] All screens visually match designs
- [ ] Colors, spacing, typography correct
- [ ] Safe area handling correct (notch, home indicator)
- [ ] Keyboard doesn't obscure inputs
- [ ] All interactive elements respond to tap

### Acceptance Success
- [ ] Meets all acceptance criteria in decomposed tickets
- [ ] No placeholder content or TODOs
- [ ] All edge cases handled
- [ ] Definition of done checklist complete per ticket

---

## Key Decisions Documented

1. **Delayed Friction:** Users can log workouts before signing up (anonymous mode via Supabase anon auth)
2. **Offline-First:** All core logging (workouts, food) works without network via local SQLite
3. **Mock Data Strategy:** Complete realistic data seeding so app feels like a real product, not a skeleton
4. **No Backend Phase 1:** Isolate frontend development from backend complexity
5. **Emulator-First Validation:** UI correctness validated in emulator before shipping
6. **Binary Acceptance:** All criteria measurable and objective, no subjective "looks good"
7. **Fast Logging:** UX prioritizes speed — set logging < 2s, food logging < 10s

---

## Open Questions / Blockers

None. Specification is frozen for ticket generation.

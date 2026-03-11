# UI_STRUCTURE.md — Chrug MVP Phase 1

## Navigation Architecture

### Root Navigation Stack
```
RootNavigator
├── AuthStack (if not authenticated)
│   ├── SplashScreen
│   ├── FirstTimeUserScreen
│   ├── SignupScreen
│   └── AccountVerificationScreen
│
└── MainStack (if authenticated)
    ├── BottomTabNavigator
    │   ├── WorkoutTab
    │   ├── AiCoachTab
    │   └── FoodLogTab
    │
    ├── FullScreenModals (overlaid on MainStack)
    │   ├── ProgramManagementStack
    │   ├── ProfileSidebarNavigation
    │   └── SelectExerciseStack
```

---

## Screen Hierarchy & Navigation Tree

### AUTH STACK (Pre-Authentication)

#### 1. **SplashScreen**
- **Route:** `/splash`
- **Navigation:**
  - Auto-navigate (after 2-3s delay)
  - If no auth + first app open → FirstTimeUserScreen
  - If auth + has program → MainStack/WorkoutTab
  - If auth + no program → MainStack/WorkoutTab (empty state)
- **Props:** None
- **State:** Timer (delay logic)

#### 2. **FirstTimeUserScreen**
- **Route:** `/first-time-user`
- **Navigation:**
  - Tap "Login or Signup!" → SignupScreen
  - Tap "Create New Program" → ProgramManagementStack/CreateProgramModal
  - Tap "Watch Video" → VideoPlayerScreen (or modal)
  - Tap bottom bar icons → (still requires auth, shows prompt)
- **Props:** None
- **State:** None

#### 3. **SignupScreen**
- **Route:** `/signup`
- **Navigation:**
  - Tap "Continue with Apple" → native Apple Sign-In flow
  - Tap email input + arrow → AccountVerificationScreen
  - Tap "Cancel" → FirstTimeUserScreen
- **Props:** None
- **State:**
  - `email` (string)
  - `showEmailArrow` (boolean)

#### 4. **AccountVerificationScreen**
- **Route:** `/account-verification`
- **Navigation:**
  - Auto-submit on 6th digit → (if valid) MainStack/WorkoutTab
  - Tap "Resend" → re-send code logic
  - Tap "Edit email" → SignupScreen
  - Tap back arrow → SignupScreen
- **Props:**
  - `email` (from SignupScreen)
- **State:**
  - `otpDigits` (array of 6 strings)
  - `resendTimer` (30 seconds countdown)
  - `failedAttempts` (counter, enables "Edit email" after 3)

---

### MAIN STACK (Post-Authentication)

#### **BottomTabNavigator**
- **Active Tabs:**
  1. **Workout Tab** (default home)
  2. **AI Coach Tab** (chat)
  3. **Food Log Tab** (nutrition)
- **UI:**
  - Bottom bar, 3 icons + labels
  - No text labels on tab icons (iOS conventions)
  - Active tab highlighted (darker color)
  - Persistent across navigation within each tab

---

## TAB 1: WORKOUT TAB NAVIGATION

### Root Screen: **WorkoutDaysScreen**
- **Route:** `/workout/days`
- **Navigation:**
  - Tap day card → WorkoutDayScreen
  - Tap "Change Program >" → ProgramManagementStack/ChangeProgram
  - Tap profile icon (top-left) → ProfileSidebar (overlay)
  - Tap notification bell (top-right) → NotificationsScreen
  - Tap share icon (top-right) → iOS share sheet
- **Props:** None
- **State:**
  - `selectedProgram` (Program object)
  - `days` (array of Day objects)
  - `loading` (boolean)

#### Sub-Screen: **WorkoutDayScreen**
- **Route:** `/workout/day/:dayId`
- **Navigation:**
  - Back arrow → WorkoutDaysScreen
  - Tap exercise card → ExerciseDetailsScreen
  - Tap "+ Add Exercise" → SelectExerciseStack
  - Tap "rename day?" → RenameModalDialog
  - Drag exercise (reorder) → update order
- **Props:**
  - `dayId` (string)
  - `dayName` (string)
  - `exercises` (array)
- **State:**
  - `exercises` (array of Exercise objects)
  - `reorderMode` (boolean)

#### Sub-Screen: **ExerciseDetailsScreen**
- **Route:** `/workout/exercise/:exerciseId/:dayId`
- **Navigation:**
  - Back arrow → WorkoutDayScreen
  - Tap "+ Add Set" → AddSetModalSheet
  - Tap "Change rest time" → RestTimeModalSheet
  - Tap "Watch tutorial" → TutorialVideo (modal)
  - Swipe left/right on set history → delete/duplicate
- **Props:**
  - `exerciseId` (string)
  - `dayId` (string)
  - `exerciseName` (string)
  - `exerciseImage` (URL)
- **State:**
  - `sets` (array of Set objects)
  - `selectedRestTime` (number, seconds)
  - `restTimerActive` (boolean)
  - `selectedRIR` (0, 1, 2, 3+)
  - `selectedTempo` (string: Normal, Slow Eccentric, Paused)

#### Modal: **AddSetModalSheet**
- **Route:** (modal, no route param)
- **Navigation:**
  - X button → close modal (discard)
  - "Record Set" → add to local SQLite, close modal, start RestTimer
- **Props:**
  - `exerciseId` (string)
  - `lastSetReps` (number, optional pre-fill)
  - `lastSetWeight` (number, optional pre-fill)
- **State:**
  - `reps` (number)
  - `weight` (number)
  - `rir` (0, 1, 2, 3+)
  - `tempo` (string)
  - `notes` (string)
  - `showOptionalFields` (boolean)

#### Modal: **RestTimerPill** (floating, not full screen)
- **Route:** (floating overlay)
- **Navigation:**
  - "Next Set" → stays visible
  - Three dots menu → options (skip, extend, adjust)
  - X button → close pill
- **Props:**
  - `durationSeconds` (number, e.g., 180)
  - `exerciseId` (string)
- **State:**
  - `secondsRemaining` (number)
  - `isRunning` (boolean)
  - `showMenu` (boolean)

---

## TAB 2: AI COACH TAB NAVIGATION

### Root Screen: **AiCoachScreen**
- **Route:** `/ai-coach`
- **Navigation:**
  - Hamburger icon (top-left) → ChatHistorySidebar (overlay)
  - "New Chat" button (top-right) → create new chat, clear message history
  - Tap past chat (from sidebar) → load that chat
  - "+" button (input left) → FileUploadModal
  - Send icon → send message
- **Props:** None
- **State:**
  - `messages` (array of Message objects: {role, content, timestamp})
  - `currentChatId` (string)
  - `inputText` (string)
  - `isLoading` (boolean)
  - `chatHistory` (array of chats)

#### Modal: **ChatHistorySidebar**
- **Route:** (modal overlay)
- **Navigation:**
  - Tap past chat → close sidebar, load chat
  - "New Chat" button → clear messages, create new chat ID
  - Swipe/tap close → close sidebar
- **Props:** None
- **State:**
  - `chats` (array of {id, title, lastMessage, timestamp})
  - `selectedChatId` (string)

#### Modal: **FileUploadModal**
- **Route:** (modal)
- **Navigation:**
  - Camera tab → open native camera
  - Photo Library tab → select image from library
  - Files tab → file browser
  - X button → close modal
- **Props:**
  - `onFilePicked` (callback)
- **State:**
  - `selectedFile` (File object)
  - `activeTab` (string: camera, library, files)

---

## TAB 3: FOOD LOG TAB NAVIGATION

### Root Screen: **FoodLoggerScreen**
- **Route:** `/nutrition/food-log`
- **Navigation:**
  - Profile icon (top-left) → ProfileSidebar (overlay)
  - Notification bell (top-right) → NotificationsScreen
  - "Today" dropdown → DatePickerModal
  - "+ Add Food" button → AddFoodScreen
- **Props:** None
- **State:**
  - `selectedDate` (Date object)
  - `meals` (array of Meal objects)
  - `dailyGoal` (object: calories, protein, carbs, fat)
  - `dailyTotals` (object: calories, protein, carbs, fat)

#### Modal: **DatePickerModal**
- **Route:** (modal)
- **Navigation:**
  - Left/right arrows → change month
  - Tap date → select date, close modal
  - X button → close modal
- **Props:**
  - `currentDate` (Date)
  - `onDateSelected` (callback)
- **State:**
  - `displayMonth` (Date)
  - `selectedDate` (Date)

#### Sub-Screen: **AddFoodScreen**
- **Route:** `/nutrition/add-food`
- **Navigation:**
  - Back arrow → FoodLoggerScreen
  - Tabs: "All" | "My Foods"
  - Search bar → filter food list in real-time
  - Scale icon → (no action in Phase 1)
  - Tap "+ Add" on food → add to FoodLoggerScreen, toast, stay on screen
  - Tap "+ Create" (in My Foods) → CustomFoodFormModal
- **Props:** None
- **State:**
  - `searchQuery` (string)
  - `activeTab` (string: all, myFoods)
  - `foods` (array of Food objects)
  - `filteredFoods` (array, filtered by search)
  - `historyFoods` (array of recently logged foods)

#### Modal: **CustomFoodFormModal**
- **Route:** (modal)
- **Navigation:**
  - "Save" button → create custom food, add to My Foods list, close modal
  - X button → close modal
- **Props:** None
- **State:**
  - `foodName` (string)
  - `calories` (number)
  - `protein` (number)
  - `carbs` (number)
  - `fat` (number)

---

## SHARED NAVIGATION: PROFILE SIDEBAR

### Overlay Screen: **ProfileSidebar**
- **Route:** (modal/drawer overlay)
- **Navigation:**
  - Tap "Profile" → ProfileScreen
  - Tap "Uploads" → UploadsScreen
  - Tap "Measurements" → MeasurementsScreen
  - Tap "Integrations" → IntegrationsScreen
  - Tap "Refer a Friend" → ReferAFriendScreen
  - Tap "Help/Support" → HelpScreen
  - Tap "Feedback" → FeedbackScreen
  - Tap "Logout" → clear auth token, return to AuthStack/FirstTimeUserScreen
  - Swipe/tap outside → close sidebar
- **Props:** None
- **State:**
  - `isOpen` (boolean)

#### Sub-Screen: **ProfileScreen**
- **Route:** `/profile`
- **Navigation:**
  - Back arrow → ProfileSidebar, close sidebar
- **Props:** None
- **State:**
  - `name` (string)
  - `email` (string)
  - `height` (string)
  - `weight` (string)
  - `birthDate` (Date)
  - `gender` (string)
  - `profilePicture` (File)

#### Sub-Screen: **UploadsScreen**
- **Route:** `/profile/uploads`
- **Navigation:**
  - Back arrow → ProfileSidebar
  - "Upload Report" button → native file picker
  - Tap upload card → PreviewModal
  - Tap [delete] → ConfirmDeleteModal
- **Props:** None
- **State:**
  - `uploads` (array of Upload objects: {name, type, date, filePath})

#### Sub-Screen: **MeasurementsScreen**
- **Route:** `/profile/measurements`
- **Navigation:**
  - Back arrow → ProfileSidebar
  - "Add Measurements" button → AddMeasurementsForm
- **Props:** None
- **State:**
  - `measurements` (array of Measurement objects, timestamped)

#### Modal: **AddMeasurementsForm**
- **Route:** (modal)
- **Navigation:**
  - "Save" button → add to measurements list, close modal
  - X button → close modal (discard)
- **Props:**
  - `previousWeekValues` (optional, for pre-fill)
- **State:**
  - `neck` (number)
  - `shoulders` (number)
  - `chest` (number)
  - `bicepsL` (number)
  - `bicepsR` (number)
  - `forearmsL` (number)
  - `forearmsR` (number)
  - `waist` (number)
  - `hips` (number)
  - `thighsL` (number)
  - `thighsR` (number)
  - `calvesL` (number)
  - `calvesR` (number)

#### Sub-Screen: **IntegrationsScreen**
- **Route:** `/profile/integrations`
- **Navigation:**
  - Back arrow → ProfileSidebar
  - "Connect" button → trigger native permission dialog
  - "Sync Now" button → local refresh (Phase 1)
  - "Disconnect" button → toggle connected state
- **Props:** None
- **State:**
  - `integrations` (array: {name, icon, isConnected, lastSyncedTime})

#### Sub-Screen: **ReferAFriendScreen**
- **Route:** `/profile/refer`
- **Navigation:**
  - Back arrow → ProfileSidebar
  - "Copy Link" button → copy referral URL to clipboard
  - "Share" button → iOS share sheet
- **Props:** None
- **State:**
  - `referralLink` (string, deep link)

#### Sub-Screen: **HelpScreen**
- **Route:** `/profile/help`
- **Navigation:**
  - Back arrow → ProfileSidebar
  - "FAQs" card → FaqsScreen
  - "Contact Form" card → ContactFormScreen
- **Props:** None
- **State:** None

#### Sub-Screen: **FaqsScreen**
- **Route:** `/profile/help/faqs`
- **Navigation:**
  - Back arrow → HelpScreen
  - Tap question → toggle accordion expand/collapse
- **Props:** None
- **State:**
  - `faqs` (array of {question, answer, isExpanded})
  - `expandedFaqIndex` (number, -1 if none)

#### Sub-Screen: **ContactFormScreen**
- **Route:** `/profile/help/contact`
- **Navigation:**
  - Back arrow → HelpScreen
  - "Select Subject" dropdown → SubjectDropdownModal
  - "Add Screenshot" → file picker
  - "Submit" button → submit form, toast, close
- **Props:** None
- **State:**
  - `selectedSubject` (string)
  - `message` (string)
  - `screenshot` (File)
  - `agreedToContact` (boolean)

#### Modal: **SubjectDropdownModal**
- **Route:** (modal)
- **Navigation:**
  - Tap option → select, close modal
  - X button → close modal
- **Props:** None
- **State:**
  - `selectedSubject` (string)

#### Sub-Screen: **FeedbackScreen**
- **Route:** `/profile/feedback`
- **Navigation:**
  - Back arrow → HelpScreen
  - "Add Screenshot" → file picker
  - "Submit" button → submit feedback, toast, close
- **Props:** None
- **State:**
  - `feedbackText` (string)
  - `screenshot` (File)

#### Sub-Screen: **NotificationsScreen**
- **Route:** `/notifications`
- **Navigation:**
  - Back arrow → previous screen
  - Tap notification → mark read + navigate to related content
- **Props:** None
- **State:**
  - `notifications` (array of Notification objects: {id, title, body, isRead, timestamp})

---

## PROGRAM MANAGEMENT STACK (Full-Screen Modal)

### Modal: **ProgramManagementStack**
- **Route:** (full-screen modal overlay)
- **Screens:**
  1. ChangeProgram
  2. CreateProgram
  3. SelectExercise
  4. WorkoutDay (final confirmation)

#### Screen: **ChangeProgramModal**
- **Route:** `/program/change`
- **Navigation:**
  - Back arrow → close modal, return to WorkoutDaysScreen
  - Tap program card → select program, close modal, update WorkoutDaysScreen
  - "Create New Program" card → navigate to CreateProgramModal
- **Props:** None
- **State:**
  - `userPrograms` (array of Program objects)
  - `selectedProgram` (Program object)

#### Screen: **CreateProgramModal** (Bottom Sheet)
- **Route:** `/program/create`
- **Navigation:**
  - X button (top-right) → close modal, discard
  - "Create" button → validate name, navigate to SelectExerciseModal
  - Tap suggestion bubble → auto-fill name input
- **Props:** None
- **State:**
  - `programName` (string)
  - `suggestions` (array of pre-made program names)
  - `isCreateButtonEnabled` (boolean)

#### Screen: **SelectExerciseModal**
- **Route:** `/program/select-exercises/:programId`
- **Navigation:**
  - Back arrow → CreateProgramModal
  - Tap exercise checkbox → toggle selection
  - Tap three dots → ExercisePreviewModal
  - Tap filter bubble → filter exercise list
  - "Next" button (enabled if ≥1 selected) → navigate to SelectExerciseConfirm
  - Filter icon → FilterModal
  - Search bar → real-time filter
- **Props:**
  - `programId` (string)
- **State:**
  - `selectedExercises` (array of Exercise objects)
  - `filteredExercises` (array, filtered by search + muscle group)
  - `searchQuery` (string)
  - `activeFilters` (object: {muscleGroup, equipment, movement})
  - `showFilterModal` (boolean)

#### Modal: **ExercisePreviewModal**
- **Route:** (nested modal)
- **Navigation:**
  - Back arrow → close preview, return to SelectExerciseModal
- **Props:**
  - `exerciseId` (string)
  - `exerciseName` (string)
  - `exerciseType` (string)
  - `description` (string)
- **State:** None

#### Modal: **FilterModal**
- **Route:** (nested modal)
- **Navigation:**
  - "Apply" button → apply filters, close modal
  - X button → close modal (discard)
- **Props:** None
- **State:**
  - `selectedMovement` (string: Compound, Isolation)
  - `selectedMuscleGroups` (array of strings)
  - `selectedEquipment` (array of strings)

#### Screen: **SelectExerciseConfirmModal**
- **Route:** `/program/exercises-confirm/:programId/:dayId`
- **Navigation:**
  - "Next" button → create Day object, save program + day + exercises, close modal, navigate back to WorkoutDaysScreen
  - Back arrow → back to SelectExerciseModal
- **Props:**
  - `programId` (string)
  - `dayId` (string)
  - `dayName` (string)
  - `selectedExercises` (array)
- **State:**
  - `isProcessing` (boolean, for save operation)

---

## COMPONENT HIERARCHY (Widget Tree)

### Global/Root Components
```
AppRoot
├── NavigationContainer (React Navigation)
│   ├── RootStack
│   │   ├── AuthStack (conditional render)
│   │   └── MainStack (conditional render)
│   │
│   └── GlobalProviders (state management)
│       ├── AuthProvider
│       ├── ProgramProvider
│       ├── WorkoutProvider
│       ├── NutritionProvider
│       └── AiCoachProvider
```

### Shared UI Components (Reusable)

#### **Layout Components**
```
- SafeAreaView (top/bottom safe areas)
- Container (standard padding/margins)
- ScrollableContainer (ScrollView wrapper)
- BottomTabBar
- HeaderBar (with back arrow, title, action buttons)
- FloatingActionButton (standard FAB)
```

#### **Input Components**
```
- TextInput (standard text entry)
- NumberInput (with +/- buttons)
- SelectDropdown (dropdown selector)
- Checkbox (standard checkbox)
- RadioButtonGroup (single-choice selector)
- DatePicker (calendar modal)
- TimePicker (HH:MM selector)
- SearchBar (with leading icon)
```

#### **Display Components**
```
- Card (standard white card container)
- Badge (label/tag)
- ProgressBar (macro progress visualization)
- ProgressRing (circular progress)
- Avatar (profile picture circle)
- Icon (reusable icons)
- Button (primary, secondary, disabled states)
- Toast (success/error notification)
- Modal (standard modal dialog)
- BottomSheet (sliding panel)
- Accordion (expandable sections)
- ListView (list with separators)
- GridView (grid layout)
```

#### **Workout-Specific Components**
```
- ExerciseCard (exercise display with reorder)
- SetHistoryItem (set log entry with timestamp + macros)
- RestTimerPill (floating rest timer)
- MacroProgressBar (protein/carbs/fat bar)
- SetInputForm (reps/weight entry)
```

#### **Navigation Components**
```
- BottomTabBar (3-tab navigation)
- SidebarMenu (drawer navigation)
- BackHeader (header with back arrow)
- TabHeader (header with multiple tabs)
```

---

## State Management Structure

### Global State (Context/Redux)

#### **AuthContext**
```javascript
{
  isAuthenticated: boolean
  user: {
    id: string
    email: string
    name: string
    profilePicture: string?
  }
  authToken: string
}
```

#### **ProgramContext**
```javascript
{
  programs: Program[]
  selectedProgramId: string
  currentProgram: Program
}
```

#### **WorkoutContext**
```javascript
{
  selectedDayId: string
  currentDayExercises: Exercise[]
  sets: Set[]
  restTimerActive: boolean
  selectedRestTime: number
}
```

#### **NutritionContext**
```javascript
{
  selectedDate: Date
  meals: Meal[]
  dailyGoal: {
    calories: number
    protein: number
    carbs: number
    fat: number
  }
  dailyTotals: {
    calories: number
    protein: number
    carbs: number
    fat: number
  }
}
```

#### **AiCoachContext**
```javascript
{
  messages: Message[]
  chats: Chat[]
  currentChatId: string
  isLoading: boolean
}
```

---

## Local Storage Schema (SQLite via Drift)

### Tables
1. **users** — user profile data
2. **programs** — user's custom/selected programs
3. **days** — workout days
4. **exercises** — exercise library + user selections
5. **sets** — logged sets
6. **meals** — food logging entries
7. **foods** — food database + user custom foods
8. **measurements** — body measurement history
9. **uploads** — uploaded files metadata
10. **chats** — AI coach chat history
11. **integrations** — wearable connection status

---

## Deep Linking Schema

### Supported Deep Links
```
chrug://workout/days
chrug://workout/day/:{dayId}
chrug://workout/exercise/{exerciseId}

chrug://nutrition/food-log
chrug://nutrition/add-food

chrug://ai-coach
chrug://ai-coach/chat/{chatId}

chrug://profile
chrug://profile/uploads
chrug://profile/measurements
chrug://profile/integrations

chrug://program/select/{programId}
chrug://program/create
chrug://program/change
```

---

## Modal & Sheet Layer Architecture

### Z-Index (Stacking Order, Top to Bottom)
1. **Toast Notifications** (top)
2. **Alert Dialogs** (confirm/alert)
3. **Bottom Sheets** (half-screen modals)
4. **Full-Screen Modals** (navigation modals)
5. **Floating UI** (rest timer pill)
6. **Sidebar/Drawer Overlays**
7. **Main Screen Content** (bottom)

---

## Screen Dimensions & Breakpoints

### Target Devices
- **iPhone 14, 14 Pro, 15, 15 Pro** (primary, 6.1" and 6.7")
- Safe area top: 44-47pt
- Safe area bottom: 34pt
- Tab bar height: 83pt (including safe area)

### Standard Widths & Padding
- Full screen: 390pt (default iPhone width)
- Content padding: 16pt (left/right)
- Card corners: 12pt radius
- Modal corner radius: 20pt (top corners)

---

## Navigation Performance Notes

### Lazy Loading
- SelectExerciseModal: exercise library loads on-demand (filtered)
- ChatHistorySidebar: chat list loaded once on first open
- ProfileSidebar: submenu screens not pre-loaded

### Memory Management
- ExerciseDetailsScreen: reset state on unmount
- AddSetModalSheet: discard unsaved data on close
- RestTimerPill: cleanup timer on unmount

---

## Accessibility Considerations

### Tab Navigation
- All interactive elements have adequate tap targets (44pt minimum)
- Form inputs have clear labels
- Buttons have descriptive text (not just icons)

### Text
- Standard font sizes: 16pt (body), 18-20pt (headings)
- High contrast: dark text on light backgrounds
- Error messages in red (#E63946)
- Success messages in green (#06A77D)

### Semantic Structure
- Use semantic HTML where applicable
- Proper heading hierarchy (H1, H2, H3)
- Image alt text on all icons/images


# API_SPEC.md — Chrug MVP Phase 1

## Overview

**Phase 1 Status:** No API calls. All data is local (SQLite + SharedPreferences).

**Phase 2 Status:** Supabase + FastAPI backend will be integrated. This document specifies the API contracts for Phase 2 preparation.

---

## Phase 1: No API

All features work **100% offline**. No network calls are made in Phase 1:
- Authentication: Mocked locally
- Workouts: Logged locally
- Nutrition: Stored locally
- AI Coach: Mock responses (hardcoded)
- Wearables: Integration dialogs mocked (no actual sync)

---

## Phase 2: Planned API Architecture

### Backend Stack
- **Database:** Supabase (Postgres)
- **API:** Supabase Edge Functions (serverless) OR FastAPI on Fly.io
- **AI:** Claude API (coaching, vision, parsing)

### Auth Endpoints (Supabase Auth)

#### **POST /auth/signup**
```
Request:
{
  "email": "user@example.com",
  "password": "securePassword123"
}

Response:
{
  "user": {
    "id": "user_uuid",
    "email": "user@example.com",
    "user_metadata": {}
  },
  "session": {
    "access_token": "jwt_token",
    "refresh_token": "refresh_token"
  }
}

Error (400):
{
  "error": "User already exists"
}
```

#### **POST /auth/email/otp**
```
Request:
{
  "email": "user@example.com",
  "type": "signup" | "signin"
}

Response:
{
  "success": true
}

Implementation: Supabase Auth native OTP flow
```

#### **POST /auth/verify-otp**
```
Request:
{
  "email": "user@example.com",
  "token": "123456",
  "type": "signup" | "signin"
}

Response:
{
  "user": { ... },
  "session": { ... }
}
```

#### **POST /auth/apple-signin**
```
Request:
{
  "identityToken": "apple_identity_token",
  "nonce": "nonce_string"
}

Response:
{
  "user": { ... },
  "session": { ... }
}

Implementation: Supabase + Apple Sign-In (native iOS flow)
```

#### **POST /auth/logout**
```
Request:
{
  "access_token": "jwt_token"
}

Response:
{
  "success": true
}
```

---

### Program Endpoints

#### **GET /programs**
```
Request:
Authorization: Bearer {jwt_token}

Response:
{
  "programs": [
    {
      "program_id": "prog_1",
      "name": "Push/Pull/Legs",
      "description": "...",
      "days": [ ... ],
      "is_active": true,
      "created_at": "2025-01-30T00:00:00Z"
    },
    ...
  ]
}
```

#### **POST /programs**
```
Request:
Authorization: Bearer {jwt_token}
{
  "name": "Push/Pull/Legs",
  "description": "...",
  "days": [
    {
      "day_number": 1,
      "day_name": "Push",
      "exercise_ids": ["ex_1", "ex_2", "ex_3"]
    },
    ...
  ]
}

Response:
{
  "program_id": "prog_123",
  "name": "Push/Pull/Legs",
  "created_at": "2025-01-30T00:00:00Z"
}
```

#### **GET /programs/{programId}**
```
Request:
Authorization: Bearer {jwt_token}

Response:
{
  "program_id": "prog_1",
  "name": "Push/Pull/Legs",
  "days": [
    {
      "day_id": "day_1",
      "day_number": 1,
      "day_name": "Push",
      "exercises": [
        {
          "exercise_id": "ex_1",
          "name": "Bench Press",
          "category": "Chest",
          ...
        },
        ...
      ]
    },
    ...
  ]
}
```

#### **PUT /programs/{programId}**
```
Request:
Authorization: Bearer {jwt_token}
{
  "name": "Updated Program Name",
  "days": [ ... ]
}

Response:
{ "success": true }
```

#### **DELETE /programs/{programId}**
```
Request:
Authorization: Bearer {jwt_token}

Response:
{ "success": true }
```

---

### Workout (Sets) Endpoints

#### **POST /workouts/sets**
```
Request:
Authorization: Bearer {jwt_token}
{
  "exercise_id": "ex_1",
  "day_id": "day_1",
  "reps": 8,
  "weight_kg": 185.0,
  "reps_in_reserve": 2,
  "tempo_variation": "Normal",
  "notes": "Felt strong",
  "timestamp": "2025-01-30T14:30:00Z"
}

Response:
{
  "set_id": "set_abc123",
  "synced_at": "2025-01-30T14:30:15Z"
}
```

#### **GET /workouts/sets?date=2025-01-30**
```
Request:
Authorization: Bearer {jwt_token}

Response:
{
  "sets": [
    {
      "set_id": "set_1",
      "exercise_id": "ex_1",
      "reps": 8,
      "weight_kg": 185.0,
      "timestamp": "2025-01-30T14:30:00Z"
    },
    ...
  ]
}
```

#### **DELETE /workouts/sets/{setId}**
```
Request:
Authorization: Bearer {jwt_token}

Response:
{ "success": true }
```

---

### Nutrition Endpoints

#### **POST /nutrition/foods**
```
Request:
Authorization: Bearer {jwt_token}
{
  "name": "Chicken Breast (Cooked)",
  "calories_per_100g": 165,
  "protein_g_per_100g": 31,
  "carbs_g_per_100g": 0,
  "fat_g_per_100g": 3.6
}

Response:
{
  "food_id": "food_xyz",
  "created_at": "2025-01-30T00:00:00Z"
}
```

#### **GET /nutrition/foods?search=chicken**
```
Request:
Authorization: Bearer {jwt_token}

Response:
{
  "foods": [
    {
      "food_id": "food_1",
      "name": "Chicken Breast (Cooked)",
      "calories_per_100g": 165,
      "protein_g_per_100g": 31,
      ...
    },
    ...
  ]
}
```

#### **POST /nutrition/meals**
```
Request:
Authorization: Bearer {jwt_token}
{
  "meal_date": "2025-01-30",
  "meal_name": "Breakfast",
  "foods": [
    {
      "food_id": "food_1",
      "quantity_grams": 200
    },
    ...
  ]
}

Response:
{
  "meal_id": "meal_123",
  "total_calories": 330,
  "total_protein_g": 62,
  "created_at": "2025-01-30T07:30:00Z"
}
```

#### **GET /nutrition/meals?date=2025-01-30**
```
Request:
Authorization: Bearer {jwt_token}

Response:
{
  "meals": [
    {
      "meal_id": "meal_1",
      "meal_name": "Breakfast",
      "foods": [ ... ],
      "total_calories": 330,
      "total_protein_g": 62,
      "total_carbs_g": 0,
      "total_fat_g": 7.2,
      "created_at": "2025-01-30T07:30:00Z"
    },
    ...
  ]
}
```

---

### AI Coach Endpoints

#### **POST /ai/chat**
```
Request:
Authorization: Bearer {jwt_token}
{
  "message": "Should I deload?",
  "chat_id": "chat_123" (optional, for continuing conversation),
  "user_context": {
    "recent_training": [ ... ],
    "nutrition_data": { ... },
    "wearable_data": { ... }
  }
}

Response:
{
  "message_id": "msg_456",
  "chat_id": "chat_123",
  "role": "assistant",
  "content": "Based on your training history, consider a deload week...",
  "sources": [
    {
      "type": "study",
      "doi": "10.1234/example",
      "title": "Study Title"
    }
  ],
  "timestamp": "2025-01-30T14:35:00Z"
}
```

#### **GET /ai/chats**
```
Request:
Authorization: Bearer {jwt_token}

Response:
{
  "chats": [
    {
      "chat_id": "chat_1",
      "title": "Should I deload?",
      "messages": [
        { "role": "user", "content": "..." },
        { "role": "assistant", "content": "..." }
      ],
      "created_at": "2025-01-30T14:30:00Z"
    },
    ...
  ]
}
```

#### **POST /ai/vision/form-review**
```
Request:
Authorization: Bearer {jwt_token}
Content-Type: multipart/form-data
{
  "video": <binary video file>,
  "exercise_id": "ex_1"
}

Response:
{
  "exercise_id": "ex_1",
  "feedback": {
    "depth": "Full range of motion achieved",
    "form": "Slight elbow flare on reps 2-3, consider tucking elbows",
    "technique_score": 8.5,
    "areas_for_improvement": ["Elbow position"]
  },
  "timestamp": "2025-01-30T14:40:00Z"
}
```

---

### Profile Endpoints

#### **GET /users/me**
```
Request:
Authorization: Bearer {jwt_token}

Response:
{
  "user_id": "user_uuid",
  "email": "user@example.com",
  "name": "Jimmy Chen",
  "height_cm": 178,
  "weight_kg": 85,
  "birth_date": "1990-01-15",
  "gender": "Male",
  "profile_picture_url": "https://...",
  "created_at": "2025-01-30T00:00:00Z"
}
```

#### **PUT /users/me**
```
Request:
Authorization: Bearer {jwt_token}
{
  "name": "James Chen",
  "height_cm": 180,
  "weight_kg": 87,
  "birth_date": "1990-01-15",
  "gender": "Male"
}

Response:
{ "success": true }
```

---

### Measurements Endpoints

#### **POST /measurements**
```
Request:
Authorization: Bearer {jwt_token}
{
  "measurement_date": "2025-01-30",
  "neck_cm": 38.5,
  "shoulders_cm": 122,
  "chest_cm": 108,
  "waist_cm": 82,
  ...
}

Response:
{
  "measurement_id": "meas_123",
  "created_at": "2025-01-30T00:00:00Z"
}
```

#### **GET /measurements?period=monthly**
```
Request:
Authorization: Bearer {jwt_token}

Response:
{
  "measurements": [
    {
      "measurement_id": "meas_1",
      "measurement_date": "2025-01-30",
      "neck_cm": 38.5,
      ...
    },
    ...
  ]
}
```

---

### Wearable Integration Endpoints

#### **GET /integrations/authorize/{integrationName}**
```
Request:
Authorization: Bearer {jwt_token}

Example:
GET /integrations/authorize/whoop

Response (redirect):
{
  "authorization_url": "https://whoop.com/oauth/authorize?client_id=..."
}
```

#### **POST /integrations/sync/{integrationName}**
```
Request:
Authorization: Bearer {jwt_token}

Response:
{
  "integration": "whoop",
  "synced_at": "2025-01-30T14:45:00Z",
  "data": {
    "recovery_score": 75,
    "strain": 8.2,
    "sleep": { ... }
  }
}
```

#### **GET /integrations/status**
```
Request:
Authorization: Bearer {jwt_token}

Response:
{
  "integrations": [
    {
      "name": "whoop",
      "is_connected": true,
      "last_synced_at": "2025-01-30T14:45:00Z",
      "sync_error": null
    },
    ...
  ]
}
```

---

### Error Responses

#### **400 Bad Request**
```json
{
  "error": "Invalid input",
  "details": {
    "field": "email",
    "message": "Invalid email format"
  }
}
```

#### **401 Unauthorized**
```json
{
  "error": "Invalid or expired token"
}
```

#### **403 Forbidden**
```json
{
  "error": "You do not have permission to access this resource"
}
```

#### **404 Not Found**
```json
{
  "error": "Resource not found",
  "resource": "program_123"
}
```

#### **429 Rate Limited**
```json
{
  "error": "Too many requests",
  "retry_after": 60
}
```

#### **500 Internal Server Error**
```json
{
  "error": "Internal server error",
  "error_id": "err_abc123"
}
```

---

## Rate Limiting (Phase 2)

### Limits
- **Auth:** 5 attempts per email per 15 minutes
- **Workouts:** 1000 sets per user per day
- **Nutrition:** 1000 foods logged per user per day
- **Chat:** 100 messages per user per day
- **General:** 600 requests per minute per user

### Headers
```
X-RateLimit-Limit: 600
X-RateLimit-Remaining: 599
X-RateLimit-Reset: 1704067200
```

---

## Sync Strategy (Phase 2)

### Client-Initiated Sync
```
1. User opens app
2. Check if internet available
3. If connected: call /sync endpoint
4. Backend returns: changes since last sync
5. Client merges with local data (conflict resolution)
6. Mark local records as "synced"
```

### Conflict Resolution
- **Sets:** Last-write-wins (by timestamp)
- **Programs:** Client keeps local version (user trust)
- **Meals:** Last-write-wins
- **Measurements:** Last-write-wins

### Offline Queue (Sync Queue)
```dart
class SyncItem {
  String id;
  String entityType; // "set", "meal", "program"
  String operation; // "create", "update", "delete"
  DateTime timestamp;
  bool isSynced;
  String? syncError;
}
```

---

## WebSocket Streaming (Optional Phase 2+)

For real-time multi-device sync, optional WebSocket connection:

```
POST /ws/connect
Authorization: Bearer {jwt_token}

Events:
{
  "type": "set_recorded",
  "data": { ... }
}

{
  "type": "meal_added",
  "data": { ... }
}
```

---

## API Documentation (Phase 2)

Recommended tools:
- **OpenAPI 3.0** (Swagger) for REST endpoints
- **GraphQL** (optional, alternative to REST)
- **Postman** collection for manual testing

Example OpenAPI spec will be generated from Supabase + FastAPI auto-documentation.

---

## Testing API (Phase 2)

### Unit Tests
```dart
test('POST /programs creates program', () async {
  final response = await client.post(
    '/programs',
    headers: {'Authorization': 'Bearer $token'},
    body: json.encode({'name': 'Test Program'}),
  );
  expect(response.statusCode, 201);
  expect(response.body, contains('program_id'));
});
```

### Integration Tests
```dart
test('Full workout flow: create program → log set → verify', () async {
  // Create program
  final progRes = await createProgram();
  final programId = progRes['program_id'];

  // Log set
  final setRes = await recordSet(programId: programId, reps: 8);
  expect(setRes.statusCode, 200);

  // Verify
  final getRes = await getSets(date: '2025-01-30');
  expect(getRes.body, contains('8 reps'));
});
```

---

## Performance Targets (Phase 2)

- **Auth:** < 2 seconds (email OTP, Apple Sign-In)
- **Program load:** < 500ms
- **Set logging:** < 100ms (local + queue for sync)
- **Meal search:** < 300ms
- **Chat response:** < 5 seconds (LLM latency)
- **Sync:** < 2 seconds (typical)

---

## Migration from Phase 1 → Phase 2

1. **Auth service:** Replace mock with Supabase Auth
2. **Program service:** Add API calls to `/programs` endpoints
3. **Workout service:** Add API calls to `/workouts/sets` endpoints
4. **Nutrition service:** Add API calls to `/nutrition` endpoints
5. **Sync engine:** Implement SyncQueue, conflict resolution
6. **AI Coach:** Replace hardcoded responses with `/ai/chat` API
7. **Error handling:** Add network error recovery, retry logic

**No UI changes needed** (API layer abstraction is transparent to Flutter UI).


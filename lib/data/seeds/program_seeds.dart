import 'package:drift/drift.dart';
import '../database/app_database.dart';

Future<void> seedPrograms(AppDatabase db) async {
  final now = DateTime.now().toIso8601String();

  Future<void> insertDay(String dayId, String programId, int dayNumber, String dayName) async {
    await db.into(db.days).insert(DaysCompanion(dayId: Value(dayId), programId: Value(programId), dayNumber: Value(dayNumber), dayName: Value(dayName), createdAt: Value(now), updatedAt: Value(now)));
  }

  Future<void> insertDE(String id, String dayId, String exId, int order) async {
    await db.workoutDao.insertDayExercise(DayExercisesCompanion(id: Value(id), dayId: Value(dayId), exerciseId: Value(exId), exerciseOrder: Value(order), createdAt: Value(now)));
  }

  // PPL (active)
  await db.programDao.insertProgram(ProgramsCompanion(programId: const Value('prog_ppl'), userId: const Value('local_user'), name: const Value('Push / Pull / Legs'), description: const Value('Classic 3-day split targeting push muscles, pull muscles, and legs.'), isActive: const Value(true), createdAt: Value(now), updatedAt: Value(now)));
  await insertDay('day_ppl_push', 'prog_ppl', 1, 'Push');
  await insertDay('day_ppl_pull', 'prog_ppl', 2, 'Pull');
  await insertDay('day_ppl_legs', 'prog_ppl', 3, 'Legs');
  await insertDE('de_ppl_1', 'day_ppl_push', 'ex_barbell_bench_press', 1);
  await insertDE('de_ppl_2', 'day_ppl_push', 'ex_incline_dumbbell_press', 2);
  await insertDE('de_ppl_3', 'day_ppl_push', 'ex_cable_flye', 3);
  await insertDE('de_ppl_4', 'day_ppl_push', 'ex_overhead_press', 4);
  await insertDE('de_ppl_5', 'day_ppl_push', 'ex_tricep_pushdown', 5);
  await insertDE('de_ppl_6', 'day_ppl_pull', 'ex_barbell_row', 1);
  await insertDE('de_ppl_7', 'day_ppl_pull', 'ex_lat_pulldown', 2);
  await insertDE('de_ppl_8', 'day_ppl_pull', 'ex_face_pull', 3);
  await insertDE('de_ppl_9', 'day_ppl_pull', 'ex_barbell_curl', 4);
  await insertDE('de_ppl_10', 'day_ppl_pull', 'ex_hammer_curl', 5);
  await insertDE('de_ppl_11', 'day_ppl_legs', 'ex_barbell_back_squat', 1);
  await insertDE('de_ppl_12', 'day_ppl_legs', 'ex_leg_press', 2);
  await insertDE('de_ppl_13', 'day_ppl_legs', 'ex_lying_leg_curl', 3);
  await insertDE('de_ppl_14', 'day_ppl_legs', 'ex_standing_calf_raise', 4);
  await insertDE('de_ppl_15', 'day_ppl_legs', 'ex_barbell_lunge', 5);

  // Sample bench sets
  await db.transaction(() async {
    for (final s in [('set_bp_1',8,83.9,2), ('set_bp_2',6,88.5,1), ('set_bp_3',5,88.5,0), ('set_bp_4',8,79.4,2), ('set_bp_5',10,74.8,3)]) {
      await db.workoutDao.insertSet(SetsCompanion(setId: Value(s.$1), exerciseId: const Value('ex_barbell_bench_press'), dayId: const Value('day_ppl_push'), reps: Value(s.$2), weightKg: Value(s.$3), repsInReserve: Value(s.$4), timestamp: Value(now)));
    }
  });

  // Upper/Lower
  await db.programDao.insertProgram(ProgramsCompanion(programId: const Value('prog_ul'), userId: const Value('local_user'), name: const Value('Upper / Lower'), description: const Value('4-day split alternating upper and lower body workouts.'), isActive: const Value(false), createdAt: Value(now), updatedAt: Value(now)));
  await insertDay('day_ul_ua', 'prog_ul', 1, 'Upper A');
  await insertDay('day_ul_la', 'prog_ul', 2, 'Lower A');
  await insertDay('day_ul_ub', 'prog_ul', 3, 'Upper B');
  await insertDay('day_ul_lb', 'prog_ul', 4, 'Lower B');
  await insertDE('de_ul_1', 'day_ul_ua', 'ex_barbell_bench_press', 1);
  await insertDE('de_ul_2', 'day_ul_ua', 'ex_barbell_row', 2);
  await insertDE('de_ul_3', 'day_ul_ua', 'ex_overhead_press', 3);
  await insertDE('de_ul_4', 'day_ul_ua', 'ex_barbell_curl', 4);
  await insertDE('de_ul_5', 'day_ul_ua', 'ex_tricep_pushdown', 5);
  await insertDE('de_ul_6', 'day_ul_la', 'ex_barbell_back_squat', 1);
  await insertDE('de_ul_7', 'day_ul_la', 'ex_romanian_deadlift', 2);
  await insertDE('de_ul_8', 'day_ul_la', 'ex_leg_press', 3);
  await insertDE('de_ul_9', 'day_ul_la', 'ex_lying_leg_curl', 4);
  await insertDE('de_ul_10', 'day_ul_la', 'ex_standing_calf_raise', 5);
  await insertDE('de_ul_11', 'day_ul_ub', 'ex_incline_dumbbell_press', 1);
  await insertDE('de_ul_12', 'day_ul_ub', 'ex_lat_pulldown', 2);
  await insertDE('de_ul_13', 'day_ul_ub', 'ex_dumbbell_lateral_raise', 3);
  await insertDE('de_ul_14', 'day_ul_ub', 'ex_hammer_curl', 4);
  await insertDE('de_ul_15', 'day_ul_ub', 'ex_overhead_tricep_extension', 5);
  await insertDE('de_ul_16', 'day_ul_lb', 'ex_conventional_deadlift', 1);
  await insertDE('de_ul_17', 'day_ul_lb', 'ex_barbell_front_squat', 2);
  await insertDE('de_ul_18', 'day_ul_lb', 'ex_hip_thrust', 3);
  await insertDE('de_ul_19', 'day_ul_lb', 'ex_leg_extension', 4);
  await insertDE('de_ul_20', 'day_ul_lb', 'ex_seated_calf_raise', 5);

  // Full Body
  await db.programDao.insertProgram(ProgramsCompanion(programId: const Value('prog_fb'), userId: const Value('local_user'), name: const Value('Full Body'), description: const Value('3-day full body program hitting every major muscle group each session.'), isActive: const Value(false), createdAt: Value(now), updatedAt: Value(now)));
  await insertDay('day_fb_1', 'prog_fb', 1, 'Full Body A');
  await insertDay('day_fb_2', 'prog_fb', 2, 'Full Body B');
  await insertDay('day_fb_3', 'prog_fb', 3, 'Full Body C');
  await insertDE('de_fb_1', 'day_fb_1', 'ex_barbell_bench_press', 1);
  await insertDE('de_fb_2', 'day_fb_1', 'ex_barbell_back_squat', 2);
  await insertDE('de_fb_3', 'day_fb_1', 'ex_barbell_row', 3);
  await insertDE('de_fb_4', 'day_fb_1', 'ex_overhead_press', 4);
  await insertDE('de_fb_5', 'day_fb_1', 'ex_barbell_curl', 5);
  await insertDE('de_fb_6', 'day_fb_1', 'ex_plank', 6);
  await insertDE('de_fb_7', 'day_fb_2', 'ex_conventional_deadlift', 1);
  await insertDE('de_fb_8', 'day_fb_2', 'ex_incline_dumbbell_press', 2);
  await insertDE('de_fb_9', 'day_fb_2', 'ex_lat_pulldown', 3);
  await insertDE('de_fb_10', 'day_fb_2', 'ex_dumbbell_lateral_raise', 4);
  await insertDE('de_fb_11', 'day_fb_2', 'ex_tricep_pushdown', 5);
  await insertDE('de_fb_12', 'day_fb_2', 'ex_standing_calf_raise', 6);
  await insertDE('de_fb_13', 'day_fb_3', 'ex_barbell_front_squat', 1);
  await insertDE('de_fb_14', 'day_fb_3', 'ex_dumbbell_bench_press', 2);
  await insertDE('de_fb_15', 'day_fb_3', 'ex_cable_row', 3);
  await insertDE('de_fb_16', 'day_fb_3', 'ex_face_pull', 4);
  await insertDE('de_fb_17', 'day_fb_3', 'ex_hammer_curl', 5);
  await insertDE('de_fb_18', 'day_fb_3', 'ex_hanging_leg_raise', 6);

  // Bro Split
  await db.programDao.insertProgram(ProgramsCompanion(programId: const Value('prog_bro'), userId: const Value('local_user'), name: const Value('Bro Split'), description: const Value('Classic 5-day bodybuilding split with one muscle group per day.'), isActive: const Value(false), createdAt: Value(now), updatedAt: Value(now)));
  await insertDay('day_bro_ch', 'prog_bro', 1, 'Chest');
  await insertDay('day_bro_bk', 'prog_bro', 2, 'Back');
  await insertDay('day_bro_sh', 'prog_bro', 3, 'Shoulders');
  await insertDay('day_bro_ar', 'prog_bro', 4, 'Arms');
  await insertDay('day_bro_lg', 'prog_bro', 5, 'Legs');
  await insertDE('de_bro_1', 'day_bro_ch', 'ex_barbell_bench_press', 1);
  await insertDE('de_bro_2', 'day_bro_ch', 'ex_incline_dumbbell_press', 2);
  await insertDE('de_bro_3', 'day_bro_ch', 'ex_cable_flye', 3);
  await insertDE('de_bro_4', 'day_bro_ch', 'ex_dip', 4);
  await insertDE('de_bro_5', 'day_bro_ch', 'ex_pec_deck', 5);
  await insertDE('de_bro_6', 'day_bro_bk', 'ex_conventional_deadlift', 1);
  await insertDE('de_bro_7', 'day_bro_bk', 'ex_barbell_row', 2);
  await insertDE('de_bro_8', 'day_bro_bk', 'ex_lat_pulldown', 3);
  await insertDE('de_bro_9', 'day_bro_bk', 'ex_seated_cable_row', 4);
  await insertDE('de_bro_10', 'day_bro_bk', 'ex_straight_arm_pulldown', 5);
  await insertDE('de_bro_11', 'day_bro_sh', 'ex_overhead_press', 1);
  await insertDE('de_bro_12', 'day_bro_sh', 'ex_dumbbell_lateral_raise', 2);
  await insertDE('de_bro_13', 'day_bro_sh', 'ex_face_pull', 3);
  await insertDE('de_bro_14', 'day_bro_sh', 'ex_rear_delt_flye', 4);
  await insertDE('de_bro_15', 'day_bro_sh', 'ex_cable_lateral_raise', 5);
  await insertDE('de_bro_16', 'day_bro_ar', 'ex_barbell_curl', 1);
  await insertDE('de_bro_17', 'day_bro_ar', 'ex_skull_crusher', 2);
  await insertDE('de_bro_18', 'day_bro_ar', 'ex_hammer_curl', 3);
  await insertDE('de_bro_19', 'day_bro_ar', 'ex_tricep_pushdown', 4);
  await insertDE('de_bro_20', 'day_bro_ar', 'ex_preacher_curl', 5);
  await insertDE('de_bro_21', 'day_bro_lg', 'ex_barbell_back_squat', 1);
  await insertDE('de_bro_22', 'day_bro_lg', 'ex_leg_press', 2);
  await insertDE('de_bro_23', 'day_bro_lg', 'ex_romanian_deadlift', 3);
  await insertDE('de_bro_24', 'day_bro_lg', 'ex_leg_extension', 4);
  await insertDE('de_bro_25', 'day_bro_lg', 'ex_standing_calf_raise', 5);
}

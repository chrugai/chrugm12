const String aiFallbackResponse = "That's a great question. Based on general fitness principles, I'd recommend focusing on consistency with your training and nutrition. If you have a specific concern, feel free to ask and I'll give you a more detailed recommendation.";

Map<String, String> getAiResponses() => const {
  'deload': 'A deload week every 4-6 weeks is a smart strategy. Reduce your working weight by 40-50% and keep the same rep scheme. This allows your joints and CNS to recover while maintaining movement patterns. You\'ll come back stronger.',
  'protein': 'For muscle growth, aim for 1.6-2.2g of protein per kg of bodyweight daily. At your weight of 85kg, that\'s roughly 136-187g per day. Spread it across 4-5 meals for optimal absorption. Prioritize whole food sources like chicken, fish, eggs, and dairy.',
  'bulk': 'For a lean bulk, target a caloric surplus of 250-350 calories above your maintenance. This minimizes fat gain while supporting muscle growth. Weigh yourself weekly and aim for 0.25-0.5% bodyweight gain per week.',
  'cut': 'For an effective cut, create a deficit of 400-600 calories below maintenance. Keep protein high (2g/kg) to preserve muscle. Reduce carbs and fats proportionally. Expect to lose 0.5-1% of bodyweight per week.',
  'plateau': 'Plateaus are normal and usually signal a need for periodization. Try changing your rep ranges, increase training volume by one set per exercise, or introduce a new exercise variation to spark fresh adaptation.',
  'sore': 'Muscle soreness (DOMS) is normal, especially with new movements. Light activity and blood flow work can help recovery. Ensure adequate sleep (7-9 hours), hydration, and protein intake.',
  'sleep': 'Sleep is the most underrated recovery tool. Aim for 7-9 hours of quality sleep. Keep your room cool and dark, avoid screens 30 minutes before bed, and maintain a consistent sleep schedule.',
  'creatine': 'Creatine monohydrate is one of the most researched and effective supplements. Take 3-5g daily — no loading phase needed. It increases phosphocreatine stores, improving performance on high-intensity sets.',
  'form': 'Good form is non-negotiable for long-term progress. Film yourself from the side and compare to reference videos. Key cues: maintain a neutral spine, control the eccentric phase, and use a full range of motion.',
  'rest': 'Rest periods depend on your goal. For strength (1-5 reps), rest 3-5 minutes. For hypertrophy (6-12 reps), rest 60-120 seconds. For endurance (15+ reps), rest 30-60 seconds.',
  'warm up': 'Start with 5 minutes of light cardio to raise your body temperature. Then do 2-3 warm-up sets of your first exercise at 50%, 65%, and 80% of your working weight.',
  'stretch': 'Static stretching is best post-workout when muscles are warm. Hold each stretch for 30-60 seconds. For pre-workout, use dynamic stretches like leg swings and arm circles.',
  'calories': 'Your maintenance calories depend on your weight, activity level, and metabolism. A good starting estimate is bodyweight in kg times 30-35. Track your weight for 2 weeks and adjust based on the trend.',
  'supplements': 'The essentials are creatine monohydrate (3-5g/day), vitamin D (2000-5000 IU if deficient), and omega-3s (1-2g EPA+DHA). A protein powder can help hit daily targets.',
  'cardio': 'Cardio doesn\'t kill gains if programmed correctly. 2-3 sessions of 20-30 minutes of low-intensity steady-state per week supports cardiovascular health without interfering with recovery.',
  'injury': 'If you suspect an injury, stop the exercise immediately. Apply the RICE protocol for acute issues. For persistent pain lasting more than a week, consult a physiotherapist.',
  'motivation': 'Motivation is unreliable — build systems instead. Set a fixed training schedule, prep your gym bag the night before, and track every session. Small wins compound.',
  'water': 'Aim for 0.03-0.04 liters per kg of bodyweight daily, plus 500ml for every hour of exercise. Dehydration as small as 2% can impair performance.',
  'frequency': 'Training each muscle group 2x per week is optimal for most people. A Push/Pull/Legs split run 6 days, or Upper/Lower run 4 days, both achieve this.',
  'progressive overload': 'Progressive overload is the core driver of muscle growth. Add weight in small increments, add reps within your target range, or add sets over time. Track everything.',
};

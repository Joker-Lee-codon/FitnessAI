# FitnessAI iPhone Design Direction — Training Ledger

## Product reading

FitnessAI is not a workout-content feed or a live coaching dashboard. Apple Watch owns the active session. The iPhone owns planning, complete post-session correction, history, evidence, and recovery. The interface must make every important workout fact understandable as planned, captured, confirmed, corrected, or pending.

## Design idea

The visual system is a **training ledger** organized around a continuous **training rail**. An outlined tick represents a planned set; a solid tick represents an actual set; a split or interrupted tick represents a fact that still needs resolution. The rail keeps plan, performance, and provenance in one reading path instead of distributing them across generic cards.

## Tokens

| Role | Token | Value |
|---|---|---|
| App canvas | Warm paper | `#F7F6F2` |
| Structural surface | Soft white | `#FCFBF8` |
| Primary structure | Ink | `#343330` |
| Primary action | Deep ink | `#2F2E2B` |
| Training accent | Muted clay | `#93634F` |
| Needs correction | Brick | `#A64B43` |
| Confirmed fact | Sage | `#5F756D` |
| Primary text | Graphite | `#242321` |

The palette takes its tonal relationship from Claude's web interface: near-white warm surfaces, true dark actions, warm neutral copy, and a restrained clay accent. FitnessAI keeps clay for training state, brick for unresolved facts, and sage for confirmed facts so meaning is not borrowed from another product. Dark appearance uses warm charcoal surfaces and lighter mineral variants of the same semantic colors. Status never depends on color alone.

## Typography

- Chinese interface text: `PingFang SC`, using native iOS text metrics.
- Workout numbers: `DIN Alternate`, tabular where available, used only for load, repetitions, duration, and dates.
- Titles remain sentence case. There are no tracked uppercase eyebrows or decorative monospace labels.

## Layout

- Content is left aligned. Numbers align by decimal or trailing edge inside set rows.
- Horizontal spacing and display type scale fluidly from 320 to 430 pt. Set rows recompose below 360 pt instead of shrinking the entire interface.
- The full-height shell uses dynamic and small viewport units, iPhone safe-area insets, and a separate short-landscape reading width so browser chrome and device cutouts do not hide controls.
- The Today view begins with the next useful action, not a generic KPI hero.
- Exercises form chapters on one continuous vertical rail. Set facts are rows on that rail rather than repeated floating cards.
- The bottom navigation exposes Today, History, and Analysis. Review, plan detail, sync/recovery, and settings are contextual routes.

```text
Today                                    Sep 7
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Chest & back A                     about 58 min
  ○ planned    Bench press · 4 sets
  ● actual     3 sets completed
  │
  ○            Bent-over row · 4 sets
  │
  ○            Incline dumbbell press · 3 sets

[ Start on Watch ]                 Sent to Watch
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Today                 History                 Analysis
```

```text
Session review                         1 pending
Bench press
  ● Set 1     8 reps     60 kg        Confirmed
  ● Set 2     8 reps     60 kg        Watch capture
  ◐ Set 3     7 reps      —           Add load
               [60] [62.5] [Other]

[ Save review ]
```

## Interaction and motion

- The only signature motion is an actual-set tick settling onto the rail after a successful local commit.
- Editing preserves the rest of the set in place; correcting an exercise never visually discards repetitions, load, RPE, timing, or order.
- Focus moves in consequence order: retained facts, unresolved field, choices, save result.
- Reduce Motion removes the settling animation. All actions have visible keyboard focus and at least a 44 pt target.

## Self-review and revision

The first impulse was a familiar fitness dashboard with a large weekly number, gradient accent, and metric cards. That treatment was removed because it makes the product look like a generic activity tracker and hides its differentiator: trustworthy, recoverable workout facts. The revised system spends its visual boldness on the training rail and keeps color, shape, and motion restrained everywhere else.

The initial palette leaned toward cool cast-iron blue. After review against the requested Claude web reference, it was revised to warm paper, deep ink, and a restrained clay accent. Unlike a direct Claude imitation, the clay is not the whole identity: the training rail and provenance states remain the distinguishing system, with separate sage and brick semantics for trust-critical workout facts.

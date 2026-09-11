# iPhone — Analysis

## 1. Purpose and Authority

Explains weekly/monthly training evidence from effective Actual Sets and selected primary Exercise trends, without mutating Training Plans automatically.

## 2. Entry and Exit

- Entry: Analysis tab, History drill-down, Exercise trend route.
- Exit: change period/Exercise, inspect exact point/data table, review excluded session, deliberately edit next plan.

## 3. Composition

1. Period and selected Exercise.
2. Literal conclusion (“负重上升，完成次数稳定”).
3. Direct-labelled trend chart.
4. Session/set/volume metrics derived from Actual Sets.
5. Exclusion/stale boundary and data-source note.
6. Decision-oriented next step that does not auto-apply.

## 4. Components

`TrendEvidenceChart`, metric ledger, `FactStateLabel`, exclusion boundary, `SystemStatePanel`.

## 5. Required States

Cold load; empty period; ready; incomplete data excluded/labelled; stale conflict; selected point; calculation failure; offline cached analysis.

## 6. Interaction and Accessibility

Charts provide 44 pt point targets, direct values, VoiceOver summary, and data table. Confirmed/effective inputs are solid; pending/conflicted inputs are dashed/excluded and named. Reduce Motion removes chart drawing. Results never mutate a plan automatically.

## 7. Requirements and Flows

FR-037–FR-040, FR-046, FR-063; UJ-2.

## 8. Preview and Validation

Preview: `../previews/iphone-core-pages-review.png`, screen 05. Validate empty/stale/error, exact point inspection, table alternative, Reduce Motion, and excluded incomplete session.

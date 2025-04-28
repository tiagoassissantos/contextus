# User Story 4.4: Distinguish Local vs External Dependencies

**Priority:** Medium

## Description
As a Developer, I want the system to distinguish between local project dependencies and external package/library dependencies so that I can manage them separately.

## Tasks
- [ ] Enhance dependency identification logic (US 2.3, US 2.8, US 4.1) to classify dependencies as 'local' (part of the analyzed project) or 'external' (third-party).
  - Assigned to: [Developer Name]
  - Due date: YYYY-MM-DD
- [ ] Update storage schema (US 3.1) and data structures to store this classification.
  - Assigned to: [Developer Name]
  - Due date: YYYY-MM-DD
- [ ] Ensure query mechanisms (US 4.2, US 4.3) can potentially use or return this classification.
  - Assigned to: [Developer Name]
  - Due date: YYYY-MM-DD

## Notes
Helps differentiate between internal code coupling and reliance on outside libraries.

## Acceptance Criteria
- Each identified dependency relationship is tagged as either 'local' or 'external'.
- External dependencies correctly map to third-party libraries/packages identified (e.g., from lockfiles).
- Local dependencies correctly map to other files/modules within the project.
- Query results (US 4.6) can optionally reflect this distinction.

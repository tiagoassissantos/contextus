# User Story 3.6: Force Full Rescan

**Priority:** Medium

## Description
As a Developer, I want the option to force a full rescan of the codebase when needed so that I can refresh the system’s understanding after major updates.

## Tasks
- [ ] Implement a command-line flag or configuration option to trigger a full rescan
  - Assigned to: [Developer Name]
  - Due date: YYYY-MM-DD
- [ ] Ensure the full rescan bypasses incremental logic and analyzes all files
  - Assigned to: [Developer Name]
  - Due date: YYYY-MM-DD
- [ ] Overwrite existing persisted data with the results of the full rescan
  - Assigned to: [Developer Name]
  - Due date: YYYY-MM-DD

## Notes
This provides a way to recover from potential inconsistencies in incremental updates.

## Acceptance Criteria
- A mechanism (e.g., CLI flag `--force-rescan`) exists to initiate a full rescan.
- When triggered, the system ignores existing persisted data state (except for configuration) and analyzes the entire project.
- The persisted data is completely updated based on the full rescan results.

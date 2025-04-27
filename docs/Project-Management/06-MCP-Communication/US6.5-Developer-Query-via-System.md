# User Story 6.5: Developer Query via System

**Priority:** High

## Description
As a Developer, I want to send queries to the LLM through the system and receive enhanced responses based on the retrieved context so that I get precise answers.

## Tasks
- [ ] Define the end-to-end workflow: Developer query -> Editor Agent -> MCP Request -> RAG System -> MCP Response -> Editor Agent -> LLM -> Enhanced Response -> Developer.
  - Assigned to: [Team/Person]
  - Due date: YYYY-MM-DD
- [ ] Ensure the RAG system correctly provides context via MCP (US 6.4) to enable this workflow.
  - Assigned to: [Developer Name]
  - Due date: YYYY-MM-DD
- [ ] (External Task) Editor agent needs to implement logic to call MCP endpoint and integrate context into LLM prompt.
  - Assigned to: [Editor Agent Team]
  - Due date: YYYY-MM-DD

## Notes
This user story describes the primary use case enabled by the MCP integration from the developer's perspective. The RAG system's main role here is fulfilling the MCP contract.

## Acceptance Criteria
- A developer can issue a query (e.g., via an editor agent).
- The editor agent sends a request to the RAG system's MCP endpoint.
- The RAG system retrieves relevant context and sends it back via MCP response.
- (External) The editor agent uses the context to augment the prompt sent to the LLM.
- (External) The developer receives a response from the LLM that is informed by the codebase context provided by the RAG system.

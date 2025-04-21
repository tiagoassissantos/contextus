TC1: Parse valid init
Why: Ensure your argument parser recognizes init and captures the directory.
How: In ExUnit you’d call assert CLI.parse_args(["init","."]) == {:ok, {:init,"."}}.

TC2: Dispatch to init handler
Why: Verify that, once parsed, the CLI invokes the stubbed init function and logs the right message.
How: Use ExUnit.CaptureLog.capture_log(fn -> assert CLI.run({:init,"."}) == :ok end) and check the captured log contains "Initializing Contextus in .".

TC3: End‑to‑end happy path
Why: Confirm the full flow—from main/1 entry point through parsing, dispatch, and logging—works for a correct invocation.
How: Wrap CLI.main(["init","."]) in capture_log and catch_exit to assert exit code 0 and log presence.

TC4: No directory argument
Why: Even if you won’t implement error handling fully yet, defining this test drives you to handle missing args next.
How: Assert parse_args(["init"]) yields {:error, :missing_dir} and main/1 prints usage/help and halts non‑zero.

TC5: Unknown command
Why: Ensures you detect unsupported verbs early.
How: Assert parse_args(["foo","bar"]) yields {:error, :unknown_command, "foo"} and main/1 logs an error and exits non‑zero.
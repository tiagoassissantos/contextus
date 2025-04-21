ExUnit.configure(
  slowest: 10,
  slowest_modules: 5,
  max_failures: 5,
  colors: [enabled: true],
  formatters: [JUnitFormatter, ExUnit.CLIFormatter],
  trace: true
)

ExUnit.start()

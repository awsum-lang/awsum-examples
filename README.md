# awsum-examples

Example programs for the [Awsum](https://awsum-lang.org) programming language (`.aww` files).

## Examples

- [hello/](hello/) — basic string concatenation, helper function, `IO.Stdout.print` + `IO.Args.getArgs`. Reads `argv[1]` via the IO chain, decodes through the platform validator, prints the greeting.

## Running

Install the Awsum compiler (see [awsum-lang/awsum](https://github.com/awsum-lang/awsum)) and ensure `awsum` is on your `PATH`. Then from a checkout:

```bash
awsum run hello/Main.aww --program-type cli -t llvm --stdin < hello/input.txt
```

Replace `-t llvm` with `jvm` / `clr` / `wasm` / `js` to compile through any other backend — the same program produces identical stdout on every target (see the [language guarantees](https://github.com/awsum-lang/awsum/blob/main/docs/principles.md)).

`just test` runs every example through all five backends in one step. `just format` formats every `.aww` in place via `awsum format -i`. `just fix` chains both.

## Related

- Compiler: [awsum-lang/awsum](https://github.com/awsum-lang/awsum)
- VSCode extension: [awsum-lang/awsum-vscode](https://github.com/awsum-lang/awsum-vscode)
- Zed extension: [awsum-lang/awsum-zed](https://github.com/awsum-lang/awsum-zed)
- Tree-sitter grammar: [awsum-lang/tree-sitter-awsum](https://github.com/awsum-lang/tree-sitter-awsum)
- Website: [awsum-lang.org](https://awsum-lang.org)

## License

MIT — see [LICENSE](LICENSE).

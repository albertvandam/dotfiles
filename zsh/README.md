Define local overwrites/updates in ~/.local/zsh_config which shouldn't be committed to git.

Files ending with `.env` is imported in `.zshenv`
Files ending with `.zsh` is imported in `.zshrc`

For example `proxy.env` could contain your proxy configs and would then be imported from `.zshenv`

Note, the `weather` and `forecast` aliases look for a `location.env` file here, exporting current location, for example:

```
export LOCATION=London
```

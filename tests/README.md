# NexusPlay Instant-Kill Test

Experimental branch for identifying whether existing combat skills can produce a one-hit kill under the game's normal server validation.

## Scope
- Does **not** modify `main`.
- Does **not** change Black Flash.
- Does **not** disable cooldowns or server-side checks.
- Records candidate skill configuration and lets the tester compare target HP before/after a normal cast.

Roblox's client-server model means the server remains authoritative for gameplay state; a client-side request only succeeds if the server accepts it.

## Candidates
The first pass focuses on existing NexusPlay combat paths such as Dismantle, Cleave, Fuga, Sukuna, Plunge, Limitless, and Infinite Aura.

## Result
A candidate is considered an "instant-kill candidate" only if a normal cast reduces a valid target from positive HP to zero in the same cast window.

No repository changes are made to `main` by this branch.

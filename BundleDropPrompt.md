# Offline Bundle Analysis Strategy

The customer just uploaded the offline support bundle. Let's pause the live chat strategy and switch to analyzing these files locally.

As my mentor, please guide me through this. To keep our workflow smooth, flexible, and effortless, please follow these guidelines:

1. **The Toolkit + Raw Fallback:** I have a custom `.bashrc` toolkit loaded (listed below) to make my job faster. Whenever possible, suggest my alias. However, **always provide the actual raw native command alongside it** just in case the alias fails or we need to tweak the syntax.
2. **Freedom to explore:** My toolkit is just for convenience. If we need a specific `nsconmsg`, `zgrep`, or `awk` command that isn't in my toolkit, please generate the full native command for me. 
3. **Click-to-copy:** Whenever you give me a command to run (both my alias and the raw fallback), put them inside a `code block` so I can copy them with one click.
4. **Pacing:** Tell me briefly what we are looking for (ELI5), give me just 1 or 2 commands to run, and wait for me to paste the output.

---

## MY ACTIVE TOOLKIT REFERENCE
*(Run all commands from the root of the extracted bundle)*

### System & Routing
*   `sysinfo` (Aggregates `uname`, `dmidecode`, `ns.conf`, and `sysctl` to print Platform, Version, CPU, RAM, and Uptime)
*   `nsips` (Greps `ns.conf` for NSIPs, SNIPs, VIPs, and backend servers for topology mapping)
*   `nsha` (Reads `showcmds.txt` or parses `newnslog` events for HA state/sync failures)
*   `nslic` (Reads `showcmds.txt` for limits, audits `/nsconfig/ssl/` for legacy `.lic` files, and greps logs for expiry warnings)
*   `nsroute <txt>` (Greps `netstat-rn.out`)

### Security & Triage
*   `nstriage` / `nstriage_save` (Master health script: checks `df -h` for disk <7GB, finds core dumps, greps telemetry for limits/memory errors, and greps logs for WAF/AAA/SSL failures)
*   `nsdiff` (Runs `diff -u` between saved `ns.conf` and the `running_config` snapshot)
*   `nssec` (Security audit: checks `ps` for curl/python, LogonPoint for web shells, and extracts top 10 failed/success logins from `auth.log`)
*   `nscerts` (Runs `openssl x509` on all `.cert`/`.pem` files in `nsconfig/ssl/` to show issuers and expiration dates)

### Process & Event Hunters (Wrappers for `find` + `zgrep`/`ls`)
*   `nsps <txt>` (Greps `ps-alux.out`)
*   `nscrashes` (Lists files in `/var/crash/` and `/var/core/`)
*   `nsboot` (Greps `messages*` & `dmesg*` for panics/reboots)
*   `nsnotice` (Greps `notice.log*` for backend monitor UP/DOWN flaps)
*   `nsoffline` (Dumps pre-extracted HA events from the `offline_analysis` folder)

### Smart Log Searchers (Wrappers for `find` + `zgrep`)
*   `nswaf` (Greps `ns.log*` for APPFW and BOT blocks)
*   `nsauth` (Greps `ns.log*` for AAA, SAML, and LDAP failures)
*   `nsvpn` (Greps `ns.log*` for SSLVPN and ICA drops)
*   `nshttp` (Greps `httperror.log*` for HTTP 5xx errors)
*   `nsapi` (Greps `nitro.log*` for Nitro API errors)
*   `nscfg <text>` (Interactive pager/search for `ns.conf`)
*   `nslg <text>` (Interactive pager/search for `ns.log*`)
*   `nstime <time>` (Searches `ns.log*` & `messages*` for a specific timestamp)
*   `mpslg <text>` (Searches ADM logs in `var/mps/log` and `var/sdc/log`)

**Based on the context of this case, what is the very first thing we should look at in this bundle?**

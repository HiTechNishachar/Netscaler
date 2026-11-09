# 🥷 NetScaler Master Ninja Support Toolkit

Welcome to the **NetScaler Master Ninja** repository. This is the ultimate, "God-Tier" support toolkit designed exclusively for NetScaler Escalation Engineers. 

This repository bridges the gap between **Automated Data-Driven Log Triage** (via Bash) and **Expert Customer Communications** (via AI). It is built to eliminate guesswork, enforce strict escalation protocols, and turn hours of manual log digging into seconds of surgical analysis.

---

## 🏗️ The Ecosystem & Workflow

This toolkit operates on a two-pronged workflow:
1. **The Investigation (`bashrcnetscaleranalysis`):** You extract the customer's collector bundle locally, source this bash toolkit, and run the automated aliases to instantly prove the probable cause using raw telemetry.
2. **The Output (`netscaler_ai_prompt.md`):** You feed the findings (and raw case details) into an LLM configured with our Master Prompt. The AI synthesizes your technical findings into a pristine, corporate-safe 5-part response (Internal Guide, Escalation Justification, Customer Email, and Salesforce Documentation).

---

## 🛠️ File 1: The Master Bashrc (`bashrcnetscaleranalysis`)

This is a heavily customized, "drunk-proof" `.bashrc` script. Run all tools from the **ROOT** of the extracted collector bundle. 

### Core Dashboards & Automation
* **`nstriage` / `nstriage_save` (The Master Engine):** Executes a massive sequential diagnostic scan across 15+ files simultaneously. 
  * *What it does:* Checks `/var` capacity (warning if <7GB), hunts for core dumps, detects duplicate IPs/ARP storms, flags CPU/Memory (`mbuf`) exhaustion, proves HA failovers, catches Gateway login failures, flags WAF drops, and lists SSL Handshake errors. `nstriage_save` runs this and safely exports the output to `nstriage_output.txt` for case notes.
* **`sysinfo` (Platform Dashboard):** 
  * *What it does:* Detects if the bundle is an ADC, ADM Console, Agent, or BLX. Dynamically reads the Firmware Version, parses `dmidecode` and `os-release` to detect the underlying **Host Platform** (AWS, Azure, ESXi, Nutanix, BareMetal), and pulls CPU/Memory allocations.
* **`nsips` (Topology Extractor):**
  * *What it does:* Parses `ns.conf` to group and extract all IPs (NSIP, SNIPs, Load Balancing VIPs, Gateway VIPs, and Backend Servers). 
  * *Utility:* Gives you the exact IPs you need to write surgical Wireshark `ip.addr == X.X.X.X` filters.

### Auditing & Security Tools
* **`nssec` (Security & IOC Auditor):**
  * *What it does:* Hunts for web shells in `LogonPoint`, unauthorized bash commands (`curl`, `python`), and malicious cron jobs. It also parses `auth.log` and `ns.log` to generate a top-10 leaderboard of failed and successful management/VPN logins with exact usernames and IPs.
* **`nsdiff` (Config Difference Engine):**
  * *What it does:* Compares what the customer *saved* to disk (`ns.conf`) versus what was *running* in memory when the bundle was collected. Proves if a reboot wiped unsaved changes.
* **`nscerts`:** Decodes all SSL `.cert` and `.pem` files into plain English (Expiration Dates, Issuer, Subject).
* **`nslic`:** Checks licensing limits, grace period expirations, and lists raw license files.
* **`nsha`:** Proves if the node was Primary or Secondary and checks failover history.

### Smart Filters & Standalone Hunters
* **Event Trackers:** 
  * `nscrashes`: Lists physical core dump files in `/var/crash` and `/var/core`.
  * `nsboot`: Searches for "panic" or "reboot" events across messages and dmesg.
  * `nsnotice`: Tracks when specific backend servers/monitors flapped UP or DOWN.
* **Targeted Grep Aliases:** Pre-built regex extractors.
  * `nsauth`: Pulls LDAP, SAML, and AAA failures.
  * `nswaf`: Pulls blocked AppFW requests and Bot violations.
  * `nsvpn`: Pulls SSLVPN and ICA drops.
  * `nshttp`: Pulls HTTP 500-level Gateway errors.
  * `nsapi`: Pulls Nitro API call failures.
  * `nsoffline`: Dumps pre-extracted newnslog HA events (much faster than `nsconmsg`).

### Utilities & Interactive Pagers
* **`nscfg` / `nslg`:** Interactively pages through `ns.conf` or `ns.log` (automatically decompressing `.gz` files). Append text (e.g., `nscfg "bind vpn"`) to search all historical archives instantly.
* **Swiss Army Knives:** `nsroute` (Routing tables), `nsps` (Processes), `nstime` (Extract by timestamp), `mpslg` (Search all ADM logs), `ff` (Find file), `ft` (Find text in files).

---

## 🧠 File 2: The AI Prompt (`netscaler_ai_prompt.md`)

This markdown file contains the System Instructions for Gemini/LLMs to act as a Senior Escalation Mentor. 

### Design & Persona
The AI adopts the persona of a Senior Mentor guiding a Frontline Engineer (Brahma Datt). It is designed to strictly separate **Internal Coaching** (highly technical, CLI-heavy, diagnostic) from **Customer-Facing Output** (humanized, diplomatic, simple, and corporate-safe).

### Functionality & Strict Guardrails (Zero Guessing)
* **No Hit & Trial:** The AI is forbidden from suggesting global configuration changes without log-based proof. 
* **Escalation Triggers:** Contains hardcoded criteria (Signal 11 crashes, mbuf memory leaks, Zombie processes) that force the AI to draft an Escalation Justification rather than keeping a broken case at the frontline.
* **Integrated Playbooks:** Deep logic for isolating WAF false positives, fixing ADM telemetry permissions, debugging SAML assertions, and tracing ICA packet flows.

### The Flow
1. **Input:** You paste the `CASE DETAILS` template into the LLM chat.
2. **Internal Triage:** The AI silently evaluates the packet flow and matches symptoms to the Knowledge Base.
3. **Execution:** The AI dictates exactly which `bashrc` tools Brahma Datt should use locally, or provides the live CLI commands for the customer.
4. **Output Generation:** The AI spits out a 5-part master response (Triage Summary, Internal Guide, Escalation Notes, Customer Email, and Salesforce Case Documentation).

---

## 🗂️ File 3: `directorystructureoflogs.txt`

A sanitized, safe-for-public-viewing reference document detailing the exact directory layouts of various NetScaler support bundles. Useful for developers mapping out log paths.
* **Includes:** ADC, ADM Console, Console Agent, and BLX (Linux BareMetal).

---

## 📜 Bonus: NetScaler Escalation Cheat Sheet

For commands to run on **Live Appliances** (outside the Bashrc toolkit).

### Top 5 `nsconmsg` Commands (Hardware Truth)
| Command | Purpose |
| :--- | :--- |
| `nsconmsg -K newnslog -d event` | HA state changes, UP/DOWN flaps, interface link events. |
| `nsconmsg -K newnslog -d consmsg` | Kernel panics, signal crashes, and console broadcast errors. |
| `nsconmsg -K newnslog -s totaled -d statns` | Global statistics (mbuf drops, rate limit drops, CPU hits). |
| `nsconmsg -K newnslog -s ConStr=1.1.1.1 -d oldconmsg` | Filter binary logs for a specific IP or string. |
| `nsconmsg -j newnslog -d past` | Check the actual start/end timestamps of the binary log file. |

### Live Tracing & Networking (`nstrace` / `cli`)
* **Start a trace (with SSL keys):** 
  `start nstrace -size 0 -mode SSLKEYLOG -tcpdump ENABLED`
* **Stop a trace:** 
  `stop nstrace`
* **Check Live Routing:** 
  `show route` (CLI) or `netstat -rn` (Shell)
* **Check Live ARP:** 
  `show arp` (CLI) or `arp -a` (Shell)

### Authentication & Gateway Debugging (Live Box)
* **Live AAA Debug:** 
  `cat /tmp/aaad.debug` (Must be run while reproducing the login failure).
* **Live SAML/SSO Logs:** 
  `tail -f /var/log/ns.log | grep -i saml`

### Critical Shell Locations
* `/var/crash/` - Core dumps (NSPPE)
* `/var/log/ns.log` - AppFW, VPN, AAA, and Traffic policies.
* `/var/log/messages` - Kernel, hardware, L2/L3 networking, and licensing.
* `/var/nslog/newnslog` - Binary performance telemetry.
* `/nsconfig/ns.conf` - Primary configuration file.

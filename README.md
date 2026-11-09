# 🥷 The Magical Master NetScaler Triage Toolkit

Welcome to the ultimate escalation support toolkit for Citrix NetScaler (ADC, ADM, and BLX). This repository combines a heavily engineered, data-driven bash environment (`.bashrc`) with a strictly constrained AI prompt structure to create a flawless, zero-guesswork triage workflow. 

Whether you are analyzing a 5GB offline support bundle or engaging a customer on a live system, this toolkit automates the manual labor, highlights the silent killers (disk space, memory exhaustion, expired licenses), and forces a surgical, evidence-based approach to case resolution.

---

## 📂 Repository Contents

1. **`bashrcnetscaleranalysis`** - The custom bash profile. Drop this into your collector bundle analysis environment to unlock the magic commands.
2. **`netscaler_ai_prompt.md`** - The master AI persona prompt. It instructs your AI assistant on how to analyze data, enforce support boundaries, and format customer-facing responses.
3. **`safe_sampledirstruct.md`** - Sanitized directory structures for ADC, ADM Console, ADM Agent, and BLX bundles to help train the AI on where to find specific logs.

---

## 🛠️ Part 1: The Master `.bashrc` Toolkit (Offline Analysis)

This bashrc is designed to turn 30 minutes of manual log grepping into 5 seconds of automated execution. 

### 📊 System & Environment Discovery
*   **`sysinfo` (The Dashboard)**
    *   **What it does:** Instantly detects if the bundle is an ADC, ADM Console, Agent, or BLX instance. It extracts the precise Firmware Version, Hardware Platform (VPX/MPX/SDX, AWS, Azure, ESXi), Serial Number, HA State, and allocated CPU/Memory.
    *   **Where it checks:** `showcmds.txt`, `showtech_info.out`, `dmidecode.out`, `os-release.out`, `sysctl-a.out`.
    *   **Why it matters:** Eliminates the need to manually dig through 6 different files to fill out case intake notes. You instantly know exactly what environment you are troubleshooting.
*   **`nsips` (Topology Extractor)**
    *   **What it does:** Parses the configuration to group and list all NSIPs, SNIPs, Load Balancing VIPs, Gateway VIPs, and Backend Servers.
    *   **Where it checks:** `nsconfig/ns.conf` and `shell/ifconfig-a.out`.
    *   **Why it matters:** Provides the exact IP addresses you need to write flawless Wireshark (`ip.addr == X.X.X.X`) and telemetry filters.

### 🚀 The Master Triage Engine
*   **`nstriage` / `nstriage_save` (The Magic Button)**
    *   **What it does:** Executes a massive sequential diagnostic scan across the entire bundle. 
        *   Checks for critical disk space exhaustion in `/var`, `/tmp`, and `/flash` (warning if `/var` drops below 7GB).
        *   Hunts for `core` and `crash` dumps.
        *   Detects L2/L3 network chaos (duplicate IPs, MAC flaps).
        *   Flags CPU/Memory exhaustion (checking `mbuf` drops).
        *   Highlights WAF blocks, Gateway AAA failures, and SSL Handshake drops.
    *   **Where it checks:** Simultaneously hits 15+ files including `df-*.out`, `var/crash`, `var/log/messages`, `newnslog`, `ns.log`, and `notice.log`.
    *   **Why it matters:** Guarantees you never miss a silent killer. `nstriage_save` drops the output into a clean `.txt` file ready to be attached to your Salesforce case.

### 🔐 Security, Licensing & Configuration
*   **`nssec` (IOC & Security Auditor)**
    *   **What it does:** Hunts for suspicious bash commands (wget, curl, python) and checks LogonPoint directories for dropped Web Shells. It prints a sorted leaderboard of the Top 10 Failed and Successful management/GUI logins.
    *   **Where it checks:** `ps-aux*`, `LogonPoint/`, `auth.log*`, and `ns.log*`.
*   **`nslic` (License Auditor)**
    *   **What it does:** Parses the live `show ns license` output, warns you if deprecated `.lic` files are present, and checks the logs for throughput/grace-period limits.
*   **`nscerts` (SSL Decoder)**
    *   **What it does:** Finds every `.cert`, `.crt`, and `.pem` file and decodes them into plain English (Expiration Dates, Issuer).
*   **`nsdiff` (Config Diff Engine)**
    *   **What it does:** Compares the `ns.conf` saved to disk versus the running configuration at the time of bundle collection to catch unsaved customer changes.

### 🔍 Smart Greps & Interactive Pagers
*   **Feature Hunters:** `nswaf` (AppFW Blocks), `nsauth` (SAML/LDAP Drops), `nsvpn` (ICA/STA issues), `nshttp` (5xx errors).
*   **Event Hunters:** `nscrashes` (Core dumps), `nsboot` (Panics/Reboots), `nsnotice` (Monitor UP/DOWN flaps).
*   **Pagers (`nscfg` & `nslg`):** Type `nscfg` to cleanly view configuration history, or `nscfg "bind vpn"` to search across all archived `ns.conf` files. `nslg` does the same, seamlessly decompressing `.gz` files on the fly.

---

## 🧠 Part 2: The AI Prompt Architecture (The Brain)

The `netscaler_ai_prompt.md` is designed to force Large Language Models into the persona of a hyper-disciplined Senior Escalation Engineer. 

### Core Design Principles
1.  **Zero Guesswork (No Hit & Trial):** The AI is strictly forbidden from suggesting generic workarounds or code-level changes. It must *prove* the fault using exact log lines or packet drops before suggesting a configuration change.
2.  **Surgical Scope Enforcement:** The AI checks immediately if the issue belongs to NetScaler. If it is a CVAD/StoreFront/VDA issue, it halts troubleshooting and prepares a handover.
3.  **Cross-Geo Workflow:** Embeds the exact rules for AMS/EMEA/APAC case dispatching (e.g., when to hold a case, when to route back on first response timeouts).
4.  **Escalation Triggers:** The AI actively watches for "God-Tier" issues (Signal 11 Core Dumps, infinite memory leaks, protocol-level TCP RST bugs). If triggered, it silently prepares an internal technical justification for the Escalation Team.

### The 5-Part Output Structure
Every AI response is strictly formatted to give you exactly what you need to manage the case:
1.  **Issue Triage & Ownership** (What is broken and do we own it?)
2.  **Internal Guide for Brahma Datt** (Which bashrc tools to run, what to look for, how to verify.)
3.  **Escalation Suggestion** (Is this a known CVE/Bug or standard misconfiguration?)
4.  **Customer-Facing Communication** (A copy-pasteable, professional plain-text email proving the probable cause and outlining the action plan.)
5.  **Salesforce Documentation** (Pre-written case notes and hygiene tracking.)

---

## ⚡ Part 3: The Ultimate Live Troubleshooting Cheat Sheet

When you are on a Zoom call or WebEx and cannot rely on an offline bundle, use these raw CLI commands directly in the NetScaler shell to isolate issues in real-time.

### 1. System, Hardware & Licensing Identification
When you jump on a box, instantly figure out what you are working with.
*   **Hardware & Platform:** `show hardware` (Identifies VPX vs MPX, CPU, and Serial Number).
*   **Firmware Version:** `show version`
*   **HA Status:** `show ha node` (Master/Secondary state) and `show ha syncFailures` (Config sync issues).
*   **Licensing (LAS):** 
    *   `show ns license` (Checks active features and limits).
    *   `show ns licenseparameters` (Checks license server allocation).
    *   `show ns licenseservers` (Verifies connection to ADM/Licensing server).

### 2. Live Telemetry Analysis (`nsconmsg`)
The most powerful tool on the NetScaler. It reads the binary `/var/nslog/newnslog` files.
*   **Live Event Tailing:** `nsconmsg -d event` (Watch HA state changes and entity UP/DOWN events in real-time).
*   **Live Console Errors:** `nsconmsg -d consmsg` (Watch for live system panics, memory warnings, or hardware faults).
*   **Historical Hardware Drops:** `nsconmsg -K /var/nslog/newnslog -s totaled -d statns | grep -iE "err|drop|fail"` (Shows total packets dropped by CPU, Memory, or NICs over the current log cycle).
*   **Check Specific IP Drops:** `nsconmsg -K /var/nslog/newnslog -s ConLb=10.0.0.5 -d oldconmsg` (Finds why a specific backend server IP was marked down).

### 3. Live Log Tailing (`zgrep` & `tail`)
*   **Monitor AAA / Gateway / SAML:** 
    `tail -f /var/log/ns.log | grep -iE "AAA|SAML|LOGIN|EPA|sslvpn"`
*   **Monitor WAF / Bot Management Blocks:** 
    `tail -f /var/log/ns.log | grep -iE "APPFW|BOT"`
*   **Monitor Backend Server Flaps:**
    `tail -f /var/log/notice.log | grep -iE "DOWN|UP"`
*   **Monitor Management Logins (SSH/GUI):**
    `tail -f /var/log/auth.log`

### 4. Packet Tracing (The Ultimate Proof)
When logs don't tell the story, the packets will. Run these from the FreeBSD shell.
*   **Basic Frontend/Backend Trace:** 
    `nstrace.sh -sz 0 -m LINK` (Captures full-size packets, linking frontend client connections to backend server connections).
*   **Trace a Specific Client IP:** 
    `nstrace.sh -sz 0 -m LINK -f "CONNECTION.IP.EQ(192.168.1.100)"`
*   **Trace Specific Decrypted SSL Traffic:**
    `nstrace.sh -sz 0 -m LINK -d ENABLED -f "CONNECTION.DSTIP.EQ(10.0.0.50) && CONNECTION.DSTPORT.EQ(443)"`
    *(Note: To view decrypted traffic, you must import the SSL keys into Wireshark).*
*   **Stop a trace:** `Ctrl+C` (Files are saved in `/var/nstrace/`).

### 5. Emergency OS Interventions
*   **Check Disk Space:** `df -h` (Watch out for `/var` hitting 100%).
*   **Check Running Processes:** `top` or `ps -aux | grep <process>`.
*   **Check Network Routing:** `netstat -rn`.
*   **Force Kill a Zombie Process (Use with Caution):** `kill -9 <PID>` (Useful if `aaad` or `snmpd` locks up at 100% CPU).

---
*Created for Elite NetScaler Escalation Engineers.*

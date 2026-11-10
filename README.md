# 🥷 The Magical Master NetScaler Triage Toolkit

Welcome to the ultimate escalation support toolkit for Citrix NetScaler (ADC, ADM, and BLX). This repository combines a heavily engineered, data-driven bash environment (`.bashrc`) with a strictly constrained AI prompt structure to create a flawless, zero-guesswork triage workflow. 

Whether you are analyzing a 5GB offline support bundle or engaging a customer on a live system, this toolkit automates the manual labor, highlights the silent killers (disk space, memory exhaustion, expired licenses), and forces a surgical, evidence-based approach to case resolution.

---

## 📂 Repository Contents

1. **`bashrcnetscaleranalysis`** - The custom bash profile. Drop this into your collector bundle analysis environment to unlock the magic commands.
2. **`netscaler_ai_prompt.md`** - The master AI persona prompt. It instructs your AI assistant on how to analyze data, enforce support boundaries, and format customer-facing responses.
3. **`directorystructureoflogs.txt`** - Sanitized directory structures for ADC, ADM Console, ADM Agent, and BLX bundles to help train the AI on where to find specific logs.

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

The `netscaler_ai_prompt.md` is designed to force Large Language Models into the persona of a hyper-disciplined Senior Escalation Engineer acting as a mentor. 

### Core Design Principles
1.  **Drunk Baby Proof Instructions:** The AI is strictly trained to provide explicit, simple steps (ELI5 - Explain Like I'm 5). It tells you exactly *where* to run a command (e.g., NetScaler CLI vs. FreeBSD shell) and *why* you are running it.
2.  **Zero Guesswork (No Hit & Trial):** The AI must *prove* the fault using exact log lines or packet drops before suggesting a configuration change. It actively provides a list of "Probable Causes & Elimination Strategies" at the start of every diagnosis.
3.  **Adaptive Communication Modes:** The AI drafts responses tailored to your immediate need: standard emails, live call scripts, or post-call summaries.
4.  **Escalation Triggers:** The AI actively watches for "God-Tier" issues (Signal 11 Core Dumps, infinite memory leaks, protocol-level TCP RST bugs). If triggered, it silently prepares an internal technical justification for the Escalation Team.
5.  **Mentorship on Closure:** When a case is resolved, the AI will walk you through a deep-dive educational summary of the component, traffic flow, and alternative culprits for your personal growth.

---

## 🚀 Part 3: The Ultimate Live Troubleshooting Cheat Sheet

This cheat sheet is designed for live troubleshooting, rapid log collection, and surgical isolation of NetScaler issues spanning ADC, Gateway, SSL, and GSLB.

### 1. 🔍 BASELINE & QUICK TRIAGE (Always Collect First)
Before diving into traces, establish the state of the appliance.

-   **Appliance Info:** `show version` | `show ns ip` | `show system` | `show hardware`
-   **Health & CPU:** `stat system` | `show cpu` | `show memory` | `top -b -n 1` (FreeBSD shell)
-   **HA State:** `show ha node` | `show ha syncFailures`
-   **Network/Routing:** `show interface all` | `show route` | `show arp`
-   **Licensing:** `show ns license`
-   **Save Config (Diff Check):** `save config` then compare with running.

### 2. 🧠 TSE CHEAT CODE (Issue ➡️ Log Mapping)
Use this memory trick to immediately jump to the right log based on the symptom.

| Symptom / Issue Type | Primary Log / Action to Collect |
| :--- | :--- |
| **Login / Auth Failure** | `/tmp/aaad.debug` + `/var/log/ns.log` |
| **App Launch / ICA Failure** | `nstrace` + `/var/log/ns.log` |
| **SSL Handshake Failure** | `nstrace -mode SSLPLAIN` + `sslkey` |
| **Performance / Slowness** | `newnslog` + `nstrace` |
| **Disconnects / Drops** | `nstrace` + `/var/log/ns.log` |
| **Crash / Hang** | `/var/crash` + `show techsupport` |
| **Unknown / Routing** | `nstrace` + `netstat -rn` (topology) |

### 3. 📂 CRITICAL LOG LOCATIONS
Run these paths from the FreeBSD `shell`.

-   **Customer Traffic (VPN, AppFW, AAA):** `/var/log/ns.log`
-   **System/OS Traffic (Hardware, Routing, L2):** `/var/log/messages`
-   **Binary Telemetry/Performance:** `/var/nslog/newnslog`
-   **Live Authentication Debug:** `/tmp/aaad.debug` (Must run `cat /tmp/aaad.debug` *during* the issue)
-   **Packet Traces:** `/var/nstrace/`
-   **Core Dumps:** `/var/core/` and `/var/crash/`
-   **Configuration File:** `/nsconfig/ns.conf`

### 4. 🔐 SSL / TLS & NSTRACE DECRYPTION
When troubleshooting SSL handshake failures, cipher mismatches, or collecting decrypted payloads.

**Golden Rule for SSL Tracing:**
1. Enable SSL Keys: `set ns param -sslkey ALL` (NetScaler CLI)
2. Start Trace: `start nstrace -size 0 -mode SSLKEYLOG` (NetScaler CLI)
3. *Reproduce the issue.*
4. Stop Trace: `stop nstrace`
5. Extract Keys: `cat /var/nstrace/ssl_key.log > /var/tmp/sslkeys.log` (FreeBSD Shell)
6. **Wireshark Analysis:** Edit ➡️ Preferences ➡️ Protocols ➡️ TLS ➡️ (Pre)-Master-Secret log filename ➡️ Browse to `sslkeys.log`.

**Common SSL Errors:**
-   `SSL_ERROR_RX_MALFORMED_HELLO`: Client/Protocol mismatch.
-   `SSL Alert - Handshake Failure`: Cipher/Protocol mismatch.
-   `ERR_SSL_PROTOCOL_ERROR`: TLS version/cipher not supported.
-   `Certificate verify failed`: Cert chain / CN / Expired cert.

### 5. ⚖️ LOAD BALANCING & SLOWNESS TRIAGE

**Load Balancing Config & Health:**
-   `show lb vserver <name>`
-   `show service <name> -detail` (Check state, current connections, response time)
-   `show lb monitor <name>`
-   `show lb monitor binding <vserver>`
-   `show persistence <policy>`

**Performance & Slowness:**
-   **End-to-End Latency Check:** `nstrace` + review `stat system`
-   **Connection Limits:** `show system internal conns` | `show system limits`
-   **Historical Telemetry:** `nsconmsg -K /var/nslog/newnslog -s totaled -d statns`
-   **High CPU w/ SSL:** Check `stat ssl`. If handshake times are high, CPU is likely choking on SSL offload.

### 6. 🌐 CITRIX GATEWAY & SECURE ACCESS (ICA PROXY FLOW)
Follow this exact Wireshark / Packet flow to isolate exactly where a Gateway launch fails.

**Packet Flow & Wireshark Filters:**
1.  **DNS Resolution:** `dns && udp.port == 53`
2.  **TCP & TLS Handshake (to Gateway):** `tcp.port == 443 || tls`
3.  **Authentication (LDAP/Kerberos):**
    *   Check `/tmp/aaad.debug`
    *   Wireshark: `ldap || tcp.port == 389 || tcp.port == 636` OR `kerberos`
4.  **SSO to StoreFront (Token/Cookie):**
    *   Wireshark: `http contains "SAML" || http`
5.  **Resource Enumeration (XML Broker):**
    *   Wireshark: `xml || http && ip.addr == <DDC_IP>`
6.  **Desktop Launch (ICA File Generation):**
    *   Wireshark: `http contains ".ica" || http.request.uri contains "launch"`
7.  **HDX Session Establish (Connecting to VDA):**
    *   ICA (TCP): `tcp.port == 1494`
    *   Session Reliability/CGP (TCP): `tcp.port == 2598`
    *   EDT/DTLS (UDP): `udp.port == 443`

**Common Gateway Failure Points:**
-   **Auth Fails:** Invalid credentials, AD connection blocked (Port 389/636).
-   **No SSO Cookie:** StoreFront to DDC communication broken.
-   **No ICA File:** Broker/Assignment problem (Check StoreFront event logs).
-   **SYN Retries to VDA:** Firewall blocking Ports 1494/2598 from NetScaler SNIP to VDA IP.

**Secure Access Client Log Locations (EPA / VPN):**
-   **Windows:** `%ProgramData%\Citrix\Secure Access Client\Logs`
-   **macOS:** `/Library/Logs/Citrix/Secure Access Client/`
-   **Linux:** `/var/log/citrix/secure-access-client/`

### 7. 🌍 GSLB (GLOBAL SERVER LOAD BALANCING) PACKET FLOW
Troubleshooting multi-site GSLB configurations.

**GSLB Key Ports (Default):**
-   **DNS:** `UDP/TCP 53`
-   **MEP (Metrics Exchange):** `TCP 3011` (Plaintext) or `TCP 3009` (SSL)
-   **Monitors:** `TCP 80` (HTTP) or `TCP 443` (HTTPS)

**GSLB Wireshark Filters:**
-   **DNS to/from GSLB:** `dns && ip.addr == <GSLB_IP>`
-   **MEP Between Sites:** `tcp.port == 3011 || tcp.port == 3009`
-   **Monitor Traffic:** `ip.addr == <Monitor_IP>`

**GSLB Troubleshooting Guide:**

| Symptom | Wireshark Clue | Possible Cause | How to Fix |
| :--- | :--- | :--- | :--- |
| **No GSLB Response** | No DNS response or SERVFAIL/NXDOMAIN | ADNS down, VIP not reachable, DNS misconfig | Check ADNS service, NSIP/Service IP reachability |
| **Wrong Site Returned** | DNS response with sub-optimal IP | MEP down between sites (metrics not shared) | Check TCP 3011/3009, firewalls, MEP state |
| **MEP Down** | No packets on 3011/3009 or TCP RST | Firewall blocking, routing issue, SNIP missing | Allow TCP 3011/3009, verify SNIP/VIP routing |
| **Monitor Down** | Probe fails (TCP RST / Timeout) | Backend service down or port blocked | Check server health, port bindings |

**CLI Commands for GSLB:**
-   `show gslb site` (Check MEP State: UP/DOWN)
-   `show gslb service`
-   `show gslb monitor`

---
*Created for Elite NetScaler Escalation Engineers.*

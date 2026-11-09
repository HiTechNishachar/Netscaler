# 🥷 NetScaler Master Ninja Support Toolkit

Welcome to the **NetScaler Master Ninja** repository. This project houses a "God-Tier" collection of advanced bash utilities, AI system instructions, and structural references designed specifically for NetScaler (ADC, ADM, BLX) Escalation Support Engineers.

These tools are built to eliminate guesswork, automate complex log triage, and enforce strict, data-driven troubleshooting standards.

## 📁 Repository Contents

### 1. `bashrcnetscaleranalysis` (The Magical Master `.bashrc`)
A heavily customized, "drunk-proof" `.bashrc` script designed to turn hours of manual NetScaler log digging into seconds of automated triage. 
**Key Features:**
* **`nstriage` / `nstriage_save`:** The master engine. Run this at the root of a collector bundle to automatically hunt down 99.9% of root causes (Crashes, Memory leaks, L2/L3 ARP anomalies, HA failovers, WAF blocks, and Gateway Auth failures).
* **`sysinfo`:** Instantly detects the environment (ADC, ADM, Agent, BLX) and the underlying Host Platform (AWS, Azure, ESXi, Nutanix, BareMetal).
* **`nsips`:** Extracts full network topology (NSIPs, SNIPs, VIPs, Backend Servers) directly from `ns.conf` for Wireshark filters.
* **`nssec`:** Audits failed/successful logins from `auth.log` and hunts for Web Shells or IOCs.

### 2. `netscaler_ai_prompt.md` (The God-Tier AI Prompt)
A meticulously engineered System Prompt designed to instruct an LLM (like Gemini) to act as a Senior NetScaler Escalation Support Engineer.
**Key Features:**
* **Strict Guardrails:** Enforces zero-tolerance rules against guessing ("hit and trial"), exposing internal escalation states, or leaking CVEs.
* **Surgical Triage Logic:** Forces the AI to use the `bashrcnetscaleranalysis` aliases to *prove* faults before suggesting customer actions.
* **Built-in Playbooks:** Contains highly technical escalation playbooks for WAF bypasses, ADM telemetry syncs, SAML SSO drops, and core dump triggers.
* **Automated Formatting:** Outputs perfectly formatted, copy-pasteable customer emails, internal SFDC hygiene notes, and cross-geo handover comments.

### 3. `directorystructureoflogs.txt` (Bundle Architecture Reference)
A sanitized, safe-for-public-viewing reference document detailing the exact directory layouts of various NetScaler support bundles.
**Included Structures:**
* NetScaler ADC Support Bundle
* NetScaler Console (ADM) Support Bundle
* NetScaler Console Agent Support Bundle
* NetScaler BLX (Linux BareMetal) Support Bundle

---

## 🚀 Quick Start Guide

### Using the Bashrc Toolkit
1. Download the `bashrcnetscaleranalysis` file to your local machine or jump server.
2. When navigating a downloaded NetScaler collector bundle, source the script:
   ```bash
   source bashrcnetscaleranalysis
   ```
3. Run `nsusage` to see the command cheat sheet, or simply type `nstriage_save` at the root of an extracted bundle to run a full diagnostic scan and save a clean output text file.

### Using the AI Prompt
1. Copy the entire contents of `netscaler_ai_prompt.md`.
2. Paste it into the "System Instructions" or "System Prompt" section of your preferred LLM interface.
3. Feed the AI your raw case notes, symptoms, or logs using the mandatory `CASE DETAILS` template provided in the prompt.

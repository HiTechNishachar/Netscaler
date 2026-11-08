# Prompts & Analysis Tools 🥷

Welcome to the **Prompts** repository. This project houses a collection of "God-Tier" advanced utilities and AI system instructions designed specifically for NetScaler (ADC/ADM) Escalation Support Engineers. 

These tools are built to eliminate guesswork, automate log triage, and enforce strict, data-driven troubleshooting standards.

## 📁 Repository Contents

### 1. `bashrcnetscaleranalysis` (The Magical Master `.bashrc`)
A heavily customized, "drunk-proof" `.bashrc` script designed to turn hours of manual NetScaler log digging into seconds of automated triage. 

**Key Features:**
*   **`nstriage` / `nstriage_save`:** The master engine. Run this at the root of a collector bundle to automatically hunt down 99.9% of root causes, including:
    *   Core dumps, memory leaks (mbuf exhaustion), and fatal crashes.
    *   L2/L3 Network & ARP anomalies.
    *   HA state changes and hardware packet drops.
    *   Gateway AAA/SAML/LDAP authentication failures.
    *   WAF/Bot protection false positives.
    *   ADM subsystem errors (Error 2400, sync failures).
*   **Smart Security Tools:** Check for running config diffs (`nsdiff`), decode SSL certificates instantly (`nscerts`), and hunt for IOCs/Web Shells (`nssec`).
*   **Dynamic Paging:** Interactive viewers (`nscfg`, `nslg`) to effortlessly scroll through historical log backups without flooding the terminal.

### 2. `netscaler_ai_prompt.md` (The God-Tier AI Prompt)
A meticulously engineered System Prompt designed to instruct an LLM (like Gemini) to act as a Senior NetScaler Escalation Support Engineer mentoring frontline engineers.

**Key Features:**
*   **Strict Guardrails:** Enforces zero-tolerance rules against guessing ("hit and trial"), exposing internal escalation states, or leaking CVEs.
*   **Surgical Triage Logic:** Forces the AI to use the `bashrcnetscaleranalysis` tools to *prove* faults before suggesting customer actions.
*   **Built-in Playbooks:** Contains highly technical escalation playbooks for WAF bypasses, ADM telemetry syncs, SAML SSO drops, and core dump triggers.
*   **Automated Formatting:** Outputs perfectly formatted, copy-pasteable customer emails, internal SFDC hygiene notes, and cross-geo handover internal comments.

## 🚀 Usage

### Using the `.bashrc` toolkit
1. Download the `bashrcnetscaleranalysis` file.
2. Load it into your local terminal profile or source it directly when navigating a downloaded NetScaler collector bundle:
   ```bash
   source bashrcnetscaleranalysis
   ```
3. Run `nsusage` to see the cheat sheet, or simply type `nstriage_save` at the root of an extracted bundle to run a full diagnostic scan and save the output.

### Using the AI Prompt
1. Copy the entire contents of `netscaler_ai_prompt.md`.
2. Paste it into the "System Instructions" or "System Prompt" section of your preferred LLM interface.
3. Feed the AI your raw case notes, symptoms, or logs using the mandatory `CASE DETAILS` template provided in the prompt.

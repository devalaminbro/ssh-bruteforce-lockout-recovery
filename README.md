# 🛡️ SSH Brute-Force Protection & Recovery Kit

![Service](https://img.shields.io/badge/Service-SSH%20%7C%20Fail2Ban-blue)
![Security](https://img.shields.io/badge/Security-Brute%20Force%20Prevention-red)
![Type](https://img.shields.io/badge/Type-Hardening-green)

## 🆘 The Problem
Hackers use bots to guess your SSH password thousands of times per minute (Brute Force).
- **Symptom:** High CPU usage due to `sshd` processes.
- **Risk:** If they guess weak passwords, they gain root access.
- **Log Spam:** `/var/log/auth.log` is filling up gigabytes of space.

## 🛠️ The Solution
This toolkit deploys **Fail2Ban** with an aggressive "Jail" configuration.
- **Rule:** If an IP fails to login **3 times** in **5 minutes**, it gets banned for **1 hour**.
- **Safety:** Automatically whitelists your Local LAN IPs so you don't lock yourself out.

## 🚀 Usage Guide

### Step 1: Deploy Protection
Run the hardening script on your Linux server:
```bash
sudo ./harden_ssh.sh

Step 2: Check Banned IPs
To see who has been kicked out by the jail:
fail2ban-client status sshd

Step 3: Unban an IP (Emergency)
If a legitimate user gets blocked by mistake:
fail2ban-client set sshd unbanip 192.168.1.50

Author: Sheikh Alamin Santo
Security Operations Engineer (SecOps)

```bash
#!/bin/bash

# ============================================================
# SSH Emergency Hardening Script
# Author: Sheikh Alamin Santo
# Use Case: Stops Brute-Force Attacks instantly
# ============================================================

# Color Codes
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${GREEN}[+] Starting SSH Hardening Process...${NC}"

# 1. Install Fail2Ban (if missing)
if ! command -v fail2ban-client &> /dev/null; then
    echo -e "${GREEN}[+] Installing Fail2Ban...${NC}"
    apt-get update -y
    apt-get install -y fail2ban
else
    echo -e "${GREEN}[+] Fail2Ban is already installed.${NC}"
fi

# 2. Configure Jail (Aggressive Mode)
# We use jail.local to avoid editing the default jail.conf
echo -e "${GREEN}[+] Configuring Aggressive Jail Rules...${NC}"

cat > /etc/fail2ban/jail.local <<EOF
[DEFAULT]
# Whitelist Local IPs (So you don't lock yourself out)
ignoreip = 127.0.0.1/8 192.168.0.0/16 10.0.0.0/8 172.16.0.0/12

[sshd]
enabled = true
port    = ssh
filter  = sshd
logpath = /var/log/auth.log
backend = systemd

# --- Aggressive Rules ---
maxretry = 3        # Ban after 3 failed attempts
findtime = 300      # Within 5 minutes
bantime  = 3600     # Ban for 1 hour (3600s)
EOF

# 3. Restart Service
echo -e "${GREEN}[+] Restarting Fail2Ban...${NC}"
systemctl restart fail2ban
systemctl enable fail2ban

# 4. Show Status
echo -e "${GREEN}[SUCCESS] SSH Protection Active! Current Status:${NC}"
fail2ban-client status sshd

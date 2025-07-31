# VXLAN Tunnel Setup 

This script helps you automatically create a persistent VXLAN tunnel between an **IRAN** Server and a **KHAREJ** Server, using both **IPv4** and **IPv6** local addresses.

---

## 🔧 Features

- Automatic interface detection (e.g., `eth0`, `ens3`, etc.)
- Interactive prompt to enter the remote server's IP
- Local IP setup:
  - **IPv4:** `10.123.1.1` ↔ `10.123.1.2` (`/30`)
  - **IPv6:** `fd11:1ceb:1d11::1` ↔ `fd11:1ceb:1d11::2` (`/64`)
- Automatic creation and enabling of `/etc/rc.local` for persistence after reboot

---

## 🚀 Quick Installation

### 🟢 Run this on the **IRAN** server:

```bash
curl -O https://raw.githubusercontent.com/soheilas/VXLan/refs/heads/main/IR.sh && chmod +x IR.sh && ./IR.sh
```

### 🟢 Run this on the **Kharej** server:
```bash
curl -O https://raw.githubusercontent.com/soheilas/VXLan/refs/heads/main/KH.sh && chmod +x KH.sh && ./KH.sh
```

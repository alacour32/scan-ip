🔍 Network Scanner Tool 

A lightweight Bash script to scan local networks, discover active hosts, and resolve their hostnames.

📌 Overview

This Bash script performs an ICMP ping sweep on a given subnet (CIDR notation) to identify active hosts and attempts to resolve their hostnames via nslookup. It's designed for quick network reconnaissance, system administration tasks, or security assessments.

✨ Key Features

✅ Parallel scanning – Faster detection using background processes
✅ CIDR notation support – Scan /24, /16, or custom subnets
✅ Hostname resolution – Identifies device names when available
✅ User-friendly – Clear output with active hosts and their names
✅ Lightweight – No dependencies beyond standard Linux tools (ping, nslookup)

🚀 Use Cases

Network administrators: Quickly map devices on a local network

Security researchers: Identify unknown hosts in a subnet

Home users: Check which devices are connected to their Wi-Fi

Troubleshooting: Detect IP conflicts or offline hosts

📋 Usage

Basic Scan
bash
./netscan.sh 192.168.1.0/24
Example Output:

text
[+] Escaneando red: 192.168.1.0/24

Host activo: 192.168.1.1 (router.home)  
Host activo: 192.168.1.100 (my-pc.local)  
Host activo: 192.168.1.101 ()  # No hostname found

[+] Escaneo completado.
Options
Argument	Description	Example
<CIDR>	Subnet to scan	192.168.1.0/24
(Future) -o file.csv	Export results to CSV	(Coming soon)
⚙️ How It Works
Input Validation: Checks if the provided subnet is in correct CIDR format.

Ping Sweep: Sends ICMP requests to each IP in parallel.

Hostname Lookup: Uses nslookup to resolve DNS names.

Results: Displays active IPs with hostnames (if available).

📦 Installation

bash
git clone https://github.com/your-repo/network-scanner.git
cd network-scanner
chmod +x netscan.sh
./netscan.sh 192.168.1.0/24

⚠️ Notes

Requires Bash 4+ and standard Linux tools (ping, nslookup).

Run with sudo if DNS resolution fails (depends on network config).

For large subnets (/16+), consider using nmap for better performance.

🛠 Future Improvements

Add OS detection (via nmap -O)

Export results to CSV/JSON

Support ARP scanning for local discovery


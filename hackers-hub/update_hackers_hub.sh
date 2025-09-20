#!/usr/bin/env bash
set -e

# Must run from the hackers-hub project root
if [ ! -f index.html ]; then
  echo "index.html not found. Run this from your hackers-hub directory."
  exit 1
fi

# 1) Improve visibility: stronger text colors, clearer card text
cat > css/style.css <<'CSS'
:root{
  --bg:#060606;
  --panel:#0f0f0f;
  --accent:#00ff6a;
  --accent2:#2fe6ff;
  --muted:#9ae6b4; /* brighter text color */
  --text:#dfffe6;  /* main readable text */
}
*{box-sizing:border-box}
html,body{height:100%}
body{
  margin:0;
  background:var(--bg);
  color:var(--text);
  font-family: 'Share Tech Mono', monospace;
  overflow-x: hidden;
}
#matrix-bg{
  position:fixed;left:0;top:0;width:100%;height:100%;z-index:0;
}
.content{position:relative;z-index:2}
.topbar{background:transparent;border-bottom:1px solid rgba(0,255,0,0.06)}
.navbar-brand{font-weight:700}
.hero{padding:4rem 1rem 2rem;text-align:center}
.glitch{font-size:2.4rem;text-shadow:0 0 6px var(--accent),0 0 18px var(--accent2); color: var(--accent2); }
.hacker-card{
  background:linear-gradient(180deg, rgba(10,10,10,0.94), rgba(8,8,8,0.95));
  border:1px solid rgba(0,255,0,0.12);
  transition:transform .18s ease, box-shadow .18s ease;
  color: var(--text);
}
.hacker-card .card-title{color: var(--accent); font-weight:700}
.hacker-card .card-text{color: var(--muted); opacity: 0.95}
.hacker-card a{color:var(--accent2); border-color:var(--accent2)}
.hacker-card:hover{transform:translateY(-6px) scale(1.02); box-shadow:0 0 30px rgba(0,255,0,0.07)}
.section-title{color:var(--accent); margin-bottom:1rem}
.footer{border-top:1px solid rgba(0,255,0,0.06); background:transparent}
.list-group-item{
  background:linear-gradient(90deg, rgba(8,8,8,0.9), rgba(6,6,6,0.9));
  color: var(--text);
  border:1px solid rgba(0,255,0,0.06);
}
.tip{font-family:monospace; color: var(--muted)}
a.nav-link{color:var(--muted)!important}
a.nav-link:hover{color:var(--accent2)!important}
.section-heading{color:var(--accent); font-size:1.4rem; letter-spacing:1px}
@media (max-width:576px){
  .glitch{font-size:1.8rem}
}
CSS

# 2) Articles (6 example pages + update index/latest list)
cat > articles.html <<'HTML'
<!DOCTYPE html>
<html lang="en">
<head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>Articles - Hackers Hub</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="css/style.css" rel="stylesheet"></head>
<body>
<canvas id="matrix-bg"></canvas>
<div class="content">
<nav class="navbar navbar-dark topbar">
  <div class="container">
    <a class="navbar-brand text-success" href="index.html">HackersHub</a>
  </div>
</nav>

<main class="container py-4">
  <h2 class="section-heading">Articles & Tutorials</h2>
  <p class="text-muted">Practical, ethical, and focused writeups for learners and practitioners.</p>

  <div class="list-group">
    <a class="list-group-item" href="article-networking-for-cybersecurity.html">Networking for Cybersecurity — fundamentals & defensive mindset</a>
    <a class="list-group-item" href="article-nmap-recon.html">Nmap Recon — scanning strategies and interpretation</a>
    <a class="list-group-item" href="article-c2-frameworks.html">Command & Control (C2) Frameworks — architecture and detection</a>
    <a class="list-group-item" href="article-web-app-pentest.html">Web App Pentesting — workflow and common vulnerabilities</a>
    <a class="list-group-item" href="article-priv-esc-linux.html">Linux Privilege Escalation — triage and techniques</a>
    <a class="list-group-item" href="article-ai-for-cyberdefense.html">AI for Cyber Defense — practical use-cases and limits</a>
  </div>

  <p class="mt-4 text-muted small">Tip: Each list item links to a full guide. Edit or add more guides as you learn.</p>
</main>
<footer class="footer text-center py-3">© 2025 Hackers Hub</footer>
</div>
<script src="js/matrix.js"></script>
</body></html>
HTML

# Write individual article pages
cat > article-networking-for-cybersecurity.html <<'A'
<!doctype html><html><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>Networking for Cybersecurity</title><link href="css/style.css" rel="stylesheet"></head><body>
<main class="container py-4">
<h1>Networking for Cybersecurity</h1>
<p><strong>Overview:</strong> Networking is the backbone of both attacks and defense. Understanding TCP/IP, routing, subnets, ARP, DNS, and common services will make you a better defender and tester.</p>
<h3>Key Concepts</h3>
<ul>
<li>OSI vs TCP/IP models — map services to layers</li>
<li>IP addressing, subnets, CIDR — host discovery and segmentation</li>
<li>Ports and services — common ports (22,80,443,445,3389)</li>
<li>DNS fundamentals — lookups, zone transfers, poisoning risks</li>
</ul>
<h3>Recommended commands</h3>
<pre>
# discover local hosts
nmap -sn 192.168.1.0/24

# check routing table
ip route show

# ARP table
arp -n
</pre>
<p><em>Defensive tip:</em> monitor abnormal DNS queries and unusual outbound connections; these are common signs of compromise.</p>
</main></body></html>
A

cat > article-nmap-recon.html <<'A'
<!doctype html><html><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>Nmap Recon</title><link href="css/style.css" rel="stylesheet"></head><body>
<main class="container py-4">
<h1>Nmap reconnaissance basics</h1>
<p>Nmap is the go-to network scanner. Use it responsibly and with permission.</p>
<h3>Common scans</h3>
<ul>
<li><code>nmap -sC -sV -oA recon 10.10.10.5</code> — default scripts, service detection, save output</li>
<li><code>nmap -p- --min-rate 1000 10.10.10.5</code> — fast full-port scan</li>
</ul>
<h3>Output</h3>
<p>Read service versions and correlating with CVEs. Combine with banner grabbing and web fuzzing.</p>
</main></body></html>
A

cat > article-c2-frameworks.html <<'A'
<!doctype html><html><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>C2 Frameworks</title><link href="css/style.css" rel="stylesheet"></head><body>
<main class="container py-4">
<h1>Command & Control (C2) Frameworks</h1>
<p>C2 frameworks coordinate remote agents. Understanding them helps detection and red-team exercises.</p>
<h3>Examples</h3>
<ul>
<li>Metasploit's Meterpreter — interactive shell and post-exploitation modules</li>
<li>Cobalt Strike — commercial C2 (be aware of legal/ethical constraints)</li>
<li>Sliver, Covenant — open-source C2 alternatives</li>
</ul>
<h3>Detection notes</h3>
<p>Look for beaconing patterns, unusual HTTPS traffic profiles, and repeated small outgoing connections to unknown endpoints.</p>
</main></body></html>
A

cat > article-web-app-pentest.html <<'A'
<!doctype html><html><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>Web App Pentesting</title><link href="css/style.css" rel="stylesheet"></head><body>
<main class="container py-4">
<h1>Web Application Pentesting</h1>
<p>Workflow: Recon → Mapping → Fuzzing → Exploitation → Post-exploitation → Cleanup. Use proxies like Burp for inspection.</p>
<h3>Checklist</h3>
<ul>
<li>Authentication & session handling</li>
<li>Input validation (XSS, SQLi)</li>
<li>File upload & path traversal</li>
<li>Business logic flaws</li>
</ul>
</main></body></html>
A

cat > article-priv-esc-linux.html <<'A'
<!doctype html><html><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>Linux Privilege Escalation</title><link href="css/style.css" rel="stylesheet"></head><body>
<main class="container py-4">
<h1>Linux Privilege Escalation</h1>
<p>Start with kernel info, SUID binaries, weak file permissions, cron jobs, and clear-text secrets.</p>
<pre>
# quick enumeration
uname -a
id
sudo -l
find / -perm -4000 -type f 2>/dev/null
</pre>
</main></body></html>
A

cat > article-ai-for-cyberdefense.html <<'A'
<!doctype html><html><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>AI for Cyber Defense</title><link href="css/style.css" rel="stylesheet"></head><body>
<main class="container py-4">
<h1>AI for Cyber Defense</h1>
<p>AI helps with anomaly detection, phishing classification, and automating triage. Know the limits: false positives, adversarial examples, and data drift.</p>
<h3>Practice</h3>
<p>Experiment with simple anomaly detection on NetFlow, and combine with rule-based systems for higher precision.</p>
</main></body></html>
A

# 3) Tools: 20 important Kali tools with short descriptions and install/notes
cat > tools.html <<'HTML'
<!doctype html><html><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>Tools - Hackers Hub</title><link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"><link href="css/style.css" rel="stylesheet"></head><body>
<canvas id="matrix-bg"></canvas>
<div class="content">
<nav class="navbar navbar-dark topbar"><div class="container"><a class="navbar-brand text-success" href="index.html">HackersHub</a></div></nav>
<main class="container py-4">
<h2 class="section-heading">Essential Kali Tools (20)</h2>

<div class="list-group">
<!-- Format: Tool — short desc — install/usage -->
<div class="list-group-item"><strong>Nmap</strong> — Network discovery & port scanning. <code>sudo apt update && sudo apt install nmap</code>. Usage: <code>nmap -sC -sV target</code></div>

<div class="list-group-item"><strong>Metasploit Framework</strong> — Exploitation framework and Meterpreter. Install: <code>sudo apt install metasploit-framework</code>. Launch: <code>msfconsole</code></div>

<div class="list-group-item"><strong>Wireshark</strong> — Packet capture and analysis GUI. <code>sudo apt install wireshark</code>. Run with root privileges carefully: <code>wireshark</code></div>

<div class="list-group-item"><strong>tcpdump</strong> — CLI packet capture. <code>sudo apt install tcpdump</code>. Usage: <code>sudo tcpdump -i eth0 -w capture.pcap</code></div>

<div class="list-group-item"><strong>Burp Suite</strong> — Web proxy for testing (community edition included). Start via menu or <code>burpsuite</code></div>

<div class="list-group-item"><strong>John the Ripper</strong> — Password cracking. <code>sudo apt install john</code>. Usage: <code>john --wordlist=rockyou.txt hash.txt</code></div>

<div class="list-group-item"><strong>Hydra</strong> — Fast password brute-forcer for services. <code>sudo apt install hydra</code></div>

<div class="list-group-item"><strong>Aircrack-ng</strong> — Wireless auditing suite. <code>sudo apt install aircrack-ng</code>. Usage: <code>airmon-ng start wlan0</code></div>

<div class="list-group-item"><strong>sqlmap</strong> — Automated SQL injection testing. <code>sudo apt install sqlmap</code>. Usage: <code>sqlmap -u "http://site/vuln.php?id=1" --batch</code></div>

<div class="list-group-item"><strong>Dirb / Dirbuster</strong> — Web content discovery (dirb included). <code>sudo apt install dirb</code></div>

<div class="list-group-item"><strong>Recon-ng</strong> — Reconnaissance framework. <code>sudo apt install recon-ng</code></div>

<div class="list-group-item"><strong>Masscan</strong> — Very fast port scanner. Install from repo or build; usage: <code>masscan -p0-65535 target --rate=1000</code></div>

<div class="list-group-item"><strong>Ghidra</strong> — Reverse engineering suite (GUI). Download from NSA/Ghidra site; extract and run.</div>

<div class="list-group-item"><strong>Radare2 / Cutter</strong> — CLI and GUI reverse engineering tools. <code>sudo apt install radare2</code> or use Cutter for GUI.</div>

<div class="list-group-item"><strong>Hashcat</strong> — GPU-accelerated password recovery. Install via <code>sudo apt install hashcat</code>. Usage: <code>hashcat -m 0 hash.txt rockyou.txt</code></div>

<div class="list-group-item"><strong>Responder</strong> — LLMNR/NBT-NS spoofing and capture. Clone from GitHub and run in network: <code>python3 Responder.py -I eth0</code></div>

<div class="list-group-item"><strong>Impacket</strong> — Python collection for network protocols and AD attacks. <code>sudo apt install impacket-scripts</code>. Usage: <code>wmiexec.py DOMAIN/user:pass@target</code></div>

<div class="list-group-item"><strong>MSFvenom</strong> — Payload generator (part of Metasploit). Usage: <code>msfvenom -p linux/x86/meterpreter/reverse_tcp LHOST=... LPORT=... -f elf -o shell.elf</code></div>

<div class="list-group-item"><strong>BeEF</strong> — Browser Exploitation Framework (XSS post-exploitation). <code>sudo apt install beef-xss</code></div>

<div class="list-group-item"><strong>Netcat (nc)</strong> — Swiss-army networking tool for pipes and shells. <code>nc -lvnp 4444</code> listen, <code>nc target 80</code> connect.</div>
</div>

<p class="mt-3 text-muted">Note: Install commands assume Debian-based Kali. Always use tools ethically and legally.</p>
</main>
<footer class="footer text-center py-3">© 2025 Hackers Hub</footer>
</div>
<script src="js/matrix.js"></script></body></html>
HTML

# 4) Tips: 25 concise, high-value tips
cat > tips.html <<'HTML'
<!doctype html><html><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>Tips - Hackers Hub</title><link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"><link href="css/style.css" rel="stylesheet"></head><body>
<canvas id="matrix-bg"></canvas>
<div class="content">
<nav class="navbar navbar-dark topbar"><div class="container"><a class="navbar-brand text-success" href="index.html">HackersHub</a></div></nav>
<main class="container py-4">
<h2 class="section-heading">25 Essential Hacking Tips</h2>
<ol class="list-group list-group-numbered">
<li class="list-group-item">Always get explicit permission before testing any system.</li>
<li class="list-group-item">Reproduce findings locally before reporting—show steps and commands.</li>
<li class="list-group-item">Keep a VM lab (Kali, Metasploitable, OWASP Juice Shop) isolated from your network.</li>
<li class="list-group-item">Use snapshots often; revert to clean state after risky changes.</li>
<li class="list-group-item">Log everything: commands, timestamps, and outputs for reproducibility.</li>
<li class="list-group-item">Use non-root user for daily tasks; escalate only when necessary for tests.</li>
<li class="list-group-item">Sanitize exfiltrated sensitive data—do not store secrets unnecessarily.</li>
<li class="list-group-item">Prioritize attack surface mapping: inventory hosts, services, and exposed interfaces.</li>
<li class="list-group-item">Start with passive recon before active scanning to limit noise.</li>
<li class="list-group-item">Use rate limits in scanners to avoid crashing services.</li>
<li class="list-group-item">Correlate multiple data sources (logs, NetFlow, packet captures).</li>
<li class="list-group-item">Automate repetitive tasks with safe scripts; test on a staging target first.</li>
<li class="list-group-item">Practice responsible disclosure; include remediation steps in reports.</li>
<li class="list-group-item">Keep your toolset updated but test updates in a sandbox first.</li>
<li class="list-group-item">Learn to read pcap files—network evidence often lives there.</li>
<li class="list-group-item">Use strong key management for SSH keys and rotate them periodically.</li>
<li class="list-group-item">Use least-privilege principle when creating accounts for tests.</li>
<li class="list-group-item">Document assumptions and scope in every engagement.</li>
<li class="list-group-item">Use OSINT safely: verify sources and avoid aggressive queries that attract attention.</li>
<li class="list-group-item">Prefer reproducible proofs-of-concept over noisy exploits in reports.</li>
<li class="list-group-item">Sanitize any malware samples—work in isolated lab and use snapshots.</li>
<li class="list-group-item">Annotate screenshots and terminal output for clarity in reports.</li>
<li class="list-group-item">Practice proper cleanup after tests: remove backdoors and temporary accounts.</li>
<li class="list-group-item">Use version control (git) for your notes and scripts—private repo for sensitive work.</li>
<li class="list-group-item">Continuously learn: follow vulnerability disclosures and CVE timelines.</li>
</ol>
</main>
<footer class="footer text-center py-3">© 2025 Hackers Hub</footer>
</div>
<script src="js/matrix.js"></script></body></html>
HTML

# 5) Resources: link resources to the tools (names + where to find)
cat > resources.html <<'HTML'
<!doctype html><html><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>Resources - Hackers Hub</title><link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"><link href="css/style.css" rel="stylesheet"></head><body>
<canvas id="matrix-bg"></canvas>
<div class="content">
<nav class="navbar navbar-dark topbar"><div class="container"><a class="navbar-brand text-success" href="index.html">HackersHub</a></div></nav>
<main class="container py-4">
<h2 class="section-heading">Resources</h2>
<p class="text-muted">Official docs and canonical resources for the listed tools. Use these terms to search if you need exact pages.</p>
<ul class="list-group">
<li class="list-group-item"><strong>Nmap</strong> — Official site: "nmap.org" (docs, book: Nmap Network Scanning)</li>
<li class="list-group-item"><strong>Metasploit</strong> — "metasploit.com" and Rapid7 docs</li>
<li class="list-group-item"><strong>Wireshark</strong> — "wireshark.org" (user guide, display filters)</li>
<li class="list-group-item"><strong>tcpdump</strong> — man pages and "tcpdump.org"</li>
<li class="list-group-item"><strong>Burp Suite</strong> — "portswigger.net" (learning labs & docs)</li>
<li class="list-group-item"><strong>John / Hashcat</strong> — "openwall.com" & "hashcat.net"</li>
<li class="list-group-item"><strong>Aircrack-ng</strong> — "aircrack-ng.org"</li>
<li class="list-group-item"><strong>sqlmap</strong> — "sqlmap.org" and GitHub repo</li>
<li class="list-group-item"><strong>Masscan / Dirb / Recon-ng</strong> — GitHub repos and project pages</li>
<li class="list-group-item"><strong>Ghidra / Radare2 / Cutter</strong> — official project pages & GitHub</li>
<li class="list-group-item"><strong>Impacket</strong> — GitHub: "securestate/impacket"</li>
<li class="list-group-item"><strong>Responder</strong> — GitHub: "SpiderLabs/Responder" or fork projects</li>
<li class="list-group-item"><strong>BeEF</strong> — "beefproject.com"</li>
<li class="list-group-item"><strong>OWASP</strong> — "owasp.org" (Top 10, cheat sheets)</li>
<li class="list-group-item"><strong>Awesome Security Lists</strong> — GitHub: "awesome-security"</li>
</ul>
<p class="mt-3 text-muted small">Tip: For any tool above, search its official docs or GitHub repo for installation instructions and up-to-date releases.</p>
</main>
<footer class="footer text-center py-3">© 2025 Hackers Hub</footer>
</div>
<script src="js/matrix.js"></script></body></html>
HTML

# 6) About: attractive bio for Yuvi
cat > about.html <<'HTML'
<!doctype html><html><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>About - Hackers Hub</title><link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"><link href="css/style.css" rel="stylesheet"></head><body>
<canvas id="matrix-bg"></canvas>
<div class="content">
<nav class="navbar navbar-dark topbar"><div class="container"><a class="navbar-brand text-success" href="index.html">HackersHub</a></div></nav>
<main class="container py-4">
<h2 class="section-heading">About Yuvraj (Yuvi)</h2>
<p class="text-muted">I am <strong>Yuvraj Goapbhai Barot</strong>, a 20-year-old student from India pursuing a B.E. in Artificial Intelligence and Data Science. I blend rigorous academic learning with hands-on cybersecurity practice. My work focuses on ethical hacking, defensive techniques, and exploring how AI/ML can improve digital security.</p>

<h3 class="mt-3">What drives me</h3>
<ul>
<li>Curiosity to dissect systems and understand how they fail.</li>
<li>A passion for building defensive tools and clear, reproducible tutorials for learners.</li>
<li>Belief in responsible, ethical security research and community knowledge sharing.</li>
</ul>

<h3 class="mt-3">Skills & Interests</h3>
<p class="text-muted">Networking fundamentals, penetration testing workflows, Linux internals, basic reverse engineering, and applied AI for security tasks. I enjoy building labs, automating boring tasks, and explaining complex topics simply.</p>

<h3 class="mt-3">What you’ll find here</h3>
<p>Practical guides, tool writeups, lab exercises, and curated resources for beginners and intermediate learners. This site documents what I learn and experiments I do in my lab—shared so others can climb the same ladder faster and safer.</p>

<p class="mt-3 text-muted small">If you want to collaborate, contribute content, or provide feedback, reach out via the contact page.</p>
</main>
<footer class="footer text-center py-3">© 2025 Hackers Hub</footer>
</div>
<script src="js/matrix.js"></script></body></html>
HTML

# 7) Contact: include provided contact details
cat > contact.html <<'HTML'
<!doctype html><html><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>Contact - Hackers Hub</title><link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"><link href="css/style.css" rel="stylesheet"></head><body>
<canvas id="matrix-bg"></canvas>
<div class="content">
<nav class="navbar navbar-dark topbar"><div class="container"><a class="navbar-brand text-success" href="index.html">HackersHub</a></div></nav>
<main class="container py-4">
<h2 class="section-heading">Contact</h2>
<p class="text-muted">You can reach me directly:</p>
<ul class="list-group">
<li class="list-group-item"><strong>Name:</strong> Yuvraj Goapbhai Barot</li>
<li class="list-group-item"><strong>Email:</strong> <a href="mailto:barotyuvraj0@gmail.com">barotyuvraj0@gmail.com</a></li>
<li class="list-group-item"><strong>Phone:</strong> +91 85117 95446</li>
</ul>
<p class="mt-3 text-muted small">Note: For security reasons, avoid sharing sensitive account details publicly. Use the email above for collaboration or responsible disclosure.</p>
</main>
<footer class="footer text-center py-3">© 2025 Hackers Hub</footer>
</div>
<script src="js/matrix.js"></script></body></html>
HTML

echo "Update complete. Files overwritten: css/style.css, articles.html, tools.html, tips.html, resources.html, about.html, contact.html and six article pages."

echo "Preview the site now: python3 -m http.server 8000"
echo "Open http://localhost:8000 in your browser."

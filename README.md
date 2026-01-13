# security-tools

This GitHub repository compiles various scripts and tools designed to identify vulnerabilities in websites and applications. It provides technical resources that facilitate security analysis, such as API endpoint extraction and suspicious file detection. The platform integrates popular utilities like Docker, VirtualBox, and nmap to run tests in controlled and secure environments. Additionally, the project includes practical guides for inspecting hidden code and analyzing potentially malicious PDF documents. This toolset is primarily developed in Shell scripting and is distributed under an open-source license for the cybersecurity community.

1. Web Application Vulnerabilities
   The repository integrates fundamental web security analysis tools such as OWASP, ZAP (OWASP Zed Attack Proxy), and Nikto. These scripts aim to detect:
   - Server misconfigurations: Through Nikto, which identifies dangerous files and outdated programs.
   - Common OWASP Top 10 vulnerabilities: Such as injections, Cross-Site Scripting (XSS), and authentication flaws, using ZAP.
   - Endpoint exposure: Includes a specific script ("one-liner") to extract all API endpoints from JavaScript files, helping to uncover hidden paths that may be unprotected.

2. Network Weaknesses and Attack Surface
   Using nmap, ipscan, and nikto_ports, the scripts are designed to:
   - Open ports and vulnerable services: Identify which entry points a system has and whether the services running on them have known vulnerabilities.
   - Reconnaissance and Enumeration: Tools like Sherlock and Amass (mentioned in Docker configuration files) suggest searching for subdomains and social media presence for social engineering attacks or infrastructure mapping.

3. Malicious Files and Hidden Code
   The repository dedicates a section to inspecting suspicious files using:
   - Malware Detection: Using the VirusTotal API to scan files.
   - Analysis of Suspicious PDFs: Tools like pdfid to find malicious scripts embedded in documents.
   - Inspection of Hidden Data: Using hexdump and strings to visualize hidden code or embedded text in binary files that is not visible to the naked eye.

4. Safe Execution Analysis
   Beyond passive detection, the repository offers methods to interact with potentially dangerous files in a controlled manner using Docker, Firejail, or VirtualBox. This allows you to observe a file's behavior without putting the host system at risk.

### Get endpoints
A useful one-liner that extracts all API endpoints from JavaScript files.

```bash
curl -s <URL> | grep -Po "(\/)((?:[a-zA-Z\-_\:\.0-9\{\}]+))(\/)*((?:[a-zA-Z\-_\:\.0-9\{\}]+))(\/)((?:[a-zA-Z\-_\/\:\.0-9\{\}]+))" | sort -u
```

---

### Check files
```bash
sudo chmod +x files/check_file.sh
```

```bash
cd files/ && ./check_file.sh "$FILE" "$KEY"
```

Open file in save container

```bash
docker run --rm -it --name sandbox -v $(pwd)/"$FILE":/sandbox/"$FILE" debian bash
```

Open file with firejail

```bash
firejail --private libreoffice $FILE
```

Detect file type

```bash
file $FILE
```

### Use a virtual machine
```bash
VBoxManage createvm --name "Secure_test" --register
VBoxManage modifyvm "Secure_test" --memory 2048 --cpus 2 --nic1 nat
VBoxManage startvm "Secure_test" --type headless
```
### Additional tools

| Method                  | Tool            | Command                    |
|-------------------------|-----------------|----------------------------|
| Scan with VirusTotal    | VirusTotal API  | curl                       |
| Check File Type         | file            | file archivo.dat           |
| View Content as Text    | strings         | strings archivo.dat        |
| View Hidden Code        | hexdump         | hexdump -C archivo.dat     |
| Open in Virtual Machine | VirtualBox      | VBoxManage startvm         |
| Run in Secure Container | Docker          | docker run --rm -it debian |
| Analyze Suspicious PDFs | pdfid           | pdfid archivo.pdf          |

---
![info](./info.png)


# security-tools

This GitHub repository compiles various scripts and tools designed to identify vulnerabilities in websites and applications. It provides technical resources that facilitate security analysis, such as API endpoint extraction and suspicious file detection. The platform integrates popular utilities like Docker, VirtualBox, and nmap to run tests in controlled and secure environments. Additionally, the project includes practical guides for inspecting hidden code and analyzing potentially malicious PDF documents. This toolset is primarily developed in Shell scripting and is distributed under an open-source license for the cybersecurity community.

### 1. Endpoint Extraction (`utils`)
This function is designed for the **passive discovery** of web applications by analyzing client-side code files.

* **Purpose:** To locate hidden API paths in JavaScript files.

* **Main Command:**
  ```bash
  curl -s <URL> | grep -Po "(\/)((?:[a-zA-Z\-_\:\.0-9\{\}]+))(\/)*((?:[a-zA-Z\-_\:\.0-9\{\}]+))(\/)((?:[a-zA-Z\-/\:\.0-9\{\}]+))" | sort -u
   ```

* **Utility:** Helps map the attack surface of a web application without directly interacting with the backend.

### 2. Suspicious File Analysis (`files` / `utils`)
A set of scripts to inspect potentially malicious files without compromising the host system.

* **Malware Detection:** Integration with the **VirusTotal API** for fast scanning.

* **Static Analysis:**

* `pdfid`: Identifies scripts or automated actions in PDF documents.
* `strings` and `hexdump`: Allow you to view **embedded text** and **hidden code** in binary files.

* **Secure Execution:** Instructions for using **Docker** (sandbox), **Firejail** (application isolation), or **VirtualBox** to open files in controlled environments.

### 3. Network and Port Scanning (`nmap`, `ipscan`, `nikto_ports`)
Modules focused on identifying active services and devices on a network.

* **Nmap:** Standard tool for host discovery and security auditing.

* **Nikto_ports:** Extension for scanning specific ports for web server vulnerabilities.

* **Objective:** Identify **open ports** and outdated services that could be exploited.

### 4. Web Application Security (ZAP, OWASP, Nikto)
Tools designed to find flaws in the logic and configuration of websites.

* **ZAP (OWASP Zed Attack Proxy):** Dynamic scanner to detect vulnerabilities in the **OWASP Top 10** (such as SQL injection or XSS).

* **Nikto:** Scans web servers for dangerous files and outdated server software.

### 5. OSINT and Social Reconnaissance (Sherlock)
* **Purpose:** To search for the presence of a specific username across multiple social networks and web platforms.

* **Utility:** Essential for social engineering or digital footprint investigations.

***

**Note on external information:** Although the sources list the tools and some commands, the details about the "passive reconnaissance" methodology or specific examples of vulnerabilities from the "OWASP Top 10" are general cybersecurity concepts that are not fully described in the original text. It is recommended to check the flags for each command in the official documentation for Nmap, ZAP, and Nikto.

To visualize your project, think of it as a **security locksmith's toolkit**: you have everything from high-powered magnifying glasses to examine suspicious keys (file analysis), to detailed maps of all the entrances to a fortress (nmap/zap), and a log of who has been seen in which clubs in the city (Sherlock).

---

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
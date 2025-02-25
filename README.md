# security-tools
This repository has a series of scripts to detect vulnerabilities in applications and websites

## OWASP
```bash
docker build -f Dockerfile.owasp -t owasp-scan:dev .
```

```bash
docker run --rm owasp-scan:dev https://example.com
```

### Nmap

```bash
docker build -f Dockerfile.nmap -t nmap-docker:dev .
```

```bash
docker run --rm nmap-docker example.com
```

### Nikto

```bash
docker build -f Dockerfile.nikto -t nikto-docker:dev .
```

```bash
docker run --rm nikto-docker example.com
```

### Sherlock

```bash
docker build -f Dockerfile.sherlock -t sherlock-docker:dev .
```

```bash
docker run --rm sherlock-docker example
```

### IP Scan

```bash
docker build -f Dockerfile.ipscan -t ipscan-docker:dev .
```

```bash
docker run --rm ipscan-docker:dev <IP>
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
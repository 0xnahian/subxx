# Subxx  - Subxxomain Enumeration Script

This script automates the process of enumerating subxxomains for a given target domain using various online services. The results are saved in an `output.txt` file.

## Requirements

Ensure you have the following tools installed on your system:
- `curl`
- `jq`

## Usage

1. **Clone the repository or download the script:**

    ```sh
    git clone https://github.com/0xnahian/subxx.git
    cd subxx
    ```

2. **Make the script executable:**

    ```sh
    chmod +x subxx.sh
    ```

3. **Run the script with the target domain as an argument:**

    ```sh
    ./subxx.sh example.com
    ```

    Replace `example.com` with the domain you want to enumerate subxxomains for.

## Output

The script saves the enumerated subxxomains in a file named `output.txt` in the same directory where the script is executed.

## Services Used

The script utilizes the following services to gather subxxomains:

1. [RapidDNS](https://rapiddns.io)
2. [DNS BufferOver](https://dns.bufferover.run)
3. [Riddler](https://riddler.io)
4. [VirusTotal](https://www.virustotal.com)
5. [CertSpotter](https://certspotter.com)
6. [JLDC Anubis](https://jldc.me)
7. [SecurityTrails](https://securitytrails.com)
8. [Omnisint Sonar](https://sonar.omnisint.io)
9. [SynapsInt](https://synapsint.com)
10. [crt.sh](https://crt.sh)

## Notes

- Ensure that you have an active internet connection as the script makes HTTP requests to various online services.
- The script may take some time to complete depending on the number of subxxomains and the response time of the services used.
- The script filters and sorts the results to provide unique subxxomains.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

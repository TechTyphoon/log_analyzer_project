# Log File Analyzer & Archiver

![Bash](https://img.shields.io/badge/Shell_Script-Bash-121011?style=for-the-badge&logo=gnu-bash&logoColor=white)
![Git](https://img.shields.io/badge/Version_Control-Git-F05032?style=for-the-badge&logo=git&logoColor=white)
![Linux](https://img.shields.io/badge/OS-Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)

A simple yet powerful Bash script designed to analyze log files for error messages, count occurrences, and automatically archive old log files to manage disk space. This project demonstrates core DevOps principles like automation, file management, and basic system administration tasks.

---

## 🚀 Features

* **Error Detection:** Scans specified log files for "ERROR" messages.
* **Error Counting:** Provides a count of detected errors per log file.
* **Intelligent Archiving:** Archives log files older than 1 day into a time-stamped, compressed `.tar.gz` archive.
* **Automated Cleanup:** Removes original log files after successful archiving, keeping your active log directory clean.
* **Version Controlled:** Managed with Git and hosted on GitHub for easy tracking and collaboration.

---

## 🛠️ How to Use

### Prerequisites

* A Linux environment (e.g., Ubuntu).
* Basic understanding of the Linux terminal.

### Setup

1.  **Clone the repository (or set it up if you followed the tutorial):**
    If you're continuing from our tutorial, you already have the project folder. If someone else is using your repo, they would clone it:
    ```bash
    git clone [https://github.com/your_username/log_analyzer_project.git](https://github.com/your_username/log_analyzer_project.git)
    cd log_analyzer_project
    ```
    *(Replace `your_username` with your actual GitHub username)*

2.  **Make the script executable:**
    ```bash
    chmod +x analyzer_logs.sh
    ```

### Running the Script

1.  **Ensure you have log files:**
    For testing, you can create dummy log files in a `logs/` directory inside your project folder. The script expects log files within a subdirectory named `logs/`.

    ```bash
    mkdir -p logs
    cd logs
    echo "INFO: User logged in" > app.log
    echo "ERROR: Failed to connect to database" >> app.log
    echo "INFO: Data processed" >> app.log
    # Create an 'old' log file for archiving test (sets modification time to 2 days ago)
    touch -d "2 days ago" old_log.log
    echo "WARN: This is an old log entry that should be archived" > old_log.log
    cd ..
    ```

2.  **Run the script:**
    ```bash
    ./analyzer_logs.sh
    ```

### What happens when you run it?

* The script will first analyze `app.log` (and any other log files you specify within the script) for "ERROR" messages and print the count.
* It will then look for files in the `logs/` directory that are older than 1 day.
* Any old logs found will be compressed into a new `.tar.gz` archive in the `archives/` directory (e.g., `archives/logs_20250617_201447.tar.gz`).
* The original old log files will be automatically removed from the `logs/` directory.

---

## 📁 Project Structure

log_analyzer_project/
├── analyzer_logs.sh        # The main Bash script for analysis and archiving
├── logs/                   # Directory where active log files reside
│   └── app.log             # Example log file
│   └── old_log.log         # Example of an old log file that gets archived
├── archives/               # Directory where compressed log archives are stored
│   └── logs_YYYYMMDD_HHMMSS.tar.gz
└── README.md               # This file


---

## 📈 Future Enhancements

This project can be expanded with various features:

* **Customizable Log Paths:** Allow users to specify log directories and archive destinations.
* **Error Threshold Alerts:** Send email notifications if the number of errors exceeds a certain limit.
* **Scheduled Execution:** Integrate with `cron` to run the script automatically at regular intervals (e.g., daily).
* **Configuration File:** Use a separate configuration file to define parameters (e.g., age of logs to archive, log file patterns).
* **Different Log Levels:** Extend analysis to include WARN, INFO, DEBUG messages.
* **Web Dashboard:** Create a simple web interface to view log reports.

---

## License

This project is open-source and available under the [MIT License](https://opensource.org/licenses/MIT).

---

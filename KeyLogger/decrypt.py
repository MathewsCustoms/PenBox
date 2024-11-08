from Crypto.Cipher import AES
from Crypto.Util.Padding import unpad

def decrypt_file(encrypted_file, output_file, key):
    with open(encrypted_file, 'rb') as ef:
        iv = ef.read(16)  # Extract IV from the beginning
        ciphertext = ef.read()
        
    cipher = AES.new(key, AES.MODE_CBC, iv)
    plaintext = unpad(cipher.decrypt(ciphertext), AES.block_size)
    
    with open(output_file, 'wb') as df:
        df.write(plaintext)
    print("Log file decrypted successfully.")

decrypt_file("encrypted_key_log.bin", "decrypted_log.txt", encryption_key)

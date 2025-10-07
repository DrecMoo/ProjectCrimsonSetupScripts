#!/bin/bash


# Challenge 1  

mkdir challenge1
cat > challenge1/challenge.c << 'EOF'
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

// Some fake configuration strings to add noise
const char* config_server = "https://api.example.com/v1/endpoint";
const char* config_database = "postgresql://localhost:5432/mydb";
const char* config_version = "Application Version 2.4.1 Build 8372";

// The hidden flag (will appear in strings output)
const char* secret_data = "pcctf{strings_are_not_so_secret}";

// More noise - fake error messages
const char* errors[] = {
    "ERROR: Connection timeout after 30 seconds",
    "ERROR: Invalid authentication credentials",
    "WARNING: Deprecated API endpoint in use",
    "INFO: Cache invalidated successfully"
};


void print_banner() {
    printf("========================================\n");
    printf("  Secure Login System v3.2\n");
    printf("========================================\n");
}

void fake_authentication() {
    char username[100];
    char password[100];
    
    printf("\nUsername: ");
    if (fgets(username, sizeof(username), stdin) != NULL) {
        username[strcspn(username, "\n")] = 0;
    }
    
    printf("Password: ");
    if (fgets(password, sizeof(password), stdin) != NULL) {
        password[strcspn(password, "\n")] = 0;
    }
    
    // Fake credential check
    if (strcmp(username, "admin") == 0 && strcmp(password, "password123") == 0) {
        printf("\n[SUCCESS] Login successful!\n");
        printf("Welcome, administrator.\n");
    } else {
        printf("\n[FAILED] Invalid credentials.\n");
        printf("Please try again.\n");
    }
}

void display_system_info() {
    printf("\nSystem Information:\n");
    printf("  Server: %s\n", config_server);
    printf("  Database: %s\n", config_database);
    printf("  Version: %s\n", config_version);
    
    // This will never execute, but the string is still in the binary
    if (rand() % 1000000 == 42) {
        printf("Debug mode: %s\n", secret_data);
    }
}

int main(int argc, char *argv[]) {
    srand(time(NULL));
    
    print_banner();
    
    printf("\nWelcome to the authentication system.\n");
    printf("Please enter your credentials below.\n");
    
    fake_authentication();
    
    display_system_info();
    
    printf("\nThank you for using our system.\n");
    printf("Session ID: %d\n", rand());
    
    return 0;
}
EOF

# Compile the program
echo "Compiling challenge.c..."
gcc -o challenge1/secure_login challenge1/challenge.c

if [ $? -eq 0 ]; then
    rm challenge1/challenge.c
else
    echo "Compilation failed!"
fi


# Challenge 2

mkdir challenge2
cd challenge2

echo "Creating directories..."
for i in {1..1000}; do
    dir_name=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 12 | head -n 1)
    mkdir -p "dir_$dir_name"
    
    # Put 5-10 random files in each directory
    num_files=$((5 + RANDOM % 6))
    for j in $(seq 1 $num_files); do
        file_name=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 10 | head -n 1)
        echo "This is just a decoy file with random content: $(date +%s%N)" > "dir_$dir_name/file_$file_name.txt"
    done
done


# Hide the flag in a random location
random_dir=$(ls -d dir_* | shuf -n 1)
echo "flag{found_the_needle_in_the_haystack}" > "$random_dir/secret_flag.txt"

cd ..


# Challenge 3

mkdir challenge3
cd challenge3
ips=(
    "192.168.1.100"
    "192.168.1.101"
    "192.168.1.102"
    "10.0.0.50"
    "10.0.0.51"
    "172.16.0.10"
    "172.16.0.11"
    "203.0.113.42"
    "198.51.100.78"
    "198.51.100.79"
)

# HTTP methods and paths
methods=("GET" "POST" "PUT" "DELETE")
paths=("/index.html" "/about.html" "/api/users" "/api/login" "/admin" "/contact.html" "/products" "/search")

# Generate 5000 log entries
for i in {1..5000}; do
    # Pick random IP (with weighted probability - some IPs appear more)
    if [ $((RANDOM % 10)) -lt 3 ]; then
        # 30% chance - the "attacker" IP
        ip="192.168.1.100"
    elif [ $((RANDOM % 10)) -lt 2 ]; then
        # 20% chance - another frequent IP
        ip="10.0.0.50"
    else
        # 50% chance - random IP from array
        ip=${ips[$RANDOM % ${#ips[@]}]}
    fi
    
    method=${methods[$RANDOM % ${#methods[@]}]}
    path=${paths[$RANDOM % ${#paths[@]}]}
    status=$((200 + RANDOM % 300))
    bytes=$((100 + RANDOM % 50000))
    
    echo "$ip $method $path $status $bytes" >> access.log
done

# Add a special entry with the flag for the most frequent IP
echo "192.168.1.100 GET /admin/pcctf{l0g_an4lysis_m4st3r}.txt 200 42" >> access.log

# Shuffle the log to make it more realistic
shuf access.log -o access.log


cat > words.txt << 'EOF'
apple
banana
cherry
apple
date
elderberry
fig
grape
apple
banana
cherry
apple
honeydew
apple
banana
apple
kiwi
lemon
mango
apple
banana
cherry
apple
EOF

# Add many more random words
fruits=("apple" "banana" "cherry" "date" "elderberry" "fig" "grape" "honeydew" "kiwi" "lemon" "mango" "nectarine" "orange" "papaya")
for i in {1..500}; do
    echo ${fruits[$RANDOM % ${#fruits[@]}]} >> words.txt
done

# Shuffle
shuf words.txt -o words.txt

# Hide the flag as a word that appears exactly once
echo "flag{unique_word_found}" >> words.txt
shuf words.txt -o words.txt

cd ..
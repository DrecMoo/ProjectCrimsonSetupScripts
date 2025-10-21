#!/bin/bash

echo "Setting up AWK challenges..."

# Challenge 1: Basic Field Extraction
mkdir -p awk_challenge1
cat > awk_challenge1/employees.txt << 'EOF'
John Sales 50000 5
Mary Engineering 75000 3
Bob Sales 55000 7
Alice Engineering 80000 2
Tom Marketing 60000 4
Sarah Sales 52000 6
David Engineering 72000 8
Lisa Marketing 58000 3
Mike Sales 51000 4
Emma Engineering 78000 5
Chris Marketing 62000 2
Anna Sales 54000 9
Peter Engineering 76000 4
Sophie Marketing 59000 6
James Sales 53000 3
EOF

cat > awk_challenge1/README.txt << 'EOF'
Challenge 1: Employee Analysis
==============================
You have a file called employees.txt with employee data.
Format: Name Department Salary YearsOfService

Your task:
Find the employee in Engineering who has been with the company for exactly 5 years.
The flag is: pcctf{FirstName_Salary}

Example: If John from Engineering had 5 years and salary 50000, 
the flag would be: pcctf{John_50000}
EOF


# Challenge 2: Log Analysis
mkdir -p awk_challenge2
cat > awk_challenge2/server.log << 'EOF'
2024-01-15 08:23:11 INFO User login successful user=alice ip=192.168.1.50
2024-01-15 08:24:33 WARN Failed login attempt user=bob ip=10.0.0.100
2024-01-15 08:25:44 INFO User login successful user=charlie ip=192.168.1.51
2024-01-15 08:27:15 ERROR Database connection failed retry=1
2024-01-15 08:28:22 WARN Failed login attempt user=bob ip=10.0.0.100
2024-01-15 08:29:01 INFO User login successful user=diana ip=172.16.0.25
2024-01-15 08:30:45 WARN Failed login attempt user=bob ip=10.0.0.100
2024-01-15 08:31:12 INFO User login successful user=eve ip=192.168.1.52
2024-01-15 08:32:33 ERROR API timeout endpoint=/users/list
2024-01-15 08:33:44 WARN Failed login attempt user=frank ip=10.0.0.101
2024-01-15 08:34:55 INFO User login successful user=grace ip=192.168.1.53
2024-01-15 08:35:11 WARN Failed login attempt user=bob ip=10.0.0.100
2024-01-15 08:36:22 INFO Cache cleared successfully items=1547
2024-01-15 08:37:33 ERROR Memory usage critical usage=95%
2024-01-15 08:38:44 WARN Failed login attempt user=bob ip=10.0.0.100
2024-01-15 08:39:55 INFO Backup completed size=2.3GB
2024-01-15 08:40:11 WARN Failed login attempt user=henry ip=10.0.0.102
2024-01-15 08:41:22 INFO User login successful user=iris ip=192.168.1.54
2024-01-15 08:42:33 ERROR Disk space low available=5%
2024-01-15 08:43:44 WARN Failed login attempt user=bob ip=10.0.0.100
EOF

# Add more random log entries
users=("alice" "charlie" "diana" "eve" "grace" "iris" "john" "kate" "laura" "mike")
levels=("INFO" "WARN" "ERROR")
for i in {1..100}; do
    hour=$((8 + RANDOM % 4))
    minute=$((RANDOM % 60))
    second=$((RANDOM % 60))
    level=${levels[$RANDOM % ${#levels[@]}]}
    user=${users[$RANDOM % ${#users[@]}]}
    ip="192.168.1.$((50 + RANDOM % 50))"
    
    printf "2024-01-15 %02d:%02d:%02d %s User login successful user=%s ip=%s\n" $hour $minute $second $level $user $ip >> awk_challenge2/server.log
done

# Shuffle to make it more realistic - check if shuf exists, otherwise use sort -R
if command -v shuf &> /dev/null; then
    shuf awk_challenge2/server.log -o awk_challenge2/server.log
else
    sort -R awk_challenge2/server.log -o awk_challenge2/server.log
fi

cat > awk_challenge2/README.txt << 'EOF'
Challenge 2: Security Log Analysis
===================================
You have a server.log file with various log entries.

Your task:
Find the username that has the most failed login attempts.
Count only lines containing "Failed login attempt".

The flag is: pcctf{username_count}
Example: If user "alice" had 7 failed attempts: pcctf{alice_7}
EOF


# Challenge 3: CSV Data Processing
mkdir -p awk_challenge3
cat > awk_challenge3/sales.csv << 'EOF'
Date,Product,Quantity,Price,Region
2024-01-01,Laptop,5,999.99,North
2024-01-01,Mouse,15,24.99,South
2024-01-01,Keyboard,10,79.99,East
2024-01-02,Monitor,8,299.99,West
2024-01-02,Laptop,3,999.99,North
2024-01-02,Mouse,20,24.99,East
2024-01-03,Keyboard,12,79.99,South
2024-01-03,Monitor,6,299.99,North
2024-01-03,Laptop,7,999.99,West
2024-01-04,Mouse,25,24.99,North
2024-01-04,Keyboard,8,79.99,East
2024-01-04,Laptop,4,999.99,South
2024-01-05,Monitor,10,299.99,East
2024-01-05,Mouse,18,24.99,West
2024-01-05,Laptop,6,999.99,North
EOF

# Add more random sales data
products=("Laptop" "Mouse" "Keyboard" "Monitor" "Webcam" "Headset")
prices=(999.99 24.99 79.99 299.99 89.99 149.99)
regions=("North" "South" "East" "West")

for i in {1..200}; do
    day=$((1 + RANDOM % 30))
    prod_idx=$((RANDOM % ${#products[@]}))
    product=${products[$prod_idx]}
    price=${prices[$prod_idx]}
    quantity=$((1 + RANDOM % 30))
    region=${regions[$RANDOM % ${#regions[@]}]}
    
    printf "2024-01-%02d,%s,%d,%.2f,%s\n" $day "$product" $quantity $price $region >> awk_challenge3/sales.csv
done

cat > awk_challenge3/README.txt << 'EOF'
Challenge 3: Sales Revenue Analysis
====================================
You have a sales.csv file with sales transactions.
Format: Date,Product,Quantity,Price,Region

Your task:
Calculate the total revenue (Quantity * Price) for the "North" region only.
Round your answer to the nearest whole number.

The flag is: pcctf{total_revenue}
Example: If total is 12345.67: pcctf{12346}
EOF


# Challenge 4: Grade Processing
mkdir -p awk_challenge4
cat > awk_challenge4/grades.txt << 'EOF'
Alice Math 85 Science 92 History 78
Bob Math 90 Science 88 History 95
Charlie Math 78 Science 85 History 82
Diana Math 95 Science 90 History 88
Eve Math 82 Science 87 History 91
Frank Math 88 Science 83 History 86
Grace Math 91 Science 94 History 89
Henry Math 76 Science 79 History 84
Iris Math 93 Science 91 History 87
Jack Math 87 Science 86 History 90
Kate Math 89 Science 92 History 93
Liam Math 84 Science 88 History 85
Mia Math 92 Science 89 Science 94
Noah Math 86 Science 90 History 88
Olivia Math 94 Science 95 History 92
EOF

cat > awk_challenge4/README.txt << 'EOF'
Challenge 4: Student Grades
============================
You have a grades.txt file with student scores.
Format: Name Subject1 Score1 Subject2 Score2 Subject3 Score3

Your task:
Find the student with the highest average score across all three subjects.
Calculate the average and round to one decimal place.

The flag is: pcctf{Name_Average}
Example: If Alice has average 85.5: pcctf{Alice_85.5}

Note: One student has an irregular entry - handle it carefully!
EOF


# Challenge 5: Network Traffic
mkdir -p awk_challenge5

# Generate network traffic log
protocols=("TCP" "UDP" "ICMP")
for i in {1..500}; do
    hour=$((8 + (i / 3600) % 12))
    minute=$(((i / 60) % 60))
    second=$((i % 60))
    src_ip="192.168.1.$((10 + RANDOM % 240))"
    dst_ip="10.0.0.$((1 + RANDOM % 254))"
    protocol=${protocols[$RANDOM % ${#protocols[@]}]}
    bytes=$((100 + RANDOM % 10000))
    
    printf "2024-01-15 %02d:%02d:%02d %s -> %s %s %d bytes\n" $hour $minute $second "$src_ip" "$dst_ip" $protocol $bytes >> awk_challenge5/network.log
done

# Add a specific IP that transferred the most data
for i in {1..50}; do
    ts=$((RANDOM % 500))
    hour=$((8 + (ts / 3600) % 12))
    minute=$(((ts / 60) % 60))
    second=$((ts % 60))
    printf "2024-01-15 %02d:%02d:%02d 192.168.1.42 -> 10.0.0.100 TCP %d bytes\n" $hour $minute $second $((5000 + RANDOM % 5000)) >> awk_challenge5/network.log
done

if command -v shuf &> /dev/null; then
    shuf awk_challenge5/network.log -o awk_challenge5/network.log
else
    sort -R awk_challenge5/network.log -o awk_challenge5/network.log
fi

cat > awk_challenge5/README.txt << 'EOF'
Challenge 5: Network Traffic Analysis
======================================
You have a network.log file with network traffic.
Format: Timestamp SourceIP -> DestIP Protocol Bytes bytes

Your task:
Find the source IP address that sent the most total bytes.
Report the IP and total bytes sent.

The flag is: pcctf{IP_TotalBytes}
Example: If 192.168.1.50 sent 123456 bytes: pcctf{192.168.1.50_123456}
EOF


# Challenge 6: Advanced - Multi-file Analysis
mkdir -p awk_challenge6
cat > awk_challenge6/inventory_jan.txt << 'EOF'
Laptop 45
Mouse 230
Keyboard 156
Monitor 89
Webcam 67
Headset 123
EOF

cat > awk_challenge6/inventory_feb.txt << 'EOF'
Laptop 52
Mouse 198
Keyboard 171
Monitor 94
Webcam 73
Headset 115
EOF

cat > awk_challenge6/inventory_mar.txt << 'EOF'
Laptop 48
Mouse 215
Keyboard 163
Monitor 91
Webcam 70
Headset 118
EOF

cat > awk_challenge6/README.txt << 'EOF'
Challenge 6: Inventory Trend Analysis
======================================
You have three inventory files: inventory_jan.txt, inventory_feb.txt, inventory_mar.txt
Format: Product Quantity

Your task:
Find which product had the greatest total increase from January to March.
Calculate: (March quantity - January quantity)

The flag is: pcctf{Product_Increase}
Example: If Monitor increased by 15: pcctf{Monitor_15}
EOF

echo ""
echo "AWK challenges created successfully!"
echo ""
echo "Challenge 1: Basic field extraction with employees"
echo "Challenge 2: Log analysis - find suspicious activity"
echo "Challenge 3: CSV processing with sales data"
echo "Challenge 4: Calculate averages with irregular data"
echo "Challenge 5: Network traffic analysis"
echo "Challenge 6: Multi-file comparison"
echo ""
echo "Each challenge directory contains a README.txt with instructions."

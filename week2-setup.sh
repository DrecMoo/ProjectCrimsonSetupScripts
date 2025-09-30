#!/bin/bash


# Challenge 1  
mkdir challenge1
echo "pcctf{p3rmz_own3r}" > challenge1/locked.txt
chmod 000 challenge1/locked.txt

# Challenge 2
mkdir challenge2
cp /bin/cat challenge2/special_cat
chmod 4755 challenge2/special_cat
echo "pcctf{suid_d1sc0ver3d}" > challenge2/root_secret.txt
chmod 600 challenge2/root_secret.txt

# Challenge 3
mkdir challenge3
touch challenge3/runme.sh
cat > challenge3/runme.sh << 'EOF'
#!/bin/bash
# run_me.sh - Must be IN home directory AND run FROM home directory

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=== Home Directory Challenge ==="
echo ""

# Check 1: Is the script in the home directory?
if [ "$SCRIPT_DIR" != "$HOME" ]; then
    echo "   Current: $SCRIPT_DIR"
    echo "   Required: HOME"
    echo "   Status: FAIL"
    echo ""
    exit 1
fi

echo ""

# Check 2: Are you currently in the home directory?
echo " Check 2: Current working directory"
if [ "$PWD" == "$HOME" ]; then
    echo "   Current: $PWD"
    echo "   Required: !HOME"
    echo ""
    exit 1
fi

echo ""
echo " Success! All checks passed!"
echo ""
echo "pcctf{scr1pt_ex3cut0r}"
EOF
chmod 711 challenge3/runme.sh
sudo chown root challenge3/runme.sh

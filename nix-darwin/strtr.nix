{ pkgs }:

pkgs.writeShellScriptBin "st" ''
  if [ $# -eq 0 ]; then
    echo "Usage: strtr <filename>"
    echo "Strips trailing whitespace from the specified file"
    exit 1
  fi
  
  if [ ! -f "$1" ]; then
    echo "Error: File '$1' not found"
    exit 1
  fi
  
  # Use sed to strip trailing whitespace from each line
  ${pkgs.gnused}/bin/sed -i 's/[[:space:]]*$//' "$1"
  echo "Stripped trailing whitespace from $1"
''

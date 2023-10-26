#!/bin/bash

# Kontrolli, kas Apache teenus on paigaldatud
if ! [ -x "$(command -v apache2)" ]; then
  echo "Apache teenust ei leitud. Laen Apache teenuse alla..."
  sudo apt update
  sudo apt install apache2 -y
  echo "Apache teenus on paigaldatud."
else
  echo "Apache teenus on juba paigaldatud."
fi

# Kontrolli Apache teenuse staatust ja näita seda
if systemctl is-active --quiet apache2; then
  echo "Apache teenus on käivitatud."
else
  echo "Apache teenus ei ole käivitatud."
fi

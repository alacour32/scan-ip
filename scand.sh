#!/bin/bash

# Verifica si se proporcionó un argumento (red a escanear)
if [ -z "$1" ]; then
    echo "Uso: $0 <red-en-formato-CIDR>"
    echo "Ejemplo: $0 192.168.1.0/24"
    exit 1
fi

# Valida el formato de la red (ej. 192.168.1.0/24)
if [[ ! "$1" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/[0-9]+$ ]]; then
    echo "Error: Formato de red incorrecto. Usa CIDR (ej. 192.168.1.0/24)"
    exit 1
fi

network="$1"
base_ip=$(echo "$network" | cut -d'/' -f1)
cidr=$(echo "$network" | cut -d'/' -f2)

# Calcula el rango de IPs (solo para /24 por simplicidad)
if [ "$cidr" != "24" ]; then
    echo "Advertencia: Este script funciona mejor con redes /24. Puede ser lento para otros prefijos."
fi

echo -e "\n[+] Escaneando red: $network\n"

# Escaneo con ping paralelizado (más rápido)
for ip in $(seq 1 254); do
    current_ip="${base_ip%.*}.$ip"
    (
        ping -c 1 -W 1 "$current_ip" &>/dev/null
        if [ $? -eq 0 ]; then
            hostname=$(nslookup "$current_ip" 2>/dev/null | awk '/name = / {print $4}')
            echo "Host activo: $current_ip ($hostname)"
        fi
    ) &
done

wait  # Espera a que todos los procesos en segundo plano terminen
echo -e "\n[+] Escaneo completado."

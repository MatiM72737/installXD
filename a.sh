LIMITS_FILE="/etc/security/limits.conf"
RTPRIO_LINE="@audio           -       rtprio          98"
MEMLOCK_LINE="@audio           -       memlock         unlimited"

# Dodaj tylko jeśli linia jeszcze nie istnieje
grep -qxF "$RTPRIO_LINE" "$LIMITS_FILE" || echo "$RTPRIO_LINE" | sudo tee -a "$LIMITS_FILE"
grep -qxF "$MEMLOCK_LINE" "$LIMITS_FILE" || echo "$MEMLOCK_LINE" | sudo tee -a "$LIMITS_FILE"


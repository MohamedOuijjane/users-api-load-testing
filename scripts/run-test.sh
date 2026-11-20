#!/usr/bin/env bash
# Lance l'application, exécute le test JMeter en ligne de commande et génère le rapport HTML.
# Usage : ./run-test.sh [utilisateurs] [montée_en_charge_s] [durée_s] [nom]
#   Test complet : ./run-test.sh 50 60 300 complet
#   Test rapide  : ./run-test.sh 10 30 60 rapide
set -e

THREADS=${1:-50}
RAMPUP=${2:-60}
DURATION=${3:-300}
NAME=${4:-complet}

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
JMETER="${JMETER:-$HOME/apache-jmeter-5.6.3/bin/jmeter}"
RESULTS="$ROOT/jmeter/results/$NAME"

if [ ! -x "$JMETER" ]; then
    echo "JMeter introuvable : $JMETER (lancer d'abord ./install-jmeter.sh)"
    exit 1
fi

echo "=== Compilation de l'application ==="
cd "$ROOT/backend"
mvn -q clean package -DskipTests

echo "=== Démarrage de l'application ==="
java -jar target/performance-backend-1.0.0.jar > "$ROOT/jmeter/results/app-$NAME.log" 2>&1 &
APP_PID=$!
trap 'echo "=== Arrêt de l application ==="; kill $APP_PID 2>/dev/null || true' EXIT

until curl -s http://localhost:8080/actuator/health | grep -q UP; do
    echo "En attente du démarrage..."
    sleep 2
done
echo "Application prête"

echo "=== Test JMeter : $THREADS utilisateurs, montée $RAMPUP s, durée $DURATION s ==="
rm -rf "$RESULTS"
mkdir -p "$RESULTS"
cd "$ROOT/jmeter"
"$JMETER" -n -t spring-api-test.jmx \
    -l "$RESULTS/resultats.jtl" \
    -e -o "$RESULTS/html-report" \
    -Jthreads.count="$THREADS" -Jrampup.period="$RAMPUP" -Jduration="$DURATION"

echo "=== Terminé ==="
echo "Rapport HTML : $RESULTS/html-report/index.html"
xdg-open "$RESULTS/html-report/index.html" >/dev/null 2>&1 || true

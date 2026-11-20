# Users API – Load Testing

API REST Spring Boot de gestion d'utilisateurs, testée en charge avec Apache JMeter (scénario GET / POST / GET by ID, assertions, rapport HTML).

**Stack :** Java 17, Spring Boot 3, H2, Apache JMeter 5.6.3

## Lancer

```bash
cd scripts
./install-jmeter.sh                 # installe JMeter dans le dossier personnel
./run-test.sh 10 30 60 rapide       # utilisateurs, montée (s), durée (s), nom
./run-test.sh 50 60 300 complet
```

Le rapport HTML est généré dans `jmeter/results/<nom>/html-report/index.html`.

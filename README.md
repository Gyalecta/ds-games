# DS Games

Progetto per il corso di **Tecnologie Software per il Web**  
Università degli Studi di Salerno — A.A. 2025/26  
Prof. Simone Romano

---

Domenico Avino · mat. 0512123118  
Simone Boccia · mat. 0512123148

---

## Di cosa si tratta

DS Games è un e-commerce per la vendita di console e videogiochi. L'idea era costruire qualcosa di simile a quello che si trova in giro (GameStop, Gamestart.it) ma sviluppato interamente in Java EE seguendo i pattern richiesti dal corso.

Il sito ha tre livelli di accesso: ospiti che possono navigare e aggiungere al carrello, utenti registrati che possono acquistare, e un pannello admin per gestire il catalogo e gli ordini.

## Stack

- Java 17 + Servlet 4.0 + JSP 2.3
- Apache Tomcat 9
- MySQL 8
- Maven

Pattern usati: MVC, DAO, DataSource (JNDI), token di sessione per il controllo accessi.

## Come farlo girare

**1. Database**

Esegui lo script `sql/dsgames.sql` su una istanza MySQL 8. Crea il database, le tabelle e inserisce qualche dato di test.

**2. DataSource**

Apri `[TOMCAT_HOME]/conf/context.xml` e aggiungi dentro `<Context>`:

```xml
<Resource
    name="jdbc/dsgames"
    auth="Container"
    type="javax.sql.DataSource"
    maxActive="20"
    username="root"
    password="LA_TUA_PASSWORD"
    driverClassName="com.mysql.cj.jdbc.Driver"
    url="jdbc:mysql://localhost:3306/dsgames?useSSL=false&amp;serverTimezone=Europe/Rome&amp;allowPublicKeyRetrieval=true"
/>
```

**3. Deploy**

*Con il WAR:* copia `DSGames.war` (nella root della repo) in `[TOMCAT_HOME]/webapps/` e avvia Tomcat.
Il WAR include già il `META-INF/context.xml` preconfigurato con `username=root` e `password=root`.
Se MySQL ha credenziali diverse, modificate il context.xml prima del deploy.

*Con Eclipse:* importa come Maven project, aggiungi Tomcat 9 come server,
configura il DataSource nel `context.xml` di Eclipse
(`Servers/Tomcat v9.0.../context.xml`), e avvia.

**4. Apri il browser**

```
http://localhost:8080/DSGames
```

## Credenziali di test

| Ruolo | Email | Password |
|-------|-------|----------|
| Admin | admin@dsgames.it | admin123 |
| Utente | mario@test.it | test1234 |

## Struttura del progetto

```
src/main/java/it/unisa/dsgames/
├── control/   → Servlet (Controller MVC)
├── dao/       → DAO + DAOFactory
├── model/     → Java Bean
└── util/      → PasswordUtil (SHA-256)

src/main/webapp/
├── WEB-INF/view/   → JSP (non raggiungibili direttamente)
├── styles/         → CSS
├── scripts/        → JavaScript
└── images/         → Immagini statiche
```

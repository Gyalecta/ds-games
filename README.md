# DS Games

Piattaforma e-commerce per console e videogiochi.

Progetto per il corso di Tecnologie Software per il Web  
Università degli Studi di Salerno — A.A. 2025/26

**Studenti:**
- Domenico Avino (mat. 0512123118)
- Simone Boccia (mat. 0512123148)

**Docente:** Prof. Simone Romano

## Stack tecnologico
- Java 17 + Servlet 4.0 + JSP 2.3
- Apache Tomcat 9
- MySQL 8
- Pattern: MVC, DAO, DataSource

## Struttura del progetto
- `src/main/java/it/unisa/dsgames/control/` — Servlet (Controller)
- `src/main/java/it/unisa/dsgames/model/` — Java Beans (Model)
- `src/main/java/it/unisa/dsgames/dao/` — DAO (persistenza)
- `src/main/webapp/WEB-INF/view/` — JSP (View, non accessibili direttamente)
- `src/main/webapp/styles/` — Fogli di stile CSS
- `src/main/webapp/scripts/` — File JavaScript
- `src/main/webapp/images/` — Immagini statiche
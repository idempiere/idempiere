# org.idempiere.webservice.library dependency sync

This module uses Maven only to curate runtime JARs for `lib/`.

## Refresh `lib/`

```bash
find ./lib -type f -name '*.jar' -delete
mvn -U -DskipTests process-resources
```

The `maven-dependency-plugin` execution in `pom.xml` copies runtime dependencies
(and transitives) into `lib/` while filtering known core/system-provided artifacts.

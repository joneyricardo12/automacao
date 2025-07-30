# Guia de Troubleshooting - Automação CMM

## Problemas Identificados e Soluções

### 1. **PostgreSQL - Extensão "vector" não encontrada**

**Problema:**
```
ERROR: extension "vector" is not available
```

**Solução:**
- ✅ **Corrigido:** Alterada a imagem do PostgreSQL para `pgvector/pgvector:pg17`
- Esta imagem já inclui a extensão vector necessária

### 2. **Chatwoot - Problema com URL do Redis**

**Problema:**
```
bad URI (is not URI?): "redis://:Ricardo@1964@chatwoot_redis:6379"
```

**Solução:**
- ✅ **Corrigido:** Adicionada variável `REDIS_PASSWORD_ENCODED`
- Se sua senha contém caracteres especiais como `@`, codifique-os:
  - `@` → `%40`
  - `#` → `%23`
  - `%` → `%25`

**Exemplo:**
```bash
# Se sua senha for "Ricardo@1964"
REDIS_PASSWORD=Ricardo@1964
REDIS_PASSWORD_ENCODED=Ricardo%401964
```

### 3. **N8N - Problema de permissões e banco SQLite**

**Problema:**
```
SQLITE_CANTOPEN: unable to open database file
Permissions 0644 for n8n settings file are too wide
```

**Solução:**
- ✅ **Corrigido:** Adicionadas variáveis de ambiente:
  - `N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=false`
  - `N8N_USER_FOLDER=/data`

### 4. **Configuração do .env**

**Importante:** Crie um arquivo `.env` com as seguintes variáveis:

```bash
# ===== CONFIGURAÇÕES GERAIS =====
TZ=America/Manaus
ADMIN_EMAIL=admin@cmm.am.gov.br
ADMIN_PASSWORD=SuaSenhaSegura123!

# ===== DOMÍNIOS =====
TRAEFIK_DOMAIN=traefik.cmm.am.gov.br
N8N_DOMAIN=n8n.cmm.am.gov.br
GRAFANA_DOMAIN=grafana.cmm.am.gov.br
CHATWOOT_DOMAIN=chatwoot.cmm.am.gov.br

# ===== REDIS =====
REDIS_PASSWORD=SuaSenhaRedis123!
REDIS_PASSWORD_ENCODED=SuaSenhaRedis123!

# ===== POSTGRES =====
POSTGRES_PASSWORD=SuaSenhaPostgres123!

# ===== N8N =====
N8N_ENCRYPTION_KEY=SuaChaveDeCriptografiaN8N123!

# ===== CHATWOOT =====
CHATWOOT_SECRET_KEY_BASE=SuaChaveSecretaChatwoot123!
CHATWOOT_MASTER_KEY=SuaChaveMestraChatwoot123!
```

### 5. **Passos para Aplicar as Correções**

1. **Atualize o docker-compose.yml** (já corrigido)
2. **Crie o arquivo .env** com as variáveis acima
3. **No Portainer:**
   - Vá em Stacks → Seu Stack → Editor
   - Cole o novo docker-compose.yml
   - Adicione as variáveis de ambiente na seção "Environment variables"
   - Clique em "Update the stack"

### 6. **Verificação dos Serviços**

Após aplicar as correções, verifique:

1. **PostgreSQL:** Deve iniciar sem erros de extensão
2. **Redis:** Deve conectar normalmente
3. **Chatwoot:** Deve conectar ao Redis sem erros de URI
4. **N8N:** Deve criar o banco SQLite sem problemas de permissão

### 7. **Logs para Monitorar**

```bash
# Verificar logs do PostgreSQL
docker logs chatwoot_postgres

# Verificar logs do Redis
docker logs chatwoot_redis

# Verificar logs do Chatwoot
docker logs chatwoot_rails

# Verificar logs do N8N
docker logs n8n
```

### 8. **Se ainda houver problemas**

1. **Limpe os volumes** (cuidado - isso apaga os dados):
   ```bash
   docker-compose down -v
   docker-compose up -d
   ```

2. **Verifique se as portas estão livres:**
   - 80, 443, 8080 (Traefik)
   - 5432 (PostgreSQL)
   - 6379 (Redis)
   - 5678 (N8N)
   - 3030 (Grafana)
   - 3000 (Chatwoot) 
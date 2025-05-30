
#!/bin/bash

APP_DIR="/home/pi/myapp"
CURRENT="$APP_DIR/current"
BACKUP="$APP_DIR/backup"
REPO="https://github.com/seu-usuario/seu-repositorio.git"

# 1. Backup da versão atual
rm -rf "$BACKUP"
cp -r "$CURRENT" "$BACKUP"

# 2. Tenta atualizar
cd "$CURRENT"
git pull origin main

# 3. Testa a nova versão
if ! python3 "$CURRENT/app.py"; then
    echo "⚠️ Falha na nova versão. Restaurando backup..."
    rm -rf "$CURRENT"
    cp -r "$BACKUP" "$CURRENT"
    python3 "$CURRENT/app.py"
else
    echo "✅ Atualização bem-sucedida."
fi

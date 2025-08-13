#!/bin/bash
set -e

echo "🚀 Configurando Docker Engine + Desktop + MongoDB Compass"
echo "========================================================"

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Función para logging
log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# ==== VERIFICAR SISTEMA ====
log_info "Verificando sistema operativo..."
if [[ $(uname -s) != "Linux" ]]; then
    log_error "Este script solo funciona en Linux"
    exit 1
fi

# Verificar Ubuntu/Debian
if ! command -v apt &> /dev/null; then
    log_error "Este script requiere apt (Ubuntu/Debian)"
    exit 1
fi

# ==== LIMPIAR INSTALACIONES PREVIAS ====
log_info "Removiendo instalaciones previas de Docker..."
sudo apt remove -y docker docker-engine docker.io containerd runc docker-desktop || true
sudo rm -rf /var/lib/docker || true
sudo rm -rf /etc/docker || true

# ==== INSTALAR DEPENDENCIAS ====
log_info "Instalando dependencias del sistema..."
sudo apt update
sudo apt install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common \
    gnupg \
    lsb-release \
    wget

# ==== INSTALAR DOCKER ENGINE ====
log_info "Configurando repositorio oficial de Docker..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

log_info "Instalando Docker Engine + Compose..."
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Configurar Docker
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker $USER

# ==== INSTALAR DOCKER DESKTOP ====
log_info "Descargando Docker Desktop..."
if [[ -f "docker-desktop-latest-amd64.deb" ]]; then
    log_info "Usando archivo local docker-desktop-latest-amd64.deb"
else
    log_info "Descargando Docker Desktop desde web..."
    wget -O docker-desktop-latest-amd64.deb https://desktop.docker.com/linux/main/amd64/docker-desktop-latest-amd64.deb
fi

log_info "Instalando Docker Desktop..."
sudo apt install -y ./docker-desktop-latest-amd64.deb

# ==== INSTALAR MONGODB COMPASS ====
log_info "Descargando MongoDB Compass..."
wget -O mongodb-compass_amd64.deb https://downloads.mongodb.com/compass/mongodb-compass_1.43.0_amd64.deb

log_info "Instalando MongoDB Compass..."
sudo apt install -y ./mongodb-compass_amd64.deb

# Cleanup
rm -f mongodb-compass_amd64.deb

# ==== VERIFICAR INSTALACIONES ====
log_info "Verificando instalaciones..."

# Verificar Docker
if command -v docker &> /dev/null; then
    DOCKER_VERSION=$(docker --version)
    log_info "✅ Docker instalado: $DOCKER_VERSION"
else
    log_error "❌ Docker no se instaló correctamente"
fi

# Verificar Docker Compose
if docker compose version &> /dev/null; then
    COMPOSE_VERSION=$(docker compose version)
    log_info "✅ Docker Compose instalado: $COMPOSE_VERSION"
else
    log_error "❌ Docker Compose no disponible"
fi

# Verificar MongoDB Compass
if command -v mongodb-compass &> /dev/null; then
    log_info "✅ MongoDB Compass instalado"
else
    log_error "❌ MongoDB Compass no se instaló correctamente"
fi

# ==== CONFIGURACIÓN ADICIONAL ====
log_info "Configurando Docker para uso sin sudo..."

# Crear archivo de configuración Docker daemon
sudo mkdir -p /etc/docker
cat << EOF | sudo tee /etc/docker/daemon.json
{
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "10m",
    "max-file": "3"
  }
}
EOF

# Reiniciar Docker
sudo systemctl restart docker

# ==== CREAR SCRIPT DE PRUEBA ====
log_info "Creando script de prueba..."
cat << 'EOF' > test-docker.sh
#!/bin/bash
echo "🧪 Probando Docker..."
docker run --rm hello-world
echo ""
echo "🧪 Probando Docker Compose..."
docker compose version
echo ""
echo "🧪 Probando conexión a Docker daemon..."
docker ps
EOF

chmod +x test-docker.sh

# ==== INFORMACIÓN FINAL ====
echo ""
echo "========================================================"
echo -e "${GREEN}✅ INSTALACIÓN COMPLETADA EXITOSAMENTE${NC}"
echo "========================================================"
echo ""
echo "🐳 DOCKER:"
echo "   • Docker Engine instalado y configurado"
echo "   • Docker Desktop GUI disponible en aplicaciones"
echo "   • Docker Compose plugin instalado"
echo ""
echo "🍃 MONGODB:"
echo "   • MongoDB Compass instalado (GUI para conectar a Atlas)"
echo ""
echo "🔧 PRÓXIMOS PASOS:"
echo "   1. REINICIA tu sesión (logout/login) para usar Docker sin sudo"
echo "   2. Ejecuta: ./test-docker.sh para probar Docker"
echo "   3. Abre 'Docker Desktop' desde el menú de aplicaciones"
echo "   4. Abre 'MongoDB Compass' desde el menú de aplicaciones"
echo ""
echo "🌐 CONECTAR A MONGODB ATLAS:"
echo "   1. Abre MongoDB Compass"
echo "   2. En 'Connection String' pega tu URI de Atlas:"
echo "      mongodb+srv://<usuario>:<password>@<cluster>.mongodb.net/test"
echo "   3. Haz clic en 'Connect'"
echo ""
echo "📋 COMANDOS ÚTILES:"
echo "   • docker --version"
echo "   • docker compose version"
echo "   • docker ps"
echo "   • systemctl status docker"
echo ""
log_warn "⚠️  IMPORTANTE: Reinicia tu sesión para usar Docker sin sudo"